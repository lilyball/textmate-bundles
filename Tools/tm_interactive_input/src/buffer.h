#ifndef _BUFFER_H_
#define _BUFFER_H_

#include <sys/types.h>
#include <CoreFoundation/CoreFoundation.h>

typedef struct {
    char* data;
    size_t size;
    size_t capacity;
} buffer_t;

buffer_t* create_buffer();
void destroy_buffer(buffer_t*);
size_t get_buffer_size(buffer_t*);
size_t get_buffer_capacity(buffer_t*);
char* get_buffer_data(buffer_t*);
char get_buffer_byte_at(buffer_t*, size_t);
buffer_t* create_buffer_with(char*, size_t);
buffer_t* create_buffer_from_cfstr(CFStringRef);
buffer_t * create_buffer_from_file_descriptor(int);
buffer_t* create_buffer_from_dictionary_as_xml(CFDictionaryRef);
char* create_cstr_from_buffer(buffer_t*);
void add_to_buffer(buffer_t*, char*, size_t);
size_t consume_from_head_of_buffer(buffer_t*, char*, size_t);
int write_buffer_to_fd(buffer_t*, int);

#endif /* _BUFFER_H_ */
