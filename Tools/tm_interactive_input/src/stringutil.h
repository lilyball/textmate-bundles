#ifndef STRINGUTIL_H_UPCIVA7G
#define STRINGUTIL_H_UPCIVA7G

#include <CoreFoundation/CoreFoundation.h>
#include <sys/types.h>

char* cfstr_2_cstr(CFStringRef);
CFStringRef cstr_2_cfstr(char*);

#endif /* end of include guard: STRINGUTIL_H_UPCIVA7G */
