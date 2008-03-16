#ifndef _DEBUG_H_
#define _DEBUG_H_

#ifndef NDEBUG
#define D(format, args...) fprintf(stderr, format ,## args)
#else
#define D(format, args...) 
#endif

#ifndef NDEBUG
#define DB(buffer) write(STDERR_FILENO, buffer->data, buffer->size)
#else
#define DB(buffer) 
#endif

#endif /* _DEBUG_H_ */


