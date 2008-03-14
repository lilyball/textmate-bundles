/*
 * tm_dialog_read
 * Luke Daley <ld at ldaley dot com>
 * 
 * A replacement for read() that invokes tm_dialog to get the stdin data if there is none waiting. 
 * 
 * The goal of this is to facilitate scripts/commands running via textmate that require user input 
 * to use tm_dialog to get the input, where typically the user would enter it on the command line.
 *
 * See the tm_dialog_read-help.md file that should accompany this source and library on how to use.
 */

#include "tm_dialog_read.h"

#include <sys/syscall.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include <CoreFoundation/CoreFoundation.h>
    
#ifndef TM_DIALOG_READ_DEBUG
//#define TM_DIALOG_READ_DEBUG
#endif

#ifndef DIALOG_ENV_VAR
#define DIALOG_ENV_VAR "DIALOG"
#endif

#ifndef DIALOG_NIB_ENV_VAR
#define DIALOG_NIB_ENV_VAR "DIALOG_NIB"
#endif

#ifndef DIALOG_NIB_DEFAULT
#define DIALOG_NIB_DEFAULT "RequestString"
#endif

#ifndef DIALOG_PROMPT_ENV_VAR
#define DIALOG_PROMPT_ENV_VAR "DIALOG_PROMPT"
#endif

#ifndef DIALOG_PROMPT_KEY
#define DIALOG_PROMPT_KEY "prompt"
#endif

#ifndef DIALOG_TITLE_ENV_VAR
#define DIALOG_TITLE_ENV_VAR "DIALOG_TITLE"
#endif

#ifndef DIALOG_TITLE_KEY
#define DIALOG_TITLE_KEY "title"
#endif

#ifndef DIALOG_STRING_ENV_VAR
#define DIALOG_STRING_ENV_VAR "DIALOG_STRING"
#endif

#ifndef DIALOG_STRING_KEY
#define DIALOG_STRING_KEY "string"
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

#ifndef TM_DIALOG_PROCESS_NAME
#define TM_DIALOG_PROCESS_NAME "tm_dialog"
#endif

#ifndef TM_DIALOG_OUTPUT_CHUNK_SIZE
#define TM_DIALOG_OUTPUT_CHUNK_SIZE 1024
#endif

#ifndef ERROR_BUFFER_SIZE
#define ERROR_BUFFER_SIZE 4096
#endif

#ifndef PROCESS_NAME_BUFFER_SIZE
#define PROCESS_NAME_BUFFER_SIZE 1024
#endif

/**
 * Prints a msg to standard out, then exits with code 1.
 * 
 * @param msg The message to be printed to the screen before dieing. 
 */
void die(char *msg) {
    fprintf(stderr, "tm_dialog_read failure: %s\n", msg);
    exit(1);
}

/**
 * Convenience method to add a string key and string value to a dictionary.
 */
void add_key_value_to_dictionary(CFMutableDictionaryRef dictionary, char* key, char* value) {
    
    CFStringRef cf_key = CFStringCreateWithCString(kCFAllocatorDefault, key, kCFStringEncodingMacRoman);
    if (cf_key == NULL) {
        char error[ERROR_BUFFER_SIZE];
        snprintf(error, ERROR_BUFFER_SIZE, "failed to create CFStringRef from '%s'", key);
        die(error);
    }
    
    CFStringRef cf_value = CFStringCreateWithCString(kCFAllocatorDefault, value, kCFStringEncodingUTF8);
    if (cf_value == NULL) {
        char error[ERROR_BUFFER_SIZE];
        snprintf(error, ERROR_BUFFER_SIZE, "failed to create CFStringRef from '%s'", value);
        die(error);
    }
    
    CFDictionaryAddValue(dictionary, cf_key, cf_value);
    CFRelease(cf_key);
    CFRelease(cf_value);
}

/**
 * Constructs an XML representation of a property list that forms the input to tm_dialog.
 * 
 * The property list is a dictionary of strings with 2 - 5 entries:
 *    button1 - The text of the button that sends input (value set by DIALOG_BUTTON_1)
 *    button2 - The text of the button that sends EOF (value set by DIALOG_BUTTON_2)
 *    title   - The title of the window (set by the DIALOG_TITLE_ENV_VAR if present)
 *    prompt  - The text prompt (set by the DIALOG_PROMPT_ENV_VAR if present)
 *    string  - The initial value of the input field (set by DIALOG_STRING_ENV_VAR if present)
 *    
 * The title, prompt and string entries are only in the dictionary if present.
 *
 * @return The property list as a char array, that must be free'd by the caller.
 */
char * get_tm_dialog_input() {
    
    CFMutableDictionaryRef parameters = CFDictionaryCreateMutable(kCFAllocatorDefault, 5, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    if (parameters == NULL) die("failed to allocate dict for dialog parameters");
    
    char *title = getenv(DIALOG_TITLE_ENV_VAR);
    if (title) add_key_value_to_dictionary(parameters, DIALOG_TITLE_KEY, title);
    
    char *prompt = getenv(DIALOG_PROMPT_ENV_VAR);
    if (prompt) add_key_value_to_dictionary(parameters, DIALOG_PROMPT_KEY, prompt); 
        
    char *string = getenv(DIALOG_STRING_ENV_VAR);
    if (string) add_key_value_to_dictionary(parameters, DIALOG_STRING_KEY, string); 

    add_key_value_to_dictionary(parameters, DIALOG_BUTTON_1_KEY, DIALOG_BUTTON_1); 
    add_key_value_to_dictionary(parameters, DIALOG_BUTTON_2_KEY, DIALOG_BUTTON_2);
     
    CFStringRef error;
    CFWriteStreamRef stream = CFWriteStreamCreateWithAllocatedBuffers(kCFAllocatorDefault, kCFAllocatorDefault);
    if (stream == NULL) die("failed to allocate for parameters property list write stream");
    if (!CFWriteStreamOpen(stream)) die("failed to open parameters property list write stream");
    
    CFPropertyListWriteToStream(parameters, stream, kCFPropertyListXMLFormat_v1_0, &error);
    
    if (error) {
        #ifdef TM_DIALOG_READ_DEBUG
            fputs("get_tm_dialog_input(): writing parameters property list to stream failed\n", stderr);
        #endif
	    
        char error_as_chars[ERROR_BUFFER_SIZE];
        
        if (!CFStringGetCString(error, error_as_chars, ERROR_BUFFER_SIZE, kCFStringEncodingMacRoman)) {
            die("converting tm_dialog_output to property list failed, and so did trying to get the failure message");
        } else {
            die("something went wrong writing the parameters property list to the stream, and we couldn't get the actual error");
        }
    }
    
    CFRelease(parameters);
    
    CFDataRef parameters_data = CFWriteStreamCopyProperty(stream, kCFStreamPropertyDataWritten);
    if (parameters_data == NULL) die("failed to extract data from parameters property list stream");
    
    CFIndex data_length = CFDataGetLength(parameters_data);
    char *parameters_chars = malloc(data_length);
    if (parameters_chars == NULL) die("failed to allocate char buffer for parameters property list");
    
    CFDataGetBytes(parameters_data, CFRangeMake(0, data_length), (UInt8 *)parameters_chars);
    CFRelease(parameters_data);
    
    #ifdef TM_DIALOG_READ_DEBUG
        fprintf(stderr, "get_tm_dialog_input(): %s\n", parameters_chars);
    #endif
    
    return parameters_chars;
}

/**
 * Returns the path to tm_dialog based on the env var which is the value of DIALOG_ENV_VAR.
 */
char * get_tm_dialog_path() {
    
    char *tm_dialog = getenv(DIALOG_ENV_VAR);
    if (tm_dialog == NULL || strlen(tm_dialog) == 0) {
        char error[ERROR_BUFFER_SIZE];
        snprintf(error, ERROR_BUFFER_SIZE, "Cannot execute tm_dialog, %s is empty or not set", DIALOG_ENV_VAR);
        die(error);
    }
        
    return tm_dialog;
}

/**
 * Returns the nib to use based on the value of DIALOG_NIB_ENV_VAR.
 */
char * get_tm_dialog_nib() {

    char *nib = getenv(DIALOG_NIB_ENV_VAR);
    if (nib == NULL || strlen(nib) == 0) {
        nib = DIALOG_NIB_DEFAULT;
    }

    return nib;
}

/**
 * Exhaustively reads the output of the already opened tm_dialog process.
 * 
 * @param tm_dialog The stdout of a tm_dialog process (must be open for reading)
 * @return The read output (must be free'd by caller)
 */
char * create_string_from_tm_dialog_output(int tm_dialog) {
    
    char *output_buffer = malloc(TM_DIALOG_OUTPUT_CHUNK_SIZE);
    if (output_buffer == NULL) die("failed to allocate initial buffer for tm_dialog output");
    ssize_t output_buffer_length = TM_DIALOG_OUTPUT_CHUNK_SIZE;
    
    char c;
    size_t i = 0;
    
    size_t bytes_read = syscall(SYS_read, tm_dialog, &c, 1);
    while (bytes_read > 0) {
        if (i == output_buffer_length) {
            output_buffer = realloc(output_buffer, output_buffer_length + TM_DIALOG_OUTPUT_CHUNK_SIZE);
            if (output_buffer == NULL) die("failed to increase allocation for tm_dialogoutput buffer");
            output_buffer_length = output_buffer_length + TM_DIALOG_OUTPUT_CHUNK_SIZE;
        }
        
        output_buffer[i++] = c;
        bytes_read = syscall(SYS_read, tm_dialog, &c, 1);
    }
    
    if (i++ == output_buffer_length) {
        output_buffer = realloc(output_buffer, output_buffer_length + 1);
        if (output_buffer == NULL) die("failed to increase allocation for tm_dialogoutput buffer");
        output_buffer_length = output_buffer_length + 1;
    }
    
    output_buffer[i] = '\0';
    
    #ifdef TM_DIALOG_READ_DEBUG
        fprintf(stderr, "create_string_from_tm_dialog_output(): %s\n", output_buffer);
    #endif
    
    return output_buffer;
} 

/**
 * Takes the output from tm_dialog and attempts to construct a property list from it.
 * If the property list cannot be created for any reason we will exit fatally.
 * 
 * @param tm_dialog_output The output of tm_dialog in it's entirety
 * @return A plist object that must be free'd by the caller.
 */
CFPropertyListRef create_plist_from_tm_dialog_output_string(char *tm_dialog_output) {
    
    #ifdef TM_DIALOG_READ_DEBUG
        fputs("create_plist_from_tm_dialog_output_string(): converting output to data\n", stderr);
    #endif
    
    CFDataRef tm_dialog_output_data = CFDataCreate(kCFAllocatorDefault, (UInt8*)tm_dialog_output, strlen(tm_dialog_output));
    if (tm_dialog_output_data == NULL) die("failed to allocate tm_dialog_output_data");
    
    #ifdef TM_DIALOG_READ_DEBUG
        fputs("create_plist_from_tm_dialog_output_string(): creating property list from data\n", stderr);
    #endif
    
	CFStringRef error = NULL;
	CFPropertyListRef plist = CFPropertyListCreateFromXMLData(kCFAllocatorDefault, tm_dialog_output_data, kCFPropertyListImmutable, &error);

	if (error) {
	    
	    #ifdef TM_DIALOG_READ_DEBUG
            fputs("create_plist_from_tm_dialog_output_string(): creating property list failed\n", stderr);
        #endif
	    
        char error_as_chars[ERROR_BUFFER_SIZE];
        
        if (!CFStringGetCString(error, error_as_chars, ERROR_BUFFER_SIZE, kCFStringEncodingMacRoman)) {
            die("converting tm_dialog_output to property list failed, and so did trying to get the failure message");
        }
            
        die(error_as_chars);
	}
    
    CFRelease(tm_dialog_output_data);
    
    return plist;
}

/**
 * Given the return plist from tm_dialog, attempts to copy the value of the input into the buffer.
 * If the root element of the plist is not a dictionary, we will exit fatally.
 * Also, if the plist has an entry under the key denoted by DIALOG_RESULT_KEY then there is expected 
 * to be input, otherwise we return 0 (effectively signifying that there was no input). 
 * Otherwise, we look for the DIALOG_RETURN_ARGUMENT_KEY entry which is expected to contain 
 * a string which is the input.
 *   
 * @param plist The plist that tm_dialog output
 * @param buffer The copy destination
 * @param buffer_length The limit of chars to copy
 * @return the number of bytes copied into buffer
 */
ssize_t copy_input_from_plist_into_buffer(CFPropertyListRef plist, char *buffer, size_t buffer_length) {
    
    if (CFGetTypeID(plist) != CFDictionaryGetTypeID()) 
        die("get_return_argument_element_from_plist(): root element of plist is not dictionary");
    
    CFStringRef results_key = CFStringCreateWithCString(kCFAllocatorDefault, DIALOG_RESULT_KEY, kCFStringEncodingMacRoman);
    CFDictionaryRef results;
    
    bool has_results = CFDictionaryGetValueIfPresent(plist, results_key, (void *)&results);
    CFRelease(results_key);
    
    if (!has_results) { 
        #ifdef TM_DIALOG_READ_DEBUG
            fprintf(stderr, "get_return_argument_element_from_plist(): plist has no %s key, so returning nothing\n", DIALOG_RESULT_KEY);
        #endif
        return 0; // EOF    
    }
                
    if (CFGetTypeID(results) != CFDictionaryGetTypeID()) 
        die("results entry of output is not a dictionary");
    
    CFStringRef return_argument_key = CFStringCreateWithCString(kCFAllocatorDefault, DIALOG_RETURN_ARGUMENT_KEY, kCFStringEncodingMacRoman);
    CFStringRef return_argument;
    
    if (!CFDictionaryGetValueIfPresent(results, return_argument_key, (void *)&return_argument)) 
        die("results entry of output does not contain an entry for return value");
        
    if (CFGetTypeID(return_argument) != CFStringGetTypeID()) 
        die("return value entry in results entry of output is not a string");
    
    CFRelease(return_argument_key);
    
    #ifdef TM_DIALOG_READ_DEBUG
        fprintf(stderr, "copy_input_into_buffer(): copying return argument into original buffer\n");
    #endif
    
    CFIndex return_argument_length = CFStringGetLength(return_argument);
    CFIndex copy_count;
    CFRange copy_range;
    
    copy_range.location = 0;
    copy_range.length = (return_argument_length > buffer_length) ? buffer_length : return_argument_length;
    
    if (0 == CFStringGetBytes(return_argument, copy_range, kCFStringEncodingUTF8, 0, false, (UInt8 *)buffer, buffer_length, &copy_count)) {
        die("failed to copy return argument into buffer");
    }
    
    if (copy_count < buffer_length) { 
        buffer[copy_count++] = '\n';
    } else { 
        buffer[copy_count - 1] = '\n';
    }
    
    #ifdef TM_DIALOG_READ_DEBUG
        fprintf(stderr, "copy_input_into_buffer(): buffer after copy == '%s'\n", buffer);
    #endif
    
    return copy_count;
}

/**
 * Attempts to launch tm_dialog in order to get an input string from the user.
 * <p>
 * tm_dialog is launched by forking, setting up file descriptors for stdin and stdout, then executing tm_dialog.
 * 
 * @see get_tm_dialog_input()
 * @see create_string_from_tm_dialog_output()
 * @see create_plist_from_tm_dialog_output_string()
 * @see copy_input_from_plist_into_buffer()
 * @param buffer The destination of the input
 * @param buffer_length The limit of chars to copy
 * @return the number of bytes copied into buffer
 */
ssize_t tm_dialog_read(void *buffer, size_t buffer_length) {

    // We do this now so we hit any errors before we attempt a fork.
    char *tm_dialog_input = get_tm_dialog_input();
    int tm_dialog_input_length = strlen(tm_dialog_input);
    
    enum {R,W,N};
    int input[N],output[N];
    
    if (pipe(input) < 0) die("failed to create input pipe for tm_dialog");
    if (pipe(output) < 0) die("failed to create output pipe for tm_dialog");
    
    int child = fork();
    if (child < 0) die("failed to fork() for tm_dialog");
    
    if (child == 0) {
        close(0); 
        dup(input[R]); 
        close(input[0]); 
        close(input[1]);
        close(1); 
        dup(output[W]); 
        close(output[0]); 
        close(output[1]);

        // Prevent tm_dialog from using our read() implementation
        unsetenv("DYLD_INSERT_LIBRARIES");
        unsetenv("DYLD_FORCE_FLAT_NAMESPACE");

        if (execl(get_tm_dialog_path(), "-q", get_tm_dialog_nib(), NULL) < 0) {
            char error[ERROR_BUFFER_SIZE];
            snprintf(error, ERROR_BUFFER_SIZE, "execl() failed, %s", strerror(errno));
            die(error);
        }
    } else {
        close(input[R]); 
        close(output[W]);
        
        size_t bytes_written = write(input[W], tm_dialog_input, tm_dialog_input_length);
        if (bytes_written < tm_dialog_input_length) die("failed to write all of parameter input to tm_dialog");
        close(input[W]);
        free(tm_dialog_input);
        
        char *tm_dialog_output = create_string_from_tm_dialog_output(output[R]);
        close(output[R]);
        
        int tm_dialog_return_code;
        wait(&tm_dialog_return_code);
        if (tm_dialog_return_code) {
            char error[ERROR_BUFFER_SIZE];
            snprintf(error, ERROR_BUFFER_SIZE, "tm_dialog returned with code %d, output: %s", tm_dialog_return_code, tm_dialog_output);
            die(error);
        }

        CFPropertyListRef plist;
        plist = create_plist_from_tm_dialog_output_string(tm_dialog_output);
        free(tm_dialog_output);

        ssize_t bytes_read = copy_input_from_plist_into_buffer(plist, buffer, buffer_length);
        CFRelease(plist);

        return bytes_read;
    }
}

/**
 * This replaces the system read() function.
 * <p>
 * The overall goal here is to us tm_dialog to get the input from the user if 
 * the following conditions are met:
 * <ul>
 *     <li>we are wanting to read from stdin
 *     <li>we are *not* requesting a non blocking read
 *     <li>stdin has no data available
 * </ul>    
 * If we aren't reading from stdin, then we just fallback to the normal read() impl.
 * To see if stdin has data, we do a non blocking read using the normal read() impl, 
 * if it returns data, then we give that back. Otherwise, we call tm_dialog_read.
*/
ssize_t read(int d, void *buffer, size_t buffer_length) {
    
    // Only interested in STDIN
    if (d != STDIN_FILENO) return syscall(SYS_read, d, buffer, buffer_length);
    
    // It doesn't make sense to invoke tm_dialog if the caller wanted a non blocking read
    if (fcntl(d, F_GETFL) & O_NONBLOCK) return syscall(SYS_read, d, buffer, buffer_length);

    fcntl(d, F_SETFL, O_NONBLOCK);
    ssize_t bytes_read = syscall(SYS_read, d, buffer, buffer_length);

    #ifdef TM_DIALOG_READ_DEBUG
        fprintf(stderr, "read(): syscall returned %d bytes\n", bytes_read);
    #endif

    if (bytes_read < 0) {
        char error[ERROR_BUFFER_SIZE];
        snprintf(error, ERROR_BUFFER_SIZE, "read syscall produced error: '%s'", bytes_read, strerror(errno));
        die(error);
    }
    
    return (bytes_read > 0) ? bytes_read : tm_dialog_read(buffer, buffer_length);
}

ssize_t	read_unix2003(int d, void *buffer, size_t buffer_length) {
	return read(d, buffer, buffer_length);
}

ssize_t read_nocancel_unix2003(int d, void *buffer, size_t buffer_length) {
	return read(d, buffer, buffer_length);	
}