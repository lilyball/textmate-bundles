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

char* get_tm_interactive_input_mode() {
    return getenv(MODE_SPECIFIER_ENV_VAR);
}

bool tm_interactive_input_is_active() {
    return (strcmp(get_tm_interactive_input_mode(), NEVER_MODE) != 0) ? true : false;
}

bool tm_interactive_input_is_in_always_mode() {
    return strcmp(get_tm_interactive_input_mode(), ALWAYS_MODE) == 0;
}