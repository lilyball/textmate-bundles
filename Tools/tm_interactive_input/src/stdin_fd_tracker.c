#include "stdin_fd_tracker.h"
#include "intset.h"
#include "debug.h"
#include "textmate.h"
#include <pthread.h>

pthread_mutex_t storage_mutex = PTHREAD_MUTEX_INITIALIZER;

// Only call this if you have locked the storage mutex
intset_t* get_storage() {
    static intset_t* storage = NULL;
    if (storage == NULL) {
        storage = create_intset();
        add_to_intset(storage, 0);
    }
    return storage;
}

bool stdin_fd_tracker_is_stdin(int target) {
    pthread_mutex_lock(&storage_mutex);
    intset_t* fds = get_storage();
    bool is = intset_contains(fds, target);
    pthread_mutex_unlock(&storage_mutex);
    return is;
}

void stdin_fd_tracker_did_dup(int orig, int dup) {
    pthread_mutex_lock(&storage_mutex);
    intset_t* fds = get_storage();
    if (intset_contains(fds, orig)) {
        D("adding %d as dup of %d\n", dup, orig);
        add_to_intset(fds, dup);
    }
    pthread_mutex_unlock(&storage_mutex);
}

void stdin_fd_tracker_did_close(int target) {
    pthread_mutex_lock(&storage_mutex);
    intset_t* fds = get_storage();
    if (intset_contains(fds, target)) {
        D("removing %d\n as dup of stdin", target);
        remove_from_intset(fds, target);
    }
    pthread_mutex_unlock(&storage_mutex);
}

int stdin_fd_tracker_augment_select_result(int max, fd_set *orig_fds __restrict, fd_set *changed_fds) {
    pthread_mutex_lock(&storage_mutex);
    intset_t* storage = get_storage();
    int count = 0;

    int i;
    for (i = 0; i < intset_size(storage); ++i) {
        int fd = intset_get(storage, i);
        if(fd >= max)
            continue;

        if (FD_ISSET(fd, orig_fds) && !FD_ISSET(fd, changed_fds) && fd_is_owned_by_tm(fd)) {
            ++count;
            FD_SET(fd, changed_fds);
        }
    }
    
    pthread_mutex_unlock(&storage_mutex);
    
    return count;
}

int stdin_fd_tracker_count_stdins_in_fdset(int max, fd_set *fds) {
    pthread_mutex_lock(&storage_mutex);
    intset_t* storage = get_storage();
    int count = 0;

    int i;
    for (i = 0; i < intset_size(storage); ++i) {
        int fd = intset_get(storage, i);
        if(fd >= max)
            continue;

        if (FD_ISSET(fd, fds) && fd_is_owned_by_tm(fd)) {
            ++count;
        }
    }
    
    pthread_mutex_unlock(&storage_mutex);
    
    return count;
}