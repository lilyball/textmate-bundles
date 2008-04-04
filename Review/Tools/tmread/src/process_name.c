#include "process_name.h"
#include "buffer.h"
#include "die.h"
#include "debug.h"
#include <pthread.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>

#ifndef PS_OUTPUT_HEADER
#define PS_OUTPUT_HEADER "UCOMM\n"
#endif

buffer_t* process_name_buffer = NULL;
pthread_mutex_t process_name_buffer_mutex = PTHREAD_MUTEX_INITIALIZER;

void calculate_process_name() {
    pid_t pid = getpid();
    D("pid = %d\n", pid);

    char* get_process_name_command;
    asprintf(&get_process_name_command, "ps -p %i -o ucomm", pid);
    if (get_process_name_command == NULL) die("failed to create ps command");
    D("ps command = %s\n", get_process_name_command);

    FILE* out = popen(get_process_name_command, "r");
    free(get_process_name_command);

    process_name_buffer = create_buffer_from_file_descriptor(fileno(out));

    int ps_result = pclose(out);
    if (ps_result != 0) die("ps returned %d, output = %*.s", ps_result, process_name_buffer->data, process_name_buffer->size);
    if (process_name_buffer->size == 0) die("ps did not return any output");
    
    consume_from_head_of_buffer(process_name_buffer, NULL, strlen(PS_OUTPUT_HEADER));
    if (process_name_buffer->size == 0) die("ps did not return a process name, which usually means there is no process with pid %d", pid);
    
    // ps returns the name with a lot of whitespace at the end, we can backwards looking for the first non space char
    
    int i;
    for (i = process_name_buffer->size - 1; i >= 0; --i) {
        if (isspace(process_name_buffer->data[i]) == false) break;
    }
    
    if (i == process_name_buffer->size - 1) {
        add_to_buffer(process_name_buffer, "\0", 1);
    } else {
        process_name_buffer->data[i + 1] = '\0';
    }
    
    D("process name = %s\n", process_name_buffer->data);
}

char* get_process_name() {
    pthread_mutex_lock(&process_name_buffer_mutex);
    if (process_name_buffer == NULL) calculate_process_name();
    pthread_mutex_unlock(&process_name_buffer_mutex);
    return process_name_buffer->data;
}
