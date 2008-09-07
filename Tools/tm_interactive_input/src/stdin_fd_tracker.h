#ifndef _STDIN_FD_TRACKER_H_
#define _STDIN_FD_TRACKER_H_

#include <stdbool.h>
#include <sys/select.h>

bool stdin_fd_tracker_is_stdin(int);
void stdin_fd_tracker_did_dup(int,int);
void stdin_fd_tracker_did_close(int);
int stdin_fd_tracker_augment_select_result(int, fd_set * __restrict, fd_set * __restrict);
int stdin_fd_tracker_count_stdins_in_fdset(int max, fd_set *fds);

#endif /* _STDIN_FD_TRACKER_H_ */
