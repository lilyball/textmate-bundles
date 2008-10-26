#ifndef DEBUG_H_8I80DRD8
#define DEBUG_H_8I80DRD8

#include <stdio.h>

#ifndef NDEBUG
#define D(format, args...) ; if (true) { FILE *f = fopen("/tmp/tm_interactive_read.log","a"); fprintf(f, "%s(): ", __FUNCTION__); fprintf (f, format,## args); fclose(f); }
#else
#define D(format, args...) 
#endif

#ifndef NDEBUG
#define DB(buffer) write(STDERR_FILENO, buffer->data, buffer->size)
#else
#define DB(buffer) 
#endif

#endif /* end of include guard: DEBUG_H_8I80DRD8 */
