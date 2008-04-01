#ifndef _DIALOG_H_
#define _DIALOG_H_

#include <sys/types.h>
#include <stdbool.h>

ssize_t tm_dialog_read(void *, size_t);
void capture_for_prompt(const void *buffer, size_t buffer_length);
bool tm_dialog_read_is_active();
bool tm_dialog_read_is_used_always();

#endif /* _DIALOG_H_ */


