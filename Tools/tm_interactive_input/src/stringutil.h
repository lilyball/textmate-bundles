#ifndef _STRINGUTIL_H_
#define _STRINGUTIL_H_

#include <CoreFoundation/CoreFoundation.h>
#include <sys/types.h>

char* cfstr_2_cstr(CFStringRef);
CFStringRef cstr_2_cfstr(char*);

#endif /* _STRINGUTIL_H_ */