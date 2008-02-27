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

#ifndef TM_READ_DEBUG
#define TM_READ_DEBUG 1
#endif

#ifndef TM
#define TM_READ_COCOA_DIALOG_PATH_ENV_VAR "COCOADIALOG_PATH"
#endif

#ifndef TM
#define TM_READ_COCOA_DIALOG_OPTIONS "inputbox --title 'TextMate Input' --informative-text 'A running process is requesting input:' --button1 'Send' --button2 'Send End of File' --float"
#endif

char* getCocoaDialogPath() {
    static char *path = NULL;
    
    if (path == NULL) {
        path = getenv(TM_READ_COCOA_DIALOG_PATH_ENV_VAR);
        if (path == NULL) {
            write(STDERR_FILENO, "tmread failure: ", 16);
            write(STDERR_FILENO, TM_READ_COCOA_DIALOG_PATH_ENV_VAR, strlen(TM_READ_COCOA_DIALOG_PATH_ENV_VAR));
            write(STDERR_FILENO, " is not set", 11);
            exit(1);
        }
    }
    
    return path;
}

char* getCocoaDialogCommand() {
    static char command[4096];
    char *path = NULL;
    if (command[0] == '\0') {
        path = getCocoaDialogPath();
        strcpy(command, path);
        command[strlen(path)] = ' ';
        strcpy(&command[strlen(path) + 1], TM_READ_COCOA_DIALOG_OPTIONS);
        command[strlen(path) + 1 + strlen(TM_READ_COCOA_DIALOG_OPTIONS)] = '\0';
    }

    return command;
}

ssize_t read(int d, void *buf, size_t nbytes) {
    ssize_t bytesReadBySyscall = 0;
    int i = 0;
    int c = 0;
    char *charBuf = (char *)buf;
    FILE *ifp;
    
    if (d == STDIN_FILENO) { // We are trying to read from STDIN
        
        #ifdef TM_READ_DEBUG
        puts("Setting fd to non blocking");
        #endif
        fcntl(d, F_SETFL, O_NONBLOCK); // Don't wait for input, return immediately
        
        #ifdef TM_READ_DEBUG
        puts("About to read from STDIN using syscall");
        #endif
        bytesReadBySyscall = syscall(SYS_read, d, buf, nbytes);
        #ifdef TM_READ_DEBUG
        printf("read syscall returned: %d\n", bytesReadBySyscall);
        #endif

        if (bytesReadBySyscall > 0) {
            #ifdef TM_READ_DEBUG
            puts("Returning result of read syscall");
            #endif
            return bytesReadBySyscall;
        } else {

            ifp = popen(getCocoaDialogCommand(), "r");
            if (ifp == NULL) {
                #ifdef TM_READ_DEBUG
                puts("popen() return NULL");
                #endif
                write(STDERR_FILENO, "tmread failure: Could not open CocoaDialog @ ", 46);
                exit(1);
            }
            
            #ifdef TM_READ_DEBUG
            puts("Reading dialog response ...");
            #endif
            while ((c = getc(ifp)) != EOF) {
                if (c == '\n')
                    break;
            }
            
            for (i = 0; i < nbytes; ++i) {
                c = getc(ifp);
                if (c == EOF) {
                    break;
                }
                charBuf[i] = c;
            }
            return i;
        }
    } else {
        return syscall(SYS_read, d, buf, nbytes);
    }
}


