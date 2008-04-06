#ifndef _DIALOG_H_
#define _DIALOG_H_

#include <sys/types.h>

ssize_t tm_dialog_read(void *, size_t);
void capture_for_prompt(const void *buffer, size_t buffer_length);

#endif /* _DIALOG_H_ */