#include "system_function_overrides.h"
#include "dialog.h"
#include "mode.h"
#include "die.h"
#include "debug.h"
#include "stdin_fd_tracker.h"
#include "textmate.h"

#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include <CoreFoundation/CoreFoundation.h>
#include <sys/errno.h>
#include <dlfcn.h>

ssize_t read(int d, void *buffer, size_t buffer_length) {

    int (*system_read)(int, void*, size_t) = dlsym(RTLD_NEXT, "read");
    // Only interested in STDIN
    if (!tm_interactive_input_is_active() || !stdin_fd_tracker_is_stdin(d) || !fd_is_owned_by_tm(d)) 
        return system_read(d, buffer, buffer_length);

    // It doesn't make sense to invoke tm_dialog if the caller wanted a non blocking read
    int oldFlags = fcntl(d, F_GETFL);
    if (oldFlags & O_NONBLOCK) return system_read(d, buffer, buffer_length);

    if (tm_interactive_input_is_in_always_mode()) {
        return tm_dialog_read(buffer, buffer_length);
    } else {
        fcntl(d, F_SETFL, oldFlags | O_NONBLOCK);
        ssize_t bytes_read = system_read(d, buffer, buffer_length);
        fcntl(d, F_SETFL, oldFlags);

        /*
            If reading from stdin produced an error, then we just return the result 
            of the syscall (previously we died fatally). Except when the error is EAGAIN. 
            Processes running under TM may have their stdin closed, and that will cause 
            EAGAIN which in our context is not really an error.
        */

        D("syscall returned %d bytes\n", (int)bytes_read);

        static bool did_see_data = false, did_see_eof = false;

        if(bytes_read > 0)
        {
            did_see_data = true;
            return bytes_read;
        }

        if(bytes_read == 0)
        {
            if(!did_see_data || did_see_eof)
                return tm_dialog_read(buffer, buffer_length);

            did_see_eof = true;
        }

        if(bytes_read == -1 && errno == EAGAIN)
            return tm_dialog_read(buffer, buffer_length);
        
        return bytes_read;
    }
}

ssize_t read_unix2003(int d, void *buffer, size_t buffer_length) {
    return read(d, buffer, buffer_length);
}

ssize_t read_nocancel_unix2003(int d, void *buffer, size_t buffer_length) {
    return read(d, buffer, buffer_length);
}

ssize_t write(int d, const void *buffer, size_t buffer_length) {
    if (tm_interactive_input_is_active() && (d == STDOUT_FILENO || d == STDERR_FILENO)) {
        capture_for_prompt(buffer, buffer_length);
    }
    int (*system_write)(int, const void*, size_t) = dlsym(RTLD_NEXT, "write");
    return system_write(d, buffer, buffer_length);
}

ssize_t write_unix2003(int d, const void *buffer, size_t buffer_length) {
    return write(d, buffer, buffer_length);
}

ssize_t write_nocancel_unix2003(int d, const void *buffer, size_t buffer_length) {
    return write(d, buffer, buffer_length);
}

int dup(int orig) {
    int (*system_dup)(int) = dlsym(RTLD_NEXT, "dup");
    int dup = system_dup(orig);
    if (tm_interactive_input_is_active()) stdin_fd_tracker_did_dup(orig, dup);
    return dup;
}

int close(int fd) {
    int (*system_close)(int) = dlsym(RTLD_NEXT, "close");
    int res = system_close(fd);
    if (tm_interactive_input_is_active()) stdin_fd_tracker_did_close(fd);
    return res;
}

int select(int nfds, fd_set * __restrict readfds, fd_set * __restrict writefds, fd_set * __restrict errorfds, struct timeval * __restrict timeout) {
    D("in select\n");
    int (*system_select)(int nfds, fd_set * __restrict readfds, fd_set * __restrict writefds, fd_set * __restrict errorfds, struct timeval * __restrict timeout) = dlsym(RTLD_NEXT, "select");
    int result;
    if (readfds == NULL) {
        D("readfds is null\n");
        result = system_select(nfds, readfds, writefds, errorfds, timeout);
    } else {
        D("readfds is not null\n");
        fd_set orig_readfds;
        FD_ZERO(&orig_readfds);
        FD_COPY(readfds, &orig_readfds);
        
        D("making syscall\n");
        int fd_count = system_select(nfds, readfds, writefds, errorfds, timeout);
        D("returned from syscall\n");
        result = fd_count + stdin_fd_tracker_inspect_select_readfds(nfds, &orig_readfds, readfds);
    }

    D("select returing %d\n", result);
    return result;
}

int select_darwinextsn(int nfds, fd_set * __restrict readfds, fd_set * __restrict writefds, fd_set * __restrict errorfds, struct timeval * __restrict timeout) {
    return select(nfds, readfds, writefds, errorfds, timeout);
}

int select_darwinextsn_nocancel(int nfds, fd_set * __restrict readfds, fd_set * __restrict writefds, fd_set * __restrict errorfds, struct timeval * __restrict timeout) {
    return select(nfds, readfds, writefds, errorfds, timeout);
}

int select_nocancel_unix2003(int nfds, fd_set * __restrict readfds, fd_set * __restrict writefds, fd_set * __restrict errorfds, struct timeval * __restrict timeout) {
    return select(nfds, readfds, writefds, errorfds, timeout);
}

int select_unix2003(int nfds, fd_set * __restrict readfds, fd_set * __restrict writefds, fd_set * __restrict errorfds, struct timeval * __restrict timeout) {
    return select(nfds, readfds, writefds, errorfds, timeout);
}