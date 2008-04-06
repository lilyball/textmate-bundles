#include "stringutil.h"
#include "die.h"
#include "debug.h"

char* cfstr_2_cstr(CFStringRef cfstr) {
    size_t cstr_size = CFStringGetMaximumSizeForEncoding(CFStringGetLength(cfstr), kCFStringEncodingUTF8) + 1;
    char *cstr = malloc(cstr_size);
    if (cstr == NULL) die("failed to allocate to CFStringRef to C string conversion");

    if (!CFStringGetCString(NULL, cstr, cstr_size, kCFStringEncodingUTF8)) {
        die("failed to convert CFStringRef to C string");
    }
    return cstr;
}

CFStringRef cstr_2_cfstr(char* cstr) {
    CFStringRef cfstr = CFStringCreateWithCString(kCFAllocatorDefault, cstr, kCFStringEncodingUTF8);
    if (cfstr == NULL) die("failed to create CFStringRef from %s", cstr);
    return cfstr;
}