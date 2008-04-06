#include "mode.h"
#include "debug.h"

#include <string.h>
#include <stdlib.h>

char* get_tm_interactive_input_mode_mask() {
    return getenv("TM_INTERACTIVE_INPUT");
}

bool mode_contains(char *target) {
    
    // Because strsep modifies the string in place, we need to make a copy.
    char *mode_mask = get_tm_interactive_input_mode_mask();
    if (mode_mask == NULL) return false;
    char *mode_mask_copy = strdup(mode_mask);
    char *strsep_index = mode_mask_copy;
    
    char *mode_flag = NULL;
    bool contains = false;
    
    while ((mode_flag = strsep(&strsep_index, "|")) != NULL) {
        if (strcmp(mode_flag, target) == 0) {
            contains = true;
            break;
        }
    }
    
    free(mode_mask_copy);
    return contains;
}

bool tm_interactive_input_is_active() {
    return (get_tm_interactive_input_mode_mask() != NULL && mode_contains("NEVER") == false);
}

bool tm_interactive_input_is_in_always_mode() {
    return mode_contains("ALWAYS");
}

bool tm_interactive_input_is_in_echo_mode() {
    return mode_contains("ECHO");
}