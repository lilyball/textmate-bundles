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
    bool found = false;
    size_t i = 0;
    size_t target_index = 0;
     
    for (i = 0; i < set->size; ++i) {
        if (set->ints[i] == target) {
            found = true;
            break;
        }
    }
    
    if (found) {
        int* new_ints = malloc(set->capacity);
        if (new_ints == NULL) die("failed to allocate new storage for intset");
        
        ssize_t low = 0;
        ssize_t high = target_index - 1;
        ssize_t low_copy = high - low + 1;
        
        if (high >= low) {
            memcpy(new_ints, set->ints, low_copy);
        }
        
        low = target_index + 1;
        high = set->size - 1;
        
        if (low <= high) {
            memcpy(new_ints + low_copy, set->ints + target_index + 1, high - low + 1);
        }
        
        --set->size;
    }
    
    return found;
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