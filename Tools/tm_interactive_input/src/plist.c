#include "plist.h"
#include "debug.h"
#include "stringutil.h"
#include "die.h"

CFPropertyListRef create_plist_from_buffer(buffer_t *buffer) {

    D("creating data ref of buffer\n");

    CFDataRef buffer_as_data = CFDataCreate(kCFAllocatorDefault, (UInt8*)get_buffer_data(buffer), buffer->size);
    if (buffer_as_data == NULL) die("failed to allocate tm_dialog_output_data");

    D("creating property list from data\n");

    CFStringRef error = NULL;
    CFPropertyListRef plist = CFPropertyListCreateFromXMLData(kCFAllocatorDefault, buffer_as_data, kCFPropertyListImmutable, &error);

    if (error) {
        D("creating property list failed\n");
        die(cfstr_2_cstr(error));
    }

    CFRelease(buffer_as_data);

    return plist;
}