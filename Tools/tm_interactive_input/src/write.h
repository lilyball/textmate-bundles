#ifndef _WRITE__H_
#define _WRITE__H_

#include <sys/types.h>

ssize_t write(int, const void*, size_t) __asm("_write");
ssize_t write_unix2003(int, const void*, size_t) __asm("_write$UNIX2003");
ssize_t write_nocancel_unix2003(int, const void*, size_t) __asm("_write$NOCANCEL$UNIX2003");

#endif /* _WRITE__H_ */