#include "die.h"
#include "debug.h"
#include "stringutil.h"
#include "plist.h"
#include "buffer.h"
#include "process_name.h"
#include "mode.h"

#include <signal.h>
#include <sys/syscall.h>
#include <stdlib.h>
#include <CoreFoundation/CoreFoundation.h>
#include <unistd.h>
#include <ctype.h>
#include <pthread.h>
#include <stdbool.h>

buffer_t* input_buffer = NULL;
pthread_mutex_t input_mutex = PTHREAD_MUTEX_INITIALIZER;

static char prompt[128];
static size_t prompt_capacity = 128;
pthread_mutex_t prompt_mutex = PTHREAD_MUTEX_INITIALIZER;

char* create_prompt_copy() {
    pthread_mutex_lock(&prompt_mutex);
    char* prompt_copy = malloc(strlen(prompt) + 1);
    strcpy(prompt_copy, prompt);
    pthread_mutex_unlock(&prompt_mutex);
    return prompt_copy;
}

buffer_t* get_input_buffer() {
    if (input_buffer == NULL) input_buffer = create_buffer();
    return input_buffer; 
}

CFDictionaryRef create_input_dictionary() {

    CFMutableDictionaryRef parameters = CFDictionaryCreateMutable(kCFAllocatorDefault, 5, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    if (parameters == NULL) die("failed to allocate dict for dialog parameters");

    CFStringRef cf_title_key = CFSTR("title");
    char* process_name = create_process_name();
    CFStringRef cf_title = cstr_2_cfstr(process_name);
    CFDictionaryAddValue(parameters, cf_title_key, cf_title);
    free(process_name);
    CFRelease(cf_title);

    char* prompt_copy = create_prompt_copy();
    CFStringRef dialog_prompt = cstr_2_cfstr((strlen(prompt) == 0) ? "The processing is requesting input:" : prompt);
    free(prompt_copy);
    CFDictionaryAddValue(parameters, CFSTR("prompt"), dialog_prompt);
    CFRelease(dialog_prompt);

    CFDictionaryAddValue(parameters, CFSTR("string"), CFSTR(""));

    CFDictionaryAddValue(parameters, CFSTR("button1"), CFSTR("Send"));
    CFDictionaryAddValue(parameters, CFSTR("button2"), CFSTR("Send EOF"));

    return parameters;
}

char * get_path() {

    char *path = getenv("DIALOG");
    if (path == NULL)
        die("Cannot execute tm_dialog, DIALOG is empty or not set");

    return path;
}

bool use_secure_nib() {
    pthread_mutex_lock(&prompt_mutex);
    bool should = (strcasestr(prompt, "password") != NULL);
    pthread_mutex_unlock(&prompt_mutex);
    return should;
}

char* get_nib() {
    return (use_secure_nib()) ? "RequestSecureString" : "RequestString";
}

int get_echo_fd() {
    char *echo_fd = getenv("TM_INTERACTIVE_INPUT_ECHO_FD");
    return (echo_fd == NULL) ? STDERR_FILENO : atoi(echo_fd);
}

CFStringRef get_return_argument_from_output_plist(CFPropertyListRef plist) {

    if (CFGetTypeID(plist) != CFDictionaryGetTypeID())
        die("root element of plist is not dictionary");

    CFDictionaryRef results;
    CFStringRef results_key = CFSTR("result");

    bool has_results = CFDictionaryGetValueIfPresent(plist, results_key, (void *)&results);
    CFRelease(results_key);

    if (!has_results) {
        D("plist has no result key, so returning nothing\n");
        return NULL;
    }

    if (CFGetTypeID(results) != CFDictionaryGetTypeID())
        die("results entry of output is not a dictionary");

    CFStringRef return_argument_key = CFSTR("returnArgument");
    CFStringRef return_argument;

    if (CFDictionaryGetValueIfPresent(results, return_argument_key, (void *)&return_argument)) {
        if (CFGetTypeID(return_argument) != CFStringGetTypeID())
            die("return value entry in results entry of output is not a string");
    } else {
        return_argument = CFSTR("");
    }
        
    CFRelease(return_argument_key);

    return return_argument;
}

void open_tm_dialog(int in[], int out[]) {

    enum {R,W,N};

    close(0);
    dup(in[R]);
    close(in[0]);
    close(in[1]);
    close(1);
    dup(out[W]);
    close(out[0]);
    close(out[1]);

    // Prevent tm_dialog from using our read() implementation
    unsetenv("DYLD_INSERT_LIBRARIES");
    unsetenv("DYLD_FORCE_FLAT_NAMESPACE");

    if (execl(get_path(), get_path(), "-m", get_nib(), NULL) < 0) 
        die("execl() failed, %s", strerror(errno));
}

buffer_t* create_user_input_from_output(buffer_t* output) {

    CFPropertyListRef plist = create_plist_from_buffer(output);
    buffer_t* input = NULL;

    CFStringRef return_argument = get_return_argument_from_output_plist(plist);
    if (return_argument != NULL) {
        input = create_buffer_from_cfstr(return_argument);
        add_to_buffer(input, "\n", 1);
    }

    CFRelease(plist);
    return input;
}

void get_input_from_user() {

    assert(input_buffer == NULL);

    // We do this now so we hit any errors before we attempt a fork.
    CFDictionaryRef parameters = create_input_dictionary();
    buffer_t* parameters_buffer = create_buffer_from_dictionary_as_xml(parameters);
    CFRelease(parameters);

    enum {R,W,N};
    int input[N],output[N];

    if (pipe(input) < 0) die("failed to create input pipe for tm_dialog");
    if (pipe(output) < 0) die("failed to create output pipe for tm_dialog");

    sig_t previous_sigchld_handler = signal(SIGCHLD, SIG_DFL);

    int child = fork();
    if (child < 0) die("failed to fork() for tm_dialog");

    if (child == 0) open_tm_dialog(input, output);

    // These aren't used.
    close(input[R]);
    close(output[W]);

    // Write our parameters to tm_dialog's input
    size_t bytes_written = write_buffer_to_fd(parameters_buffer, input[W]);
    if (bytes_written < get_buffer_size(parameters_buffer)) die("failed to write all of parameter input to tm_dialog");
    close(input[W]);
    destroy_buffer(parameters_buffer);

    // Read all of tm_dialog's output
    D("about to consume tm_dialog's output\n");
    buffer_t* output_buffer = create_buffer_from_file_descriptor(output[R]);
    close(output[R]);

    // Wait for tm_dialog to finish
    int return_code;

    D("about to wait ...\n");
    int waitError = wait(&return_code);
    if(waitError == -1)
        die("tm_dialog wait() failed: %s\n", strerror(errno));
    if (WEXITSTATUS(return_code) != 0)
        die("tm_dialog returned with code %d, output ... \n%s", WEXITSTATUS(return_code), create_cstr_from_buffer(output_buffer));

    signal(SIGCHLD, previous_sigchld_handler);

    input_buffer = create_user_input_from_output(output_buffer);
    destroy_buffer(output_buffer);
}

ssize_t tm_dialog_read(void *buffer, size_t buffer_length) {
    size_t consumed;
    
    pthread_mutex_lock(&input_mutex);
    if (input_buffer == NULL) {
        D("input_buffer == NULL, getting input from user\n");
        get_input_from_user();

        
        if (tm_interactive_input_is_in_echo_mode() && input_buffer != NULL) {
            int echo_fd = get_echo_fd();
            if (use_secure_nib()) {
                char *input_str = create_cstr_from_buffer(input_buffer);
                CFStringRef input_cfstr = cstr_2_cfstr(input_str);
                CFIndex char_count = CFStringGetLength(input_cfstr);
                free(input_str);
                CFRelease(input_cfstr);
                size_t i;
                for (i = 1; i < char_count; ++i) // Not <= because of \n on end
                    syscall(SYS_write, echo_fd, "*", 1);
                syscall(SYS_write, echo_fd, "\n", 1);
            } else {
                write_buffer_to_fd(input_buffer, echo_fd);
            }
        }
    }
    
    if (input_buffer == NULL) {
        D("input_buffer still == NULL, user entered nothing\n");
        consumed = 0;
    } else {
        D("reading %d into read buffer from input buffer\n", (int)buffer_length);
        consumed = consume_from_head_of_buffer(input_buffer, buffer, buffer_length);
        if (get_buffer_size(input_buffer) == 0) input_buffer = NULL;
    } 

    pthread_mutex_unlock(&input_mutex);
    return consumed;
}

void capture_for_prompt(const void *buffer, size_t buffer_length) {
    char storage[prompt_capacity];
    char *cbuffer = (char *)buffer;

    D("buffer_length = %d\n", (int)buffer_length);

    // Scan back past any white space.
    ssize_t i;
    for (i = buffer_length - 1; i >= 0 && isspace(cbuffer[i]); --i);
    D("i after scanning backwards past space = %d\n", (int)i);

    // Whole line was space
    if (i < 0) return;

    size_t x;
    for (x = 0; (x < (prompt_capacity - 1)) && i >= 0; ++x) {
        char c = cbuffer[i--];
        if (c == '\n') break;
        storage[x] = c;
    }
    D("reverse storage has %i bytes\n", (int)x + 1);

    --x;

    pthread_mutex_lock(&prompt_mutex);
    size_t z;
    for (z = 0; z <= x; ++z) {
        prompt[z] = storage[x - z];  
    }
    D("copied %i bytes from storage\n", (int)z + 1);
    prompt[z] = '\0';
    pthread_mutex_unlock(&prompt_mutex);

    D("prompt = '%s'\n", prompt);
}
