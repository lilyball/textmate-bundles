#ifndef _STDIN_FD_TRACKER_H_
#define _STDIN_FD_TRACKER_H_

#include <stdbool.h>

bool stdin_fd_tracker_is_stdin(int);
void stdin_fd_tracker_did_dup(int,int);
void stdin_fd_tracker_did_close(int);

#endif /* _STDIN_FD_TRACKER_H_ */
