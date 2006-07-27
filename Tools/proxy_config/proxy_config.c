/*

    Compile:
        gcc "$TM_FILEPATH" -Wall -arch ppc -arch i386 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -o ~/Library/tm/Support/bin/proxy_config -framework Foundation -framework SystemConfiguration && strip ~/Library/tm/Support/bin/proxy_config

*/

#include <CoreFoundation/CoreFoundation.h>
#include <SystemConfiguration/SystemConfiguration.h>
#include <sys/uio.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>

char const* current_version ()
{
	char res[32];
	return sscanf("$Revision$", "$%*[^:]: %s $", res) == 1 ? res : "???";
}

int main (int argc, char const* argv[])
{
    if(argc != 1)
    {
        int revision = 0;
        fprintf(stderr, "proxy_config r%d: dump proxy config as an XML property list\nCurrently no arguments are supported.\n", current_version());
    }
    else
    {
    	CFDictionaryRef plist = SCDynamicStoreCopyProxies(NULL);
    	CFDataRef data = CFPropertyListCreateXMLData(kCFAllocatorDefault, plist);
    	write(1, CFDataGetBytePtr(data), CFDataGetLength(data));
    }
	return 0;
}
