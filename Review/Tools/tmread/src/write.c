#include "write.h"
#include "dialog.h"

#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

ssize_t write(int d, const void *buffer, size_t buffer_length) {
    if (tm_dialog_read_is_active() && (d == STDOUT_FILENO)) capture_for_prompt(buffer, buffer_length);
    return syscall(SYS_write, d, buffer, buffer_length);
}

ssize_t write_unix2003(int d, const void *buffer, size_t buffer_length) {
    return write(d, buffer, buffer_length);
}

ssize_t write_nocancel_unix2003(int d, const void *buffer, size_t buffer_length) {
    return write(d, buffer, buffer_length);
}