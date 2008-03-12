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

extern char **environ;
    
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

/*
    Simply prints an error message then exits with status code 1
*/
void die(char *msg) {
    fprintf(stderr, "tm_dialog_read failure: %s", msg);
    exit(1);
}

/*
    Constructs an XML representation (as char *) of a property that forms the input to tm_dialog.
    
    The property list is a dictionary of strings with 2 - 5 entries:
        button1 - The text of the button that sends input (value set by DIALOG_BUTTON_1)
        button2 - The text of the button that sends EOF (value set by DIALOG_BUTTON_2)
        title   - The title of the window (set by the DIALOG_TITLE_ENV_VAR if present)
        prompt  - The text prompt (set by the DIALOG_PROMPT_ENV_VAR if present)
        string  - The initial value of the input field (set by DIALOG_STRING_ENV_VAR if present)
        
    The title, prompt and string entries are only in the dictionary if present.
    
    The return char * must be free'd by the caller.
*/
char * get_tm_dialog_input() {
    
    CFMutableDictionaryRef parameters = CFDictionaryCreateMutable(kCFAllocatorDefault, 5, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    if (parameters == NULL) die("failed to allocate dict for dialog parameters");
    
    char *title_env_value = getenv(DIALOG_TITLE_ENV_VAR);
    if (title_env_value) {
        
        CFStringRef title_key = CFStringCreateWithCString(kCFAllocatorDefault, DIALOG_TITLE_KEY, kCFStringEncodingMacRoman);
        if (title_key == NULL) die("Failed to create string for title key");
        
        CFStringRef title = CFStringCreateWithCString(kCFAllocatorDefault, title_env_value, kCFStringEncodingUTF8);
        if (title == NULL) die("Failed to create string from title env var");
        
        CFDictionaryAddValue(parameters, title_key, title);
        CFRelease(title_key);
        CFRelease(title);
    }
    
    char *prompt_env_value = getenv(DIALOG_PROMPT_ENV_VAR);
    if (prompt_env_value) {
        
        CFStringRef prompt_key = CFStringCreateWithCString(kCFAllocatorDefault, DIALOG_PROMPT_KEY, kCFStringEncodingMacRoman);
        if (prompt_key == NULL) die("Failed to create string for prompt key");
        
        CFStringRef prompt = CFStringCreateWithCString(kCFAllocatorDefault, prompt_env_value, kCFStringEncodingUTF8);
        if (prompt == NULL) die("Failed to create string from prompt env var");
        
        CFDictionaryAddValue(parameters, prompt_key, prompt);
        CFRelease(prompt_key);
        CFRelease(prompt);
    }

    char *string_env_value = getenv(DIALOG_STRING_ENV_VAR);
    if (string_env_value) {
        
        CFStringRef string_key = CFStringCreateWithCString(kCFAllocatorDefault, DIALOG_STRING_KEY, kCFStringEncodingMacRoman);
        if (string_key == NULL) die("Failed to create string for string key");
        
        CFStringRef string = CFStringCreateWithCString(kCFAllocatorDefault, string_env_value, kCFStringEncodingUTF8);
        if (string == NULL) die("Failed to create string from string env var");
        
        CFDictionaryAddValue(parameters, string_key, string);
        CFRelease(string_key);
        CFRelease(string);
    }

    CFStringRef button1_key = CFStringCreateWithCString(kCFAllocatorDefault, DIALOG_BUTTON_1_KEY, kCFStringEncodingMacRoman);
    if (button1_key == NULL) die("Failed to create string for button1 key");
    
    CFStringRef button1 = CFStringCreateWithCString(kCFAllocatorDefault, DIALOG_BUTTON_1, kCFStringEncodingMacRoman);
    if (button1 == NULL) die("Failed to create string for button1 value");
    
    CFDictionaryAddValue(parameters, button1_key, button1);
    CFRelease(button1_key);
    CFRelease(button1);

    CFStringRef button2_key = CFStringCreateWithCString(kCFAllocatorDefault, DIALOG_BUTTON_2_KEY, kCFStringEncodingMacRoman);
    if (button2_key == NULL) die("Failed to create string for button2 key");
    
    CFStringRef button2 = CFStringCreateWithCString(kCFAllocatorDefault, DIALOG_BUTTON_2, kCFStringEncodingMacRoman);
    if (button2 == NULL) die("Failed to create string for button2 value");
    
    CFDictionaryAddValue(parameters, button2_key, button2);
    CFRelease(button2_key);
    CFRelease(button2);
    
    CFStringRef error;
    CFWriteStreamRef stream = CFWriteStreamCreateWithAllocatedBuffers(kCFAllocatorDefault, kCFAllocatorDefault);
    if (stream == NULL) die("failed to allocate for parameters property list write stream");
    if (!CFWriteStreamOpen(stream)) die("failed to open parameters property list write stream");
    
    CFPropertyListWriteToStream(parameters, stream, kCFPropertyListXMLFormat_v1_0, &error);
    
    if (error) {
        #ifdef TM_DIALOG_READ_DEBUG
            fputs("get_tm_dialog_input(): writing parameters property list to stream failed", stderr);
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

/*
    Constructs the command to use to invoke tm_dialog
    
    The command is based on two env vars, the values of DIALOG_ENV_VAR and DIALOG_NIB_ENV_VAR.
    Both of these must be set for this to succeed, otherwise we exit fatally.
    
    We are also currently invoking tm_dialog with -q.
    
    The caller is responsible for freeing the returned char *.
*/
char * get_tm_dialog_path() {
    
    char error[ERROR_BUFFER_SIZE];
    
    char *tm_dialog = getenv(DIALOG_ENV_VAR);
    if (tm_dialog == NULL || strlen(tm_dialog) == 0) {
        snprintf(error, ERROR_BUFFER_SIZE, "Cannot execute tm_dialog, %s is empty or not set", DIALOG_ENV_VAR);
        die(error);
    }
        
    return tm_dialog;
}

char * get_tm_dialog_nib() {

    char *nib = getenv(DIALOG_NIB_ENV_VAR);
    if (nib == NULL || strlen(nib) == 0) {
        nib = DIALOG_NIB_DEFAULT;
    }

    return nib;
}

/*
    Exhaustively reads the output of the already opened tm_dialog process.
    
    The caller is responsible for freeing the result.
*/
char * get_tm_dialog_output(int tm_dialog) {
    
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
        fprintf(stderr, "get_tm_dialog_output(): %s", output_buffer);
    #endif
    
    return output_buffer;
} 

/*
    Takes the output from tm_dialog and attempts to construct a property list from it.
    
    If the property list cannot be created for any reason we will exit fatally.
    
    The caller is responsible for releasing the result.
*/
CFPropertyListRef convert_tm_dialog_output_to_plist(char *tm_dialog_output) {
    
    #ifdef TM_DIALOG_READ_DEBUG
        fputs("convert_tm_dialog_output_to_plist(): converting output to data", stderr);
    #endif
    
    CFDataRef tm_dialog_output_data = CFDataCreate(kCFAllocatorDefault, (UInt8*)tm_dialog_output, strlen(tm_dialog_output));
    if (tm_dialog_output_data == NULL) die("failed to allocate tm_dialog_output_data");
    
    #ifdef TM_DIALOG_READ_DEBUG
        fputs("convert_tm_dialog_output_to_plist(): creating property list from data", stderr);
    #endif
    
	CFStringRef error = NULL;
	CFPropertyListRef plist = CFPropertyListCreateFromXMLData(kCFAllocatorDefault, tm_dialog_output_data, kCFPropertyListImmutable, &error);

	if (error) {
	    
	    #ifdef TM_DIALOG_READ_DEBUG
            fputs("convert_tm_dialog_output_to_plist(): creating property list failed", stderr);
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

/*
    Copies the return_argument into buffer, taking buffer_length into consideration.
    
    NOTE: We are adding a \n to the value here.
    
    Returns the number chars actually copied.
*/
ssize_t copy_return_argument_into_buffer(CFStringRef return_argument, char *buffer, ssize_t buffer_length) {
    
    #ifdef TM_DIALOG_READ_DEBUG
        fprintf(stderr, "copy_return_argument_into_buffer(): copying return argument into original buffer\n");
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
        
    return copy_count;
}

/*
    Given the return plist from tm_dialog, attempts to copy the value of the input into the buffer.
    
    This is relying on the root element of the plist being a dictionary.
    
    If the plist has an entry under the key DIALOG_RESULT_KEY then there is expected to be input,
    otherwise we return 0 (effectively signifying that there was no input). Otherwise, we look for
    the DIALOG_RETURN_ARGUMENT_KEY entry which is expected to contain a string which is the input.
    
    If the return argument is there, then we pass it to copy_return_argument_into_buffer() to
    get it as chars.
*/
ssize_t extract_input_from_plist(CFPropertyListRef plist, char *buffer, size_t buffer_length) {
    
    if (CFGetTypeID(plist) != CFDictionaryGetTypeID()) 
        die("extract_input_from_plist(): root element of plist is not dictionary");
    
    CFStringRef results_key = CFStringCreateWithCString(kCFAllocatorDefault, DIALOG_RESULT_KEY, kCFStringEncodingMacRoman);
    CFDictionaryRef results;
    
    if (CFDictionaryGetValueIfPresent(plist, results_key, (void *)&results)) {
                
        if (CFGetTypeID(results) != CFDictionaryGetTypeID()) 
            die("results entry of output is not a dictionary");
        
        CFRelease(results_key);
        
        CFStringRef return_argument_key = CFStringCreateWithCString(kCFAllocatorDefault, DIALOG_RETURN_ARGUMENT_KEY, kCFStringEncodingMacRoman);
        CFStringRef return_argument;
        
        if (CFDictionaryGetValueIfPresent(results, return_argument_key, (void *)&return_argument)) {
            
            if (CFGetTypeID(return_argument) != CFStringGetTypeID()) 
                die("return value entry in results entry of output is not a string");
            
            CFRelease(return_argument_key);
            
            return copy_return_argument_into_buffer(return_argument, buffer, buffer_length);
        } else {
            die("results entry of output does not contain an entry for return value");
        } 
        
    } else {
        #ifdef TM_DIALOG_READ_DEBUG
            fprintf(stderr, "extract_input_from_plist(): plist has no %s key, so returning nothing", DIALOG_RESULT_KEY);
        #endif
        CFRelease(results_key);
        return 0; // EOF
    }
    
    die("We should never get here!");
    return 0; // keep compiler happy
}

/*
    Attempts to invoke tm_dialog in order to get input from the user.
*/
ssize_t read_using_tm_dialog(void *buffer, size_t buffer_length) {

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

        unsetenv("DYLD_INSERT_LIBRARIES");
        unsetenv("DYLD_FORCE_FLAT_NAMESPACE");

        if (0 > execl(get_tm_dialog_path(), "-q", get_tm_dialog_nib(), NULL)) {
            char error[ERROR_BUFFER_SIZE];
            snprintf(error, ERROR_BUFFER_SIZE, "execve() failed, %s", strerror(errno));
            die(error);
        }
    } else {
        close(input[R]); 
        close(output[W]);
        
        size_t bytes_written = write(input[W], tm_dialog_input, tm_dialog_input_length);
        if (bytes_written < tm_dialog_input_length) die("failed to write all of parameter input to tm_dialog");
        close(input[W]);
        free(tm_dialog_input);
        
        char *tm_dialog_output = get_tm_dialog_output(output[R]);
        close(output[R]);
        
        int tm_dialog_return_code;
        wait(&tm_dialog_return_code);
        if (tm_dialog_return_code) {
            char error[ERROR_BUFFER_SIZE];
            snprintf(error, ERROR_BUFFER_SIZE, "tm_dialog returned with code %d, output: %s", tm_dialog_return_code, tm_dialog_output);
            die(error);
        }

        CFPropertyListRef plist;
        plist = convert_tm_dialog_output_to_plist(tm_dialog_output);
        free(tm_dialog_output);

        ssize_t bytes_read;
        bytes_read = extract_input_from_plist(plist, buffer, buffer_length);
        CFRelease(plist);

        return bytes_read;
    }
}

/*
    This replaces the read() function provided by the system.
    
    The overall goal here is to us tm_dialog to get the input from the user if 
    the following conditions are met:
        - we are wanting to read from stdin
        - stdin has no data available
        - this is not being called by tm_dialog itself
    
    If we aren't reading from stdin, then we just fallback to the normal read() impl.
    
    To see if stdin has data, we do a non blocking read using the normal read() impl, if it 
    returns data, then we give that back.
    
    If the current process is actually tm_dialog, and there isn't stdin data waiting, then
    we just return 0 (EOF).
    
    Otherwise, we launch tm_dialog and ask it to get the input and then copy it to buffer.
*/
ssize_t read(int d, void *buffer, size_t buffer_length) {
        
    if (d == STDIN_FILENO) {
        
        ssize_t bytes_read = 0;
        fcntl(d, F_SETFL, O_NONBLOCK);
        bytes_read = syscall(SYS_read, d, buffer, buffer_length);

        #ifdef TM_DIALOG_READ_DEBUG
            fprintf(stderr, "read(): syscall returned %d bytes\n", bytes_read);
        #endif

        if (bytes_read > 0) {
            #ifdef TM_DIALOG_READ_DEBUG
                fputs("read(): not invoking tm_dialog", stderr);
            #endif

            return bytes_read;
        } else {
            
            #ifdef TM_DIALOG_READ_DEBUG
                fputs("read(): calling read_using_tm_dialog()", stderr);
            #endif
            
            return read_using_tm_dialog(buffer, buffer_length);
        }
    } else {
        return syscall(SYS_read, d, buffer, buffer_length);
    }
}