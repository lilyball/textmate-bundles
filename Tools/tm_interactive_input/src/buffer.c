#include "buffer.h"
#include "die.h"
#include "debug.h"
#include "stringutil.h"
#include "system_function_overrides.h"
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <stdio.h>
#include <unistd.h>

#ifndef ALLOC_SIZE
#define ALLOC_SIZE 128
#endif

#ifndef READ_BLOCK_SIZE
#define READ_BLOCK_SIZE 1024
#endif

buffer_t* create_buffer() {
    buffer_t* res = malloc(sizeof(buffer_t));
    if (res == NULL)  die("create_buffer() malloc failed");
    res->data = NULL;
    res->size = 0;
    res->capacity = 0;
    return res;
}

size_t get_buffer_size(buffer_t *b) {
    return b->size;
}
size_t get_buffer_capacity(buffer_t *b) {
    return b->capacity;
}
char* get_buffer_data(buffer_t *b) {
    return b->data;
}

char get_buffer_byte_at(buffer_t *b, size_t at) {
    if (at >= b->size) die("buffer access out of range: %d for buffer of size %d", at, b->size);
    return b->data[at];
}

buffer_t* create_buffer_with(char* bytes, size_t len) {
    buffer_t* b = create_buffer();
    b->data = bytes;
    b->size = len;
    b->capacity = len;
    return b;
}

buffer_t* create_buffer_from_cfstr(CFStringRef cfstr) {
    buffer_t* b = create_buffer();
    CFIndex cfstr_length = CFStringGetLength(cfstr);
    CFIndex storage_max_length = CFStringGetMaximumSizeForEncoding(cfstr_length, kCFStringEncodingUTF8);
    b->data = malloc(storage_max_length);

    CFRange copy_range; 
    copy_range.location = 0;
    copy_range.length = cfstr_length;

    CFIndex copy_count;

    CFStringGetBytes(cfstr, copy_range, kCFStringEncodingUTF8, 0, false, (UInt8 *)b->data, storage_max_length, &copy_count);
    b->size = copy_count;
    b->capacity = storage_max_length;
    return b;
}

buffer_t * create_buffer_from_file_descriptor(int fd) {

    char intermediary_buffer[READ_BLOCK_SIZE];
    buffer_t *buffer = create_buffer();

    ssize_t bytes_read;
    do {
        bytes_read = system_read("read", fd, intermediary_buffer, sizeof(intermediary_buffer));
        D("got %zd bytes from fd\n", bytes_read);
        if (bytes_read > 0) {
            add_to_buffer(buffer, intermediary_buffer, bytes_read);
        } else if (bytes_read < 0) {
            D("read error = '%s'\n", strerror(errno));
        }

    } while(bytes_read != 0);

    return buffer;
}

buffer_t* create_buffer_from_dictionary_as_xml(CFDictionaryRef dictionary) {

    CFStringRef error;
    CFWriteStreamRef stream = CFWriteStreamCreateWithAllocatedBuffers(kCFAllocatorDefault, kCFAllocatorDefault);
    if (stream == NULL) die("failed to allocate write stream to write dictionary representation to");
    if (!CFWriteStreamOpen(stream)) die("failed to open write stream to write dictionary representation to");

    CFPropertyListWriteToStream(dictionary, stream, kCFPropertyListXMLFormat_v1_0, &error);

    if (error) {
        die("Writing dictionary to stream failed: %s", cfstr_2_cstr(error));
    }

    CFDataRef data = CFWriteStreamCopyProperty(stream, kCFStreamPropertyDataWritten);
    if (data == NULL) die("failed to extract data from dictionary write stream");

    CFIndex data_length = CFDataGetLength(data);
    char *bytes = malloc(data_length);
    if (bytes == NULL) die("failed to allocate buffer for dictionary representation");

    CFDataGetBytes(data, CFRangeMake(0, data_length), (UInt8 *)bytes);
    buffer_t* buffer = create_buffer_with(bytes, data_length);

    D("buffer = %*s\n", (int)buffer->size, buffer->data);

    return buffer;
}

char* create_cstr_from_buffer(buffer_t* buffer) {
    char *cstr = malloc(buffer->size + 1);
    memcpy(cstr, buffer->data, buffer->size);
    cstr[buffer->size] = '\0';
    return cstr;
}

void add_to_buffer(buffer_t* buffer, char* bytes, size_t len) {
    if (buffer->capacity < buffer->size + len) {
        
        D("Resizing buffer (need to add %d) from %d\n", (int)len, (int)buffer->capacity); 
        buffer->capacity = ceil((buffer->size + len) / ALLOC_SIZE + 1) * ALLOC_SIZE;
        D("New target size = %d\n", (int)buffer->capacity);
        buffer->data = realloc(buffer->data, buffer->capacity);
        if (buffer->data == NULL) die("reallocation of buffer failed");
    }
    memcpy(buffer->data + buffer->size, bytes, len);
    buffer->size += len;
}

size_t consume_from_head_of_buffer(buffer_t* buffer, char* dest, size_t dest_size) {
    D("consuming %d from buffer of size %d\n", (int)dest_size, (int)buffer->size);
    if (buffer->size == 0 || dest_size == 0) return 0;

    size_t consumption_size = (buffer->size < dest_size) ? buffer->size : dest_size;
    D("consumption_size = %d\n", (int)consumption_size);
    
    if (dest != NULL) {
        strncpy(dest, buffer->data, consumption_size);
    }

    buffer->size -= consumption_size;
    D("new_data_size = %d\n", (int)buffer->size);
    memmove(buffer->data, buffer->data + consumption_size, buffer->size);
    return consumption_size;
}

void destroy_buffer(buffer_t* buffer) {
   if (buffer->data != NULL) free(buffer->data);
   free(buffer);
}

int write_buffer_to_fd(buffer_t* b, int fd) {
    return write(fd, b->data, b->size);
}