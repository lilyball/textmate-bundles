/**
 * tm_dialog_read
 *
 * A read implementation for processes running under TextMate.
 *
 * The goal of this is to facilitate scripts/commands running via textmate that require user input
 * to use tm_dialog to get the input, where typically the user would enter it on the command line.
 *
 * See the tm_dialog_read_help.md file that should accompany this source and library on how to use.
 *
 * @author Luke Daley
 * @author Allan Odgaard
 */

#include "read.h"

#include "die.h"
#include "debug.h"
#include "dialog.h"

#include <sys/syscall.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include <CoreFoundation/CoreFoundation.h>

/**
 * This replaces the system read() function.
 *
 * The overall goal here is to us tm_dialog to get the input from the user if
 * the following conditions are met:
 * - we are wanting to read from stdin
 * - we are *not* requesting a non blocking read
 * - stdin has no data available
 *
 * If we aren't reading from stdin, then we just fallback to the normal read() impl.
 * To see if stdin has data, we do a non blocking read using the normal read() impl,
 * if it returns data, then we give that back. Otherwise, we call tm_dialog_read.
 */
ssize_t read(int d, void *buffer, size_t buffer_length) {
 
    // Only interested in STDIN
    if (d != STDIN_FILENO) return syscall(SYS_read, d, buffer, buffer_length);
 
    // It doesn't make sense to invoke tm_dialog if the caller wanted a non blocking read
    int oldFlags = fcntl(d, F_GETFL);
    if (oldFlags & O_NONBLOCK) return syscall(SYS_read, d, buffer, buffer_length);

    fcntl(d, F_SETFL, oldFlags | O_NONBLOCK);
    ssize_t bytes_read = syscall(SYS_read, d, buffer, buffer_length);
    fcntl(d, F_SETFL, oldFlags);

    D("read(): syscall returned %d bytes\n", (int)bytes_read);
    if (bytes_read < 0) die("read syscall produced error: '%s' (%zd bytes read)", strerror(errno), bytes_read);
 
    return (bytes_read > 0) ? bytes_read : tm_dialog_read(buffer, buffer_length);
}

/**
 * @see read()
 */
ssize_t read_unix2003(int d, void *buffer, size_t buffer_length) {
    return read(d, buffer, buffer_length);
}

/**
 * @see read()
 */
ssize_t read_nocancel_unix2003(int d, void *buffer, size_t buffer_length) {
    return read(d, buffer, buffer_length);
}