/*
 * - tmread - 
 *   A replacement for find() that invokes tm_dialog to get the data if none is available
 *
 * Luke Daley <ld at ldaley dot com>
 *
 * TODO - documentation here
 *
 * BUGS:
 *  - If the xml generated for the -p argument of tm_dialog has a ' in it, the command will break.
 *    to fix this, I need to pipe the input to tm_dialog instead of using -p
 */

#include "tmread.h"

#include <sys/syscall.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include <CoreFoundation/CoreFoundation.h>

#ifndef TM_READ_DEBUG
#define TM_READ_DEBUG 1
#endif

#ifndef DIALOG_ENV_VAR
#define DIALOG_ENV_VAR "DIALOG"
#endif

#ifndef DIALOG_NIB_ENV_VAR
#define DIALOG_NIB_ENV_VAR "DIALOG_NIB"
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

#ifndef ERROR_BUFFER_SIZE
#define ERROR_BUFFER_SIZE 4096
#endif

#ifndef TM_DIALOG_OUTPUT_CHUNK_SIZE
#define TM_DIALOG_OUTPUT_CHUNK_SIZE 1024
#endif

void die(char *msg) {
    fprintf(stderr, "tmread failure: %s", msg);
    exit(1);
}

void free_then_die(char *msg, bool freemsg) {
    fprintf(stderr, "tmread failure: %s", msg);
    free(msg);
    exit(1);
}

char * get_tm_dialog_parameters() {
    
    CFMutableDictionaryRef parameters = CFDictionaryCreateMutable(kCFAllocatorDefault, 5, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    if (parameters == NULL) die("failed to allocate dict for dialog parameters");
    
    char *title_env_value = getenv(DIALOG_TITLE_ENV_VAR);
    if (title_env_value) {
        
        CFStringRef title_key = CFStringCreateWithCStringNoCopy(kCFAllocatorDefault, DIALOG_TITLE_KEY, kCFStringEncodingUTF8, kCFAllocatorNull);
        if (title_key == NULL) die("Failed to create string for title key");
        
        CFStringRef title = CFStringCreateWithCStringNoCopy(kCFAllocatorDefault, title_env_value, kCFStringEncodingUTF8, kCFAllocatorNull);
        if (title == NULL) die("Failed to create string from title env var");
        
        CFDictionaryAddValue(parameters, title_key, title);
        CFRelease(title_key);
        CFRelease(title);
    }
    
    char *prompt_env_value = getenv(DIALOG_PROMPT_ENV_VAR);
    if (prompt_env_value) {
        
        CFStringRef prompt_key = CFStringCreateWithCStringNoCopy(kCFAllocatorDefault, DIALOG_PROMPT_KEY, kCFStringEncodingUTF8, kCFAllocatorNull);
        if (prompt_key == NULL) die("Failed to create string for prompt key");
        
        CFStringRef prompt = CFStringCreateWithCStringNoCopy(kCFAllocatorDefault, prompt_env_value, kCFStringEncodingUTF8, kCFAllocatorNull);
        if (prompt == NULL) die("Failed to create string from prompt env var");
        
        CFDictionaryAddValue(parameters, prompt_key, prompt);
        CFRelease(prompt_key);
        CFRelease(prompt);
    }

    char *string_env_value = getenv(DIALOG_STRING_ENV_VAR);
    if (string_env_value) {
        
        CFStringRef string_key = CFStringCreateWithCStringNoCopy(kCFAllocatorDefault, DIALOG_STRING_KEY, kCFStringEncodingUTF8, kCFAllocatorNull);
        if (string_key == NULL) die("Failed to create string for string key");
        
        CFStringRef string = CFStringCreateWithCStringNoCopy(kCFAllocatorDefault, string_env_value, kCFStringEncodingUTF8, kCFAllocatorNull);
        if (string == NULL) die("Failed to create string from string env var");
        
        CFDictionaryAddValue(parameters, string_key, string);
        CFRelease(string_key);
        CFRelease(string);
    }

    CFStringRef button1_key = CFStringCreateWithCStringNoCopy(kCFAllocatorDefault, DIALOG_BUTTON_1_KEY, kCFStringEncodingUTF8, kCFAllocatorNull);
    if (button1_key == NULL) die("Failed to create string for button1 key");
    
    CFStringRef button1 = CFStringCreateWithCStringNoCopy(kCFAllocatorDefault, DIALOG_BUTTON_1, kCFStringEncodingUTF8, kCFAllocatorNull);
    if (button1 == NULL) die("Failed to create string for button1 value");
    
    CFDictionaryAddValue(parameters, button1_key, button1);
    CFRelease(button1_key);
    CFRelease(button1);

    CFStringRef button2_key = CFStringCreateWithCStringNoCopy(kCFAllocatorDefault, DIALOG_BUTTON_2_KEY, kCFStringEncodingUTF8, kCFAllocatorNull);
    if (button2_key == NULL) die("Failed to create string for button2 key");
    
    CFStringRef button2 = CFStringCreateWithCStringNoCopy(kCFAllocatorDefault, DIALOG_BUTTON_2, kCFStringEncodingUTF8, kCFAllocatorNull);
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
        #ifdef TM_READ_DEBUG
            puts("get_tm_dialog_parameters(): writing parameters property list to stream failed");
        #endif
	    
        char error_as_chars[ERROR_BUFFER_SIZE];
        
        if (!CFStringGetCString(error, error_as_chars, ERROR_BUFFER_SIZE, kCFStringEncodingUTF8)) {
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
    
    return parameters_chars;
}

char * get_tm_dialog_command() {
    
    char *tm_dialog = getenv(DIALOG_ENV_VAR);
    char *nib = getenv(DIALOG_NIB_ENV_VAR);
    char *parameters = get_tm_dialog_parameters();
    char *command;
    char error[ERROR_BUFFER_SIZE];

    // TODO Should I validate the tm_dialogand nib are existing files here?
    if (tm_dialog == NULL || strlen(tm_dialog) == 0) {
        snprintf(error, ERROR_BUFFER_SIZE, "Cannot execute tm_dialog, %s is empty or not set", DIALOG_ENV_VAR);
        die(error);
    }

    if (nib == NULL || strlen(nib) == 0) {
        snprintf(error, ERROR_BUFFER_SIZE, "No nib specified for tm_dialog, %s is empty or not set", DIALOG_NIB_ENV_VAR);
        die(error);
    }

    asprintf(&command, "%s -q -p '%s' %s", tm_dialog, parameters, nib);
    if (command == NULL) die("Failed to allocate for command string");
   
    #ifdef TM_READ_DEBUG
        printf("get_tm_dialog_command(): %s\n", command);
    #endif
    
    free(parameters);
    return command;
 }

char *get_tm_dialog_output(FILE *tm_dialog) {
    char *output_buf = malloc(TM_DIALOG_OUTPUT_CHUNK_SIZE);
    ssize_t output_buf_len = TM_DIALOG_OUTPUT_CHUNK_SIZE;
    char c;
    size_t i = 0;
    
    if (output_buf == NULL) die("failed to allocate initial buffer for tm_dialogoutput");
    
    for (i = 0; (c = getc(tm_dialog)) != EOF; ++i) {
        if (i == output_buf_len) {
            output_buf = realloc(output_buf, output_buf_len + TM_DIALOG_OUTPUT_CHUNK_SIZE);
            if (output_buf == NULL) die("failed to increase allocation for tm_dialogoutput buffer");
            output_buf_len = output_buf_len + TM_DIALOG_OUTPUT_CHUNK_SIZE;
        }
        output_buf[i] = c;
    }
    
    if (i++ == output_buf_len) {
        output_buf = realloc(output_buf, output_buf_len + 1);
        if (output_buf == NULL) die("failed to increase allocation for tm_dialogoutput buffer");
        output_buf_len = output_buf_len + 1;
    }
    
    output_buf[i] = '\0';
    
    #ifdef TM_READ_DEBUG
        printf("get_tm_dialog_output(): %s", output_buf);
    #endif
    
    return output_buf;
} 

CFPropertyListRef convert_tm_dialog_output_to_plist(char *tm_dialog_output) {
    
    #ifdef TM_READ_DEBUG
        puts("convert_tm_dialog_output_to_plist(): converting output to data");
    #endif
    
    CFDataRef tm_dialog_output_data = CFDataCreateWithBytesNoCopy(kCFAllocatorDefault, (const UInt8*)tm_dialog_output, strlen(tm_dialog_output), kCFAllocatorNull);
    if (tm_dialog_output_data == NULL) die("failed to allocate tm_dialog_output_data");
    
    #ifdef TM_READ_DEBUG
        puts("convert_tm_dialog_output_to_plist(): creating property list from data");
    #endif
    
	CFStringRef error = NULL;
	CFPropertyListRef plist = CFPropertyListCreateFromXMLData(kCFAllocatorDefault, tm_dialog_output_data, kCFPropertyListImmutable, &error);

	if (error) {
	    
	    #ifdef TM_READ_DEBUG
            puts("convert_tm_dialog_output_to_plist(): creating property list failed");
        #endif
	    
        char error_as_chars[ERROR_BUFFER_SIZE];
        
        if (!CFStringGetCString(error, error_as_chars, ERROR_BUFFER_SIZE, kCFStringEncodingUTF8)) {
            CFRelease(tm_dialog_output_data);
            CFRelease(error);
            die("converting tm_dialog_output to property list failed, and so did trying to get the failure message");
        }

        CFRelease(tm_dialog_output_data);
        CFRelease(error);
            
        die(error_as_chars);
	}
    
    CFRelease(tm_dialog_output_data);
    
    return plist;
}

ssize_t copy_return_argument_into_buffer(CFStringRef return_argument, char *buf, ssize_t buf_len) {
    
    #ifdef TM_READ_DEBUG
        printf("copy_return_argument_into_buffer(): copying return argument into original buffer\n");
    #endif
    
    CFIndex return_argument_length = CFStringGetLength(return_argument);
    CFIndex copy_count;
    CFRange copy_range;
    
    copy_range.location = 0;
    copy_range.length = (return_argument_length > buf_len) ? buf_len : return_argument_length;
    
    if (0 == CFStringGetBytes(return_argument, copy_range, kCFStringEncodingUTF8, 0, false, (UInt8 *)buf, buf_len, &copy_count)) {
        die("failed to copy return argument into buffer");
    }
    
    if (copy_count < buf_len) { 
        buf[copy_count++] = '\n';
    } else { 
        buf[copy_count - 1] = '\n';
    }
        
    return copy_count;
}

ssize_t extract_input_from_plist(CFPropertyListRef plist, char *buf, size_t buf_len) {
    
    if (CFGetTypeID(plist) != CFDictionaryGetTypeID()) die("extract_input_from_plist(): root element of plist is not dictionary");
    
    CFStringRef results_key = CFStringCreateWithCStringNoCopy(kCFAllocatorDefault, DIALOG_RESULT_KEY, kCFStringEncodingUTF8, kCFAllocatorNull);
    CFDictionaryRef results;
    
    if (CFDictionaryGetValueIfPresent(plist, results_key, (void *)&results)) {
                
        if (CFGetTypeID(results) != CFDictionaryGetTypeID()) die("results entry of output is not a dictionary");
        
        CFRelease(results_key);
        
        CFStringRef return_argument_key = CFStringCreateWithCStringNoCopy(kCFAllocatorDefault, DIALOG_RETURN_ARGUMENT_KEY, kCFStringEncodingUTF8, kCFAllocatorNull);
        CFStringRef return_argument;
        
        if (CFDictionaryGetValueIfPresent(results, return_argument_key, (void *)&return_argument)) {
            CFRelease(return_argument_key);
            if (CFGetTypeID(return_argument) != CFStringGetTypeID()) die("return value entry in results entry of output is not a string");
            return copy_return_argument_into_buffer(return_argument, buf, buf_len);
        } else {
            die("results entry of output does not contain an entry for return value");
        } 
        
    } else {
        #ifdef TM_READ_DEBUG
            printf("extract_input_from_plist(): plist has no %s key, so returning nothing", DIALOG_RESULT_KEY);
        #endif
        CFRelease(results_key);
        return 0; // EOF
    }
    
    die("We should never get here!");
    return 0; // keep compiler happy
}

ssize_t read_using_tm_dialog(void *buf, size_t buf_len) {

    char *tm_dialog_command = get_tm_dialog_command();
    char *tm_dialog_output = NULL;
    FILE *tm_dialog;
    CFPropertyListRef plist;
    ssize_t bytes_read;
    
    #ifdef TM_READ_DEBUG
        puts("read_using_tm_dialog(): about to open tm_dialog");
    #endif
    
    tm_dialog= popen(tm_dialog_command, "r");
    if (tm_dialog== NULL) die("failed to open tm_dialog");
    tm_dialog_output = get_tm_dialog_output(tm_dialog);
    plist = convert_tm_dialog_output_to_plist(tm_dialog_output);
    free(tm_dialog_output);
    bytes_read = extract_input_from_plist(plist, buf, buf_len);
    CFRelease(plist);
    return bytes_read;
}

/*
 *    
 */
ssize_t read(int d, void *buf, size_t buf_len) {
    
    ssize_t bytes_read = 0;
    
    if (d == STDIN_FILENO) {
        
        fcntl(d, F_SETFL, O_NONBLOCK);
                
        bytes_read = syscall(SYS_read, d, buf, buf_len);

        #ifdef TM_READ_DEBUG
            printf("read(): syscall returned %d bytes\n", bytes_read);
        #endif

        if (bytes_read > 0) {
            #ifdef TM_READ_DEBUG
                printf("read(): not invoking tm_dialog", bytes_read);
            #endif
            
            return bytes_read;
        } else {
            #ifdef TM_READ_DEBUG
                puts("read(): calling read_using_tm_dialog()");
            #endif
            
            return read_using_tm_dialog(buf, buf_len);
        }
    } else {
        return syscall(SYS_read, d, buf, buf_len);
    }
}


