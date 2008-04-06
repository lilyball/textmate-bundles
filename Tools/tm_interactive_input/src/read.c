#include "read.h"

#include "die.h"
#include "debug.h"
#include "dialog.h"
#include "mode.h"

#include <sys/syscall.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include <CoreFoundation/CoreFoundation.h>
#include <sys/errno.h>

ssize_t read(int d, void *buffer, size_t buffer_length) {

    // Only interested in STDIN
    if (d != STDIN_FILENO || !tm_interactive_input_is_active()) return syscall(SYS_read, d, buffer, buffer_length);

    // It doesn't make sense to invoke tm_dialog if the caller wanted a non blocking read
    int oldFlags = fcntl(d, F_GETFL);
    if (oldFlags & O_NONBLOCK) return syscall(SYS_read, d, buffer, buffer_length);

    if (tm_interactive_input_is_in_always_mode()) {
        return tm_dialog_read(buffer, buffer_length);
    } else {
        fcntl(d, F_SETFL, oldFlags | O_NONBLOCK);
        ssize_t bytes_read = syscall(SYS_read, d, buffer, buffer_length);
        fcntl(d, F_SETFL, oldFlags);

        /*
            If reading from stdin produced an error, then we just return the result 
            of the syscall (previously we died fatally). Except when the error is EAGAIN. 
            Processes running under TM may have their stdin closed, and that will cause 
            EAGAIN which in our context is not really an error.
        */

        D("syscall returned %d bytes\n", (int)bytes_read);

        static bool did_see_eof = false;
        if((bytes_read == -1 && errno == EAGAIN) || (bytes_read == 0 && did_see_eof))
            return tm_dialog_read(buffer, buffer_length);
        
        if(bytes_read == 0)
            did_see_eof = true;
        return bytes_read;
    }
}

ssize_t read_unix2003(int d, void *buffer, size_t buffer_length) {
    return read(d, buffer, buffer_length);
}

ssize_t read_nocancel_unix2003(int d, void *buffer, size_t buffer_length) {
    return read(d, buffer, buffer_length);
}