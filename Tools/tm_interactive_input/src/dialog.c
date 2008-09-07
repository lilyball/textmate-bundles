#include "die.h"
#include "debug.h"
#include "stringutil.h"
#include "plist.h"
#include "buffer.h"
#include "process_name.h"
#include "mode.h"
#include "system_function_overrides.h"

#include <signal.h>
#include <stdlib.h>
#include <CoreFoundation/CoreFoundation.h>
#include <unistd.h>
#include <ctype.h>
#include <pthread.h>
#include <stdbool.h>
#include <xlocale.h>

buffer_t* input_buffer = NULL;
pthread_mutex_t input_mutex = PTHREAD_MUTEX_INITIALIZER;

static char prompt[128];
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
                locale_t l = newlocale(LC_CTYPE_MASK, "", NULL);
                char const* str = get_buffer_data(input_buffer);
                int i, len = get_buffer_size(input_buffer);
                for(i = 0; i < len - 1; i += mblen_l(str + i, len - i, l))
                {
                    system_write("write", echo_fd, "*", 1);
                    if(mblen_l(str + i, len - i, l) <= 0) // encoding error
                        break;
                }
                system_write("write", echo_fd, "\n", 1);
                freelocale(l);
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
        if (get_buffer_size(input_buffer) == 0) {
            destroy_buffer(input_buffer);
            input_buffer = NULL;
        }
    }

    pthread_mutex_unlock(&input_mutex);
    return consumed;
}

void capture_for_prompt(const void *buffer, size_t buffer_length) {
	char const* cbuffer = buffer;
    D("buffer_length = %d\n", (int)buffer_length);

    // First skip trailing whitespace (including newlines)
	char const* to = cbuffer + buffer_length;
    while(to != cbuffer && isspace(to[-1]))
        --to;

    // Second search back for the begin-of-(last)-line
	char const* from = to;
    while(from != cbuffer && from[-1] != '\n')
        --from;

    // If we end with an empty string, do nothing (we probably have a prompt from a previous write)
    if(from == to)
        return;

    // Third, truncate line (by cutting head) if larger than prompt capacity
    if(to - from > sizeof(prompt)-1)
        from = to - (sizeof(prompt)-1);

    pthread_mutex_lock(&prompt_mutex);
    strncpy(prompt, from, to - from);
    prompt[to - from] = '\0';
    D("copied %i bytes to prompt\n", (int)to - from);
    pthread_mutex_unlock(&prompt_mutex);

    D("prompt = '%s'\n", prompt);
}
