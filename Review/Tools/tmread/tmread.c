/*
 *  tmread.c
 *  tmread
 *
 *  Created by Luke Daley on 26/02/08.
 *  Copyright 2008 Code4Days Software. All rights reserved.
 *
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

#ifndef DIALOG
#define DIALOG "DIALOG"
#endif

#ifndef DIALOG_NIB
#define DIALOG_NIB "DIALOG_NIB"
#endif

#ifndef DIALOG_PROMPT
#define DIALOG_PROMPT "DIALOG_PROMPT"
#endif

#ifndef DIALOG_TITLE
#define DIALOG_TITLE "DIALOG_TITLE"
#endif

#ifndef ERROR_BUFFER_SIZE
#define ERROR_BUFFER_SIZE 4096
#endif

#ifndef TM_DIALOG_OUTPUT_CHUNK_SIZE
#define TM_DIALOG_OUTPUT_CHUNK_SIZE 4096
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

char * get_tm_dialog_command() {
    
    char *tm_dialog = getenv(DIALOG);
    char *nib = getenv(DIALOG_NIB);
    char *command;
    char error[ERROR_BUFFER_SIZE];

    // TODO Should I validate the tm_dialog and nib are existing files here?
    if (tm_dialog == NULL || strlen(tm_dialog) == 0) {
        snprintf(error, ERROR_BUFFER_SIZE, "Cannot execute tm_dialog, %s is empty or not set", DIALOG);
        die(error);
    }

    if (nib == NULL || strlen(nib) == 0) {
        snprintf(error, ERROR_BUFFER_SIZE, "No nib specified for tm_dialog, %s is empty or not set", DIALOG_NIB);
        die(error);
    }

    asprintf(&command, "%s -q -p {} %s", tm_dialog, nib);
    if (command == NULL) {
        die("Failed to allocate for command string");
    }
   
    #ifdef TM_READ_DEBUG
        printf("get_tm_dialog_command(): %s\n", command);
    #endif
    
    return command;
 }

char *get_tm_dialog_output(FILE *tm_dialog) {
    char *output_buf = malloc(TM_DIALOG_OUTPUT_CHUNK_SIZE);
    ssize_t output_buf_len = TM_DIALOG_OUTPUT_CHUNK_SIZE;
    char c;
    size_t i = 0;
    
    if (output_buf == NULL) die("failed to allocate initial buffer for tm_dialog output");
    
    for (i = 0; (c = getc(tm_dialog)) != EOF; ++i) {
        if (i == output_buf_len) {
            output_buf = realloc(output_buf, output_buf_len + TM_DIALOG_OUTPUT_CHUNK_SIZE);
            if (output_buf == NULL) die("failed to increase allocation for tm_dialog output buffer");
            output_buf_len = output_buf_len + TM_DIALOG_OUTPUT_CHUNK_SIZE;
        }
        output_buf[i] = c;
    }
    
    if (i++ == output_buf_len) {
        output_buf = realloc(output_buf, output_buf_len + 1);
        if (output_buf == NULL) die("failed to increase allocation for tm_dialog output buffer");
        output_buf_len = output_buf_len + 1;
    }
    
    output_buf[i] = '\0';
    
    #ifdef TM_READ_DEBUG
        printf("get_tm_dialog_output(): %s", output_buf);
    #endif
    
    return output_buf;
} 

ssize_t read_using_tm_dialog(void *buf, size_t buf_len) {

    char *tm_dialog_command = get_tm_dialog_command();
    char *tm_dialog_output = NULL;
    FILE *tm_dialog;
    
    #ifdef TM_READ_DEBUG
        puts("read_using_tm_dialog(): about to open tm_dialog");
    #endif
    
    tm_dialog = popen(tm_dialog_command, "r");
    if (tm_dialog == NULL) die("failed to open tm_dialog");
    tm_dialog_output = get_tm_dialog_output(tm_dialog);
    
    strncpy(buf, tm_dialog_output, buf_len);
    free(tm_dialog_output);
    
    return strlen(buf);
}

/*
 *    
 */
ssize_t read(int d, void *buf, size_t buf_len) {
    
    ssize_t bytes_read = 0;
    
    if (d == STDIN_FILENO) {
        #ifdef TM_READ_DEBUG
        puts("Setting fd to non blocking");
        #endif
        fcntl(d, F_SETFL, O_NONBLOCK); // Don't wait for input, return immediately
        
        #ifdef TM_READ_DEBUG
        puts("About to read from STDIN using syscall");
        #endif
        bytes_read = syscall(SYS_read, d, buf, buf_len);
        #ifdef TM_READ_DEBUG
        printf("read syscall returned: %d\n", bytes_read);
        #endif

        if (bytes_read > 0) {
            #ifdef TM_READ_DEBUG
            printf("read() got %d bytes, returning that", bytes_read);
            #endif
            return bytes_read;
        } else {
            #ifdef TM_READ_DEBUG
            puts("calling read_using_tm_dialog()");
            #endif
            return read_using_tm_dialog(buf, buf_len);
        }
    } else {
        return syscall(SYS_read, d, buf, buf_len);
    }
}


