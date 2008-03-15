/**
 * A read implementation for processes running under TextMate.
 * 
 * @author Luke Daley
 * @author Allan Odgaard
 */

#include <sys/types.h>

ssize_t read(int, void *, size_t) __asm("_read");
ssize_t read_unix2003(int, void *, size_t) __asm("_read$UNIX2003");
ssize_t read_nocancel_unix2003(int, void *, size_t) __asm("_read$NOCANCEL$UNIX2003");