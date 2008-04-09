#include "close.h"

#include "stdin_fd_tracker.h"
#include "mode.h"

#include <sys/syscall.h>
#include <unistd.h>

int close(int fd) {
    int res = syscall(SYS_close, fd);
    if (tm_interactive_input_is_active()) stdin_fd_tracker_did_close(fd);
    return res;
}