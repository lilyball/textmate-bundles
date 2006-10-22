/*
    g++ -Wmost -arch ppc -arch i386 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -DDATE=\"`date +%Y-%m-%d`\" -Os "$TM_FILEPATH" -o "$TM_SUPPORT_PATH/bin/tm_dialog" -framework Foundation && strip "$TM_SUPPORT_PATH/bin/tm_dialog"
*/
#import <Cocoa/Cocoa.h>
#import <getopt.h>
#import <fcntl.h>
#import <stdio.h>
#import <string.h>
#import <stdlib.h>
#import <unistd.h>
#import <errno.h>
#import <vector>

#import "Dialog.h"

char const* AppName = "tm_dialog";

char const* current_version ()
{
	char res[32];
	return sscanf("$Revision: 1 $", "$%*[^:]: %s $", res) == 1 ? res : "???";
}

int contact_server (char const* nibName, bool modal)
{
	int res = -1;

	id proxy = [NSConnection rootProxyForConnectionWithRegisteredName:@"TextMate dialog server" host:nil];
	[proxy setProtocolForProxy:@protocol(TextMateDialogServerProtocol)];

	if(!proxy)
	{
		fprintf(stderr, "%s: failed to establish connection with TextMate.\n", AppName);
	}
	else if([proxy textMateDialogServerProtocolVersion] >= 2)
	{
		NSString* aNibPath = [NSString stringWithUTF8String:nibName];

		if(![aNibPath hasPrefix:@"/"]) // relative URL
			aNibPath = [[[NSFileManager defaultManager] currentDirectoryPath] stringByAppendingPathComponent:aNibPath];

		if(![aNibPath hasSuffix:@".nib"] && ![aNibPath hasSuffix:@".nib/"])
			aNibPath = [aNibPath stringByAppendingPathExtension:@"nib"];

		NSMutableData* data = [NSMutableData data];
		if(isatty(STDIN_FILENO) == 0)
		{
			char buf[1024];
			while(size_t len = read(STDIN_FILENO, buf, sizeof(buf)))
				[data appendBytes:buf length:len];
		}

		id args = [data length] ? [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:nil errorDescription:NULL] : nil;
		NSDictionary* parameters = (NSDictionary*)[proxy showNib:aNibPath withParameters:args modal:modal];
		printf("%s\n", [[parameters description] UTF8String]);
		res = [[parameters objectForKey:@"returnCode"] intValue];
	}
	else
	{
		fprintf(stderr, "%s: you need to update this helper tool (server at version %d).\n", AppName, [proxy textMateDialogServerProtocolVersion]);
	}
	return res;
}

void usage ()
{
	fprintf(stderr, "%s: -m/--modal «nib file»\n", AppName);
}

int main (int argc, char* argv[])
{
	extern int optind;

	static struct option const longopts[] = {
		{ "modal",				no_argument,			0,		'm'	},
		{ 0,						0,							0,		0		}
	};

	bool modal = false;
	char ch;
	while((ch = getopt_long(argc, argv, "m", longopts, NULL)) != -1)
	{
		switch(ch)
		{
			case 'm':	modal = true;				break;
			default:		usage();						break;
		}
	}

	argc -= optind;
	argv += optind;

	int res = -1;
	if(argc == 1)
	{
		NSAutoreleasePool* pool = [NSAutoreleasePool new];
		res = contact_server(argv[0], modal);
		[pool release];
	}
	else
	{
		usage();
	}
	return res;
}
