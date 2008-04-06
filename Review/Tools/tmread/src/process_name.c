#include "process_name.h"
#include "buffer.h"
#include "die.h"
#include "debug.h"

#include <pthread.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>

buffer_t* get_ps_output() {
    pid_t pid = getpid();
    D("pid = %d\n", pid);

    char* get_process_name_command;
    asprintf(&get_process_name_command, "ps -p %i -o ucomm", pid);
    if (get_process_name_command == NULL) die("failed to create ps command");
    D("ps command = %s\n", get_process_name_command);
    sig_t previous_sigchld_handler = signal(SIGCHLD, SIG_DFL);
    FILE* out = popen(get_process_name_command, "r");
    free(get_process_name_command);

    buffer_t* ps_output = create_buffer_from_file_descriptor(fileno(out));

    int ps_result = pclose(out);
    signal(SIGCHLD, previous_sigchld_handler);
    
    if (ps_result != 0) die("ps returned %d, output = %*.s", ps_result, get_buffer_size(ps_output), get_buffer_data(ps_output));
    if (get_buffer_size(ps_output) == 0) die("ps did not return any output");
    
    return ps_output;
}

char* create_process_name() {
    buffer_t* ps_output = get_ps_output();
    
    // ps output has a column name header line, so we need ignore it
    int index_of_process_name_line = strlen("UCOMM\n");
    
    // Ignore any whitespace before the process name
    int first_non_space_char_index;
    for (first_non_space_char_index = index_of_process_name_line; first_non_space_char_index < get_buffer_size(ps_output); ++first_non_space_char_index) {
        if (isspace(get_buffer_byte_at(ps_output, first_non_space_char_index)) == false) break;
    }
    
    // Ignore any whitespace after the process name
    int last_non_space_char_index;
    for (last_non_space_char_index = get_buffer_size(ps_output) - 1; last_non_space_char_index >= index_of_process_name_line; --last_non_space_char_index) {
        if (isspace(get_buffer_byte_at(ps_output, last_non_space_char_index)) == false) break;
    }
    
    size_t process_name_length = last_non_space_char_index - first_non_space_char_index + 1;
    char* process_name = malloc(process_name_length + 1); // +1 for \0
    strncpy(process_name, get_buffer_data(ps_output) + index_of_process_name_line, process_name_length);
    process_name[process_name_length] = '\0';
    
    destroy_buffer(ps_output);
    
    D("process name = %s\n", process_name);
    return process_name;
}
