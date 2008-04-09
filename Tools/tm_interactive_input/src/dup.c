#include "dup.h"
#include "stdin_fd_tracker.h"
#include "mode.h"
#include <sys/syscall.h>
#include <unistd.h>

int dup(int orig) {
    int dup = syscall(SYS_dup, orig);
    if (tm_interactive_input_is_active()) stdin_fd_tracker_did_dup(orig, dup);
    return dup;
}