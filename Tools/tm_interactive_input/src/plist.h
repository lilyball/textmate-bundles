#ifndef _PLIST_H_
#define _PLIST_H_

#include "buffer.h"
#include <CoreFoundation/CoreFoundation.h>

CFPropertyListRef create_plist_from_buffer(buffer_t*);

#endif /* _PLIST_H_ */