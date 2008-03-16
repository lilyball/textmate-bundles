#ifndef _STRINGUTIL_H_
#define _STRINGUTIL_H_

#include <CoreFoundation/CoreFoundation.h>
#include <sys/types.h>

char* cfstr_2_cstr(CFStringRef);
CFStringRef cstr_2_cfstr(char*);
size_t copy_cfstr_into_cstr(CFStringRef, char *, size_t);

#endif /* _STRINGUTIL_H_ */