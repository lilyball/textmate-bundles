
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

size_t copy_cfstr_into_cstr(CFStringRef cfstr, char *cstr, size_t cstr_length) {
 
    CFIndex cfstr_length = CFStringGetLength(cfstr);

    CFRange copy_range; 
    copy_range.location = 0;
    copy_range.length = (cfstr_length < cstr_length) ? cfstr_length : cstr_length;
    
    CFIndex copy_count;
 
    CFStringGetBytes(cfstr, copy_range, kCFStringEncodingUTF8, 0, false, (UInt8 *)cstr, cstr_length, &copy_count);
    D("cstr_2_cfstr(): cstr after copy == '%s'\n", cstr);
    return copy_count;
}