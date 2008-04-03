#include "write.h"
#include "dialog.h"
#include "mode.h"

#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

ssize_t write(int d, const void *buffer, size_t buffer_length) {

    // If we are printing debug messages, we can't capture stderr otherwise
    // we get into a loop.

    #ifdef NDEBUG
        if (tm_interactive_input_is_active() && (d == STDOUT_FILENO || d == STDERR_FILENO)) 
            capture_for_prompt(buffer, buffer_length);
    #else
        if (tm_interactive_input_is_active() && (d == STDOUT_FILENO)) 
            capture_for_prompt(buffer, buffer_length);
    #endif

    return syscall(SYS_write, d, buffer, buffer_length);
}

ssize_t write_unix2003(int d, const void *buffer, size_t buffer_length) {
    return write(d, buffer, buffer_length);
}

ssize_t write_nocancel_unix2003(int d, const void *buffer, size_t buffer_length) {
    return write(d, buffer, buffer_length);
}