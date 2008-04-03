#include "die.h"
#include "debug.h"
#include "stringutil.h"
#include "plist.h"
#include "buffer.h"

#include <signal.h>
#include <sys/syscall.h>
#include <stdlib.h>
#include <CoreFoundation/CoreFoundation.h>
#include <unistd.h>
#include <ctype.h>
#include <pthread.h>

#ifndef MODE_SPECIFIER_ENV_VAR
#define MODE_SPECIFIER_ENV_VAR "TM_INTERACTIVE_INPUT"
#endif

#ifndef ALWAYS_MODE
#define ALWAYS_MODE "ALWAYS"
#endif

#ifndef AUTO_MODE
#define AUTO_MODE "AUTO"
#endif

#ifndef NEVER_MODE
#define NEVER_MODE "NEVER"
#endif

#ifndef DIALOG_ENV_VAR
#define DIALOG_ENV_VAR "DIALOG"
#endif

#ifndef DIALOG_NIB_DEFAULT
#define DIALOG_NIB_DEFAULT "RequestString"
#endif

#ifndef DIALOG_NIB_SECURE
#define DIALOG_NIB_SECURE "RequestSecureString"
#endif

#ifndef DIALOG_TITLE_ENV_VAR
#define DIALOG_TITLE_ENV_VAR "DIALOG_TITLE"
#endif

#ifndef DIALOG_TITLE_KEY
#define DIALOG_TITLE_KEY "title"
#endif

#ifndef DIALOG_PROMPT_KEY
#define DIALOG_PROMPT_KEY "prompt"
#endif

#ifndef DIALOG_BUTTON_1
#define DIALOG_BUTTON_1 "Send"
#endif

#ifndef DIALOG_BUTTON_1_KEY
#define DIALOG_BUTTON_1_KEY "button1"
#endif

#ifndef DIALOG_BUTTON_2
#define DIALOG_BUTTON_2 "Send EOF"
#endif

#ifndef DIALOG_BUTTON_2_KEY
#define DIALOG_BUTTON_2_KEY "button2"
#endif

#ifndef DIALOG_RESULT_KEY
#define DIALOG_RESULT_KEY "result"
#endif

#ifndef DIALOG_RETURN_ARGUMENT_KEY
#define DIALOG_RETURN_ARGUMENT_KEY "returnArgument"
#endif

#ifndef PROMPT_SIZE
#define PROMPT_SIZE 64
#endif

#ifndef FALLBACK_PROMPT
#define FALLBACK_PROMPT "The processing is requesting input:"
#endif

buffer_t* input_buffer = NULL;

static char prompt[PROMPT_SIZE];
pthread_mutex_t prompt_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t input_mutex = PTHREAD_MUTEX_INITIALIZER;

char *mode = NULL;

bool is_active = false;
bool is_active_is_set = false;

bool is_used_always = false;
bool is_used_always_is_set = false;

char* get_mode() {
    if (mode == NULL) {
        mode = getenv(MODE_SPECIFIER_ENV_VAR);
        if (mode == NULL) mode = NEVER_MODE;
    }
    return mode;
}

bool tm_dialog_read_is_active() {
    if (!is_active_is_set) {
        is_active = (strcmp(get_mode(), NEVER_MODE) != 0) ? true : false;
        is_active_is_set = true;
    }
    return is_active;
}

bool tm_dialog_read_is_used_always() {
    if (!is_used_always_is_set) {
        is_used_always = strcmp(get_mode(), ALWAYS_MODE) == 0;
    }
    return is_used_always;
}

/**
 * After locking the prompt_mutex, creates a copy of the prompt and returns it after
 * unlocking prompt_mutex.
 * 
 * @return A copy of the prompt that must be freed by the caller.
 */
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

/**
 * Constructs the input parameters for tm_dialog.
 * 
 * @return The input dictionary.
 */
CFDictionaryRef create_input_dictionary() {

    CFMutableDictionaryRef parameters = CFDictionaryCreateMutable(kCFAllocatorDefault, 5, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    if (parameters == NULL) die("failed to allocate dict for dialog parameters");

    char *title = getenv(DIALOG_TITLE_ENV_VAR);
    if (title) {
        CFStringRef cf_title_key = CFSTR(DIALOG_TITLE_KEY);
        CFStringRef cf_title = cstr_2_cfstr(title);
        CFDictionaryAddValue(parameters, cf_title_key, cf_title);
        CFRelease(cf_title);
    }
    
	char* prompt_copy = create_prompt_copy();
    CFStringRef dialog_prompt = cstr_2_cfstr((strlen(prompt) == 0) ? FALLBACK_PROMPT : prompt);
	free(prompt_copy);
    CFDictionaryAddValue(parameters, CFSTR(DIALOG_PROMPT_KEY), dialog_prompt);
    CFRelease(dialog_prompt);

    CFDictionaryAddValue(parameters, CFSTR(DIALOG_BUTTON_1_KEY), CFSTR(DIALOG_BUTTON_1));
    CFDictionaryAddValue(parameters, CFSTR(DIALOG_BUTTON_2_KEY), CFSTR(DIALOG_BUTTON_2));
    
    return parameters;
}

/**
 * tm_dialog path
 * 
 * If the env var denoted by DIALOG_ENV_VAR is not present, we exit fatally.
 * 
 * @return The path to tm_dialog
 */
char * get_path() {
 
    char *path = getenv(DIALOG_ENV_VAR);
    if (path == NULL)
        die("Cannot execute tm_dialog, %s is empty or not set", DIALOG_ENV_VAR);
 
    return path;
}

/**
 * Returns the nib to use based on whether the prompt contains 'password' or not.
 * 
 * The prompt is case insensitively searched for 'password', if it is found DIALOG_NIB_SECURE
 * is returned, otherwise DIALOG_NIB_DEFAULT.
 *
 * This acquires a lock on prompt_mutex before searching the prompt.
 * 
 * @return The nib argument for tm_dialog
 */
char* get_nib() {
    pthread_mutex_lock(&prompt_mutex);
    char *nib = (strcasestr(prompt, "password") == NULL) ? DIALOG_NIB_DEFAULT : DIALOG_NIB_SECURE;
    pthread_mutex_unlock(&prompt_mutex);
    return nib;
}

/**
 * Given the return plist from tm_dialog, extracts the result -> returnArgument item.
 * If the root element of the plist is not a dictionary, we will exit fatally.
 *
 * @param plist tm_dialog's output plist
 * @return The return argument item, or NULL if it doesn't exist
 */
CFStringRef get_return_argument_from_output_plist(CFPropertyListRef plist) {
 
    if (CFGetTypeID(plist) != CFDictionaryGetTypeID())
        die("get_return_argument_element_from_plist(): root element of plist is not dictionary");
     
    CFDictionaryRef results;
    CFStringRef results_key = CFSTR(DIALOG_RESULT_KEY);
 
    bool has_results = CFDictionaryGetValueIfPresent(plist, results_key, (void *)&results);
    CFRelease(results_key);
 
    if (!has_results) {
        D("get_return_argument_element_from_plist(): plist has no %s key, so returning nothing\n", DIALOG_RESULT_KEY);
        return NULL;
    }
 
    if (CFGetTypeID(results) != CFDictionaryGetTypeID())
        die("results entry of output is not a dictionary");
 
    CFStringRef return_argument_key = CFSTR(DIALOG_RETURN_ARGUMENT_KEY);
    CFStringRef return_argument;
 
    if (!CFDictionaryGetValueIfPresent(results, return_argument_key, (void *)&return_argument))
        die("results entry of output does not contain an entry for return value");

    CFRelease(return_argument_key);
 
    if (CFGetTypeID(return_argument) != CFStringGetTypeID())
        die("return value entry in results entry of output is not a string");
 
    return return_argument;
}

/**
 * Uses execl() to launch tm_dialog.
 * 
 * @see get_path()
 * @see get_nib()
 * @param in The input pipe to use
 * @param out The output pipe to use
 */
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

    if (execl(get_path(), get_path(), "-q", get_nib(), NULL) < 0) 
        die("execl() failed, %s", strerror(errno));
}

/**
 * Extracts the user's input from tm_dialog's output.
 * 
 * If the output contains a return argument, then we copy that *and* append a newline to
 * buffer. This makes sense as it more closely aligns with how users input data on the 
 * command line.
 * 
 * @see create_plist_from_buffer()
 * @see get_return_argument_from_output_plist()
 * @param output A buffer of valid tm_dialog output
 * @param buffer The destination for the input
 * @param buffer_length The maximum size of buffer
 * @return The number of bytes written to buffer
 */
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
    buffer_t* parameters_buffer = create_buffer_of_dictionary_as_xml(parameters);
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
    size_t bytes_written = write(input[W], parameters_buffer->data, parameters_buffer->size);
    if (bytes_written < parameters_buffer->size) die("failed to write all of parameter input to tm_dialog");
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

/**
 * Attempts to launch tm_dialog in order to get an input string from the user.
 *
 * tm_dialog is launched by forking, setting up file descriptors for stdin and stdout, then executing tm_dialog.
 *
 * @see create_input_dictionary()
 * @see open_tm_dialog()
 * @see get_user_input_from_output()
 * @param buffer The destination of the input
 * @param buffer_length The limit of chars to copy
 * @return the number of bytes copied into buffer
 */
ssize_t tm_dialog_read(void *buffer, size_t buffer_length) {
	pthread_mutex_lock(&input_mutex);
	if (input_buffer == NULL) {
		D("input_buffer == NULL, getting input from user\n");
		get_input_from_user();
	}
	if (input_buffer == NULL) {
		D("input_buffer still == NULL, user entered nothing\n");
		return 0;
	} 
	
	D("reading %d into read buffer from input buffer\n", (int)buffer_length);
	size_t consumed = consume_from_head_of_buffer(input_buffer, buffer, buffer_length);
	if (input_buffer->size == 0) input_buffer = NULL;
	pthread_mutex_unlock(&input_mutex);
	return consumed;
}

void capture_for_prompt(const void *buffer, size_t buffer_length) {
    char storage[PROMPT_SIZE];
    char *cbuffer = (char *)buffer;

    D("capture_for_prompt(): buffer_length = %d\n", (int)buffer_length);
    
    // Scan back past any white space.
    ssize_t i;
    for (i = buffer_length; i >= 0 && isspace(cbuffer[i - 1]); --i);
    D("capture_for_prompt(): i after scanning backwards past space = %d\n", (int)i);
    
    // Whole line was space
    if (i <= 0) return;
    
    size_t x;
    for (x = 0; (x < (PROMPT_SIZE - 1)) && i > 0; ++x) {
        char c = cbuffer[--i];
        if (c == '\n') break;
        storage[x] = c;
    }
    D("capture_for_prompt(): reverse storage has %i bytes\n", (int)x + 1);
    
    --x;

	pthread_mutex_lock(&prompt_mutex);
    size_t z;
    for (z = 0; z <= x; ++z) {
        prompt[z] = storage[x - z];  
    }
    D("capture_for_prompt(): copied %i bytes from storage\n", (int)z + 1);
    prompt[z] = '\0';
    pthread_mutex_unlock(&prompt_mutex);

    D("capture_for_prompt(): prompt = '%s'\n", prompt);
}
