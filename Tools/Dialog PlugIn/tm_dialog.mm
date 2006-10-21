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

char const* AppName = "tm_dialog";

char const* current_version ()
{
	char res[32];
	return sscanf("$Revision: 1 $", "$%*[^:]: %s $", res) == 1 ? res : "???";
}

@protocol TextMateDialogServerProtocol
- (int)textMateDialogServerProtocolVersion;
- (id)showNib:(NSString*)aNib withArguments:(id)someArguments;
@end

void contact_server (char const* nibName)
{
	id proxy = [NSConnection rootProxyForConnectionWithRegisteredName:@"TextMate dialog server" host:nil];
	[proxy setProtocolForProxy:@protocol(TextMateDialogServerProtocol)];

	if(!proxy)
	{
		fprintf(stderr, "%s: failed to establish connection with TextMate.\n", AppName);
	}
	else if([proxy textMateDialogServerProtocolVersion] >= 1)
	{
		NSString* aNibPath = [NSString stringWithUTF8String:nibName];

		if(![aNibPath hasPrefix:@"/"]) // relative URL
			aNibPath = [[[NSFileManager defaultManager] currentDirectoryPath] stringByAppendingPathComponent:aNibPath];

		if(![aNibPath hasSuffix:@".nib"])
			aNibPath = [aNibPath stringByAppendingPathExtension:@"nib"];

		NSMutableData* data = [NSMutableData data];
		if(isatty(STDIN_FILENO) == 0)
		{
			char buf[1024];
			while(size_t len = read(STDIN_FILENO, buf, sizeof(buf)))
				[data appendBytes:buf length:len];
		}

		id args = [data length] ? [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:nil errorDescription:NULL] : nil;
		[proxy showNib:aNibPath withArguments:args];
	}
	else
	{
		fprintf(stderr, "%s: you need to update this helper tool (server at version %d).\n", AppName, [proxy textMateDialogServerProtocolVersion]);
	}
}

int main (int argc, char* argv[])
{
	if(argc == 2)
	{
		NSAutoreleasePool* pool = [NSAutoreleasePool new];
		contact_server(argv[1]);
		[pool release];
	}
	else
	{
		fprintf(stderr, "%s: «Nib File»\n", AppName);
	}
	return 0;
}
