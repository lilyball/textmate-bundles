#include "die.h"

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

void die(char *fmt, ...) {
    va_list ap;
    char *msg;

    va_start(ap, fmt);
    if (vasprintf(&msg, fmt, ap) == -1) {
        fputs("tm_dialog_read failure: FAILED TO ALLOCATE ERROR STRING", stderr);
        exit(1);
    }
    va_end(ap);
    
    fprintf(stderr, "tm_dialog_read failure: %s\n", msg);
    exit(1);
}