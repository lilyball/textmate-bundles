#include "intset.h"
#include <stdlib.h>
#include "die.h"
#include "debug.h"
#include <string.h>

static const size_t grow_factor = 8;

intset_t* create_intset() {
    intset_t* res = malloc(sizeof(intset_t));
    if (res == NULL)  die("create_intset() malloc failed");
    res->ints = NULL;
    res->size = 0;
    res->capacity = 0;
    return res;
}

void destroy_intset(intset_t* is) {
    if (is->ints != NULL) free(is->ints);
    free(is);
}

void add_to_intset(intset_t* is, int i) {
    if (intset_contains(is, i) == false) {
        if (is->capacity == is->size) {
            is->capacity += grow_factor;
            is->ints = realloc(is->ints, is->capacity);
            if (is->ints == NULL) die("reallocation of ints failed");
        }
        is->ints[is->size++] = i;
    }
}

bool remove_from_intset(intset_t* set, int target) {
    size_t i = 0;
    for (i = 0; i < set->size; ++i) {
        if (set->ints[i] == target) {
            memmove(set->ints + i, set->ints + i + 1, set->size - i);
            --set->size;
            return true;
        }
    }
    return false;
}

bool intset_contains(intset_t* set, int target) {
    size_t i = 0;
    for (i = 0; i < set->size; ++i) {
        if (set->ints[i] == target) {
            return true;
        }
    }
    return false;
}

size_t intset_size(intset_t* set) {
    return set->size;
}

int intset_get(intset_t* set, ssize_t i) {
    if (i < 0 || (i + 1) > set->size) die("%d is out of range (size = %d)", i, set->size);
    return set->ints[i];
}