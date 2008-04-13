#include "textmate.h"
#include "die.h"
#include "debug.h"
#include <sys/types.h>
#include <fcntl.h>
#include <stdlib.h>

int get_tm_pid() {
    char* value = getenv("TM_PID");
    if (value == NULL) return -1;
    return atoi(value);
}

bool fd_is_owned_by_tm(int fd) {
    int tm_pid = get_tm_pid();
    
    if (tm_pid < 0) return false;
    
    int fd_pid = fcntl(fd, F_GETOWN);
    D("fd_pid = %d, tm_pid = %d\n", fd_pid, tm_pid);
    return (abs(fd_pid) == tm_pid);
}