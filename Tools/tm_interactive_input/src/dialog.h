#ifndef DIALOG_H_7T36A9MD
#define DIALOG_H_7T36A9MD

#include <sys/types.h>

ssize_t tm_dialog_read(void *, size_t);
void capture_for_prompt(const void *buffer, size_t buffer_length);

#endif /* end of include guard: DIALOG_H_7T36A9MD */
