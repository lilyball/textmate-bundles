#include "mode.h"

#include <string.h>
#include <stdlib.h>

#ifndef MODE_SPECIFIER_ENV_VAR
#define MODE_SPECIFIER_ENV_VAR "TM_INTERACTIVE_INPUT"
#endif

#ifndef ALWAYS_MODE
#define ALWAYS_MODE "ALWAYS"
#endif

#ifndef AUTO_MODE
#define AUTO_MODE "AUTO"
#endif

#ifndef NEVER_MODE
#define NEVER_MODE "NEVER"
#endif

char *mode = NULL;

bool is_active = false;
bool is_active_is_set = false;

bool is_in_always_mode = false;
bool is_in_always_mode_is_set = false;

char* get_tm_interactive_input_mode() {
    if (mode == NULL) {
        mode = getenv(MODE_SPECIFIER_ENV_VAR);
        if (mode == NULL) mode = NEVER_MODE;
    }
    return mode;
}

bool tm_interactive_input_is_active() {
    if (!is_active_is_set) {
        is_active = (strcmp(get_tm_interactive_input_mode(), NEVER_MODE) != 0) ? true : false;
        is_active_is_set = true;
    }
    return is_active;
}

bool tm_interactive_input_is_in_always_mode() {
    if (!is_in_always_mode_is_set) {
        is_in_always_mode = strcmp(get_tm_interactive_input_mode(), ALWAYS_MODE) == 0;
        is_in_always_mode_is_set = true;
    }
    return is_in_always_mode;
}