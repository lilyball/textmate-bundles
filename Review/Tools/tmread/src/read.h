#ifndef _READ_H_
#define _READ_H_

#include <sys/types.h>

ssize_t read(int, void *, size_t) __asm("_read");
ssize_t read_unix2003(int, void *, size_t) __asm("_read$UNIX2003");
ssize_t read_nocancel_unix2003(int, void *, size_t) __asm("_read$NOCANCEL$UNIX2003");

#endif /* _READ_H_ */
