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
buffer_t* create_buffer_with(char*, size_t);
buffer_t* create_buffer_from_cfstr(CFStringRef cfstr);
buffer_t * create_buffer_from_file_descriptor(int fd);
buffer_t* create_buffer_of_dictionary_as_xml();
void add_to_buffer(buffer_t*, char*, size_t);
size_t consume_from_head_of_buffer(buffer_t*, char*, size_t);
void destroy_buffer(buffer_t*);


char* create_cstr_from_buffer(buffer_t*);

#endif /* _BUFFER_H_ */



