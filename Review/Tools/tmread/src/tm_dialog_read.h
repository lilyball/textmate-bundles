/*
 *  tm_dialog_read.h
 *  tm_dialog_read
 *
 *  Created by Luke Daley on 26/02/08.
 *  Copyright 2008 Code4Days Software. All rights reserved.
 *
 */

#include <sys/types.h>

ssize_t	 read(int, void *, size_t) __asm("_read");
ssize_t	 read_unix2003(int, void *, size_t) __asm("_read$UNIX2003");
ssize_t	 read_nocancel_unix2003(int, void *, size_t) __asm("_read$NOCANCEL$UNIX2003");