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
#import <string>
#import <sys/stat.h>

#import "Dialog.h"

char const* AppName = "tm_dialog";

char const* current_version ()
{
	char res[32];
	return sscanf("$Revision$", "$%*[^:]: %s $", res) == 1 ? res : "???";
}

int contact_server (std::string nibName, bool center, bool modal)
{
	int res = -1;

	id proxy = [NSConnection rootProxyForConnectionWithRegisteredName:@"TextMate dialog server" host:nil];
	[proxy setProtocolForProxy:@protocol(TextMateDialogServerProtocol)];

	if(!proxy)
	{
		fprintf(stderr, "%s: failed to establish connection with TextMate.\n", AppName);
	}
	else if([proxy textMateDialogServerProtocolVersion] == TextMateDialogServerProtocolVersion)
	{
		NSString* aNibPath = [NSString stringWithUTF8String:nibName.c_str()];

		NSMutableData* data = [NSMutableData data];
		if(isatty(STDIN_FILENO) == 0)
		{
			char buf[1024];
			while(size_t len = read(STDIN_FILENO, buf, sizeof(buf)))
				[data appendBytes:buf length:len];
		}

		id args = [data length] ? [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:nil errorDescription:NULL] : nil;
		NSDictionary* parameters = (NSDictionary*)[proxy showNib:aNibPath withParameters:args modal:modal center:center];
		printf("%s\n", [[parameters description] UTF8String]);
		res = [[parameters objectForKey:@"returnCode"] intValue];
	}
	else
	{
		fprintf(stderr, "%s: server version at v%d, this tool at v%d (they need to match)\n", AppName, [proxy textMateDialogServerProtocolVersion], TextMateDialogServerProtocolVersion);
	}
	return res;
}

void usage ()
{
	fprintf(stderr, 
		"%1$s r%2$s (" DATE ")\n"
		"Usage: %1$s [-cm] nib_file\n"
		"Options:\n"
		" -c, --center           Center the window on screen.\n"
		" -m, --modal            Show window as modal.\n"
		"", AppName, current_version());
}

std::string find_nib (std::string nibName)
{
	std::vector<std::string> candidates;

	if(nibName.find(".nib") == std::string::npos)
		nibName += ".nib";

	if(nibName.size() && nibName[0] != '/') // relative path
	{
		if(char const* currentPath = getcwd(NULL, 0))
			candidates.push_back(currentPath + std::string("/") + nibName);

		if(char const* bundleSupport = getenv("TM_BUNDLE_SUPPORT"))
			candidates.push_back(bundleSupport + std::string("/nibs/") + nibName);

		if(char const* supportPath = getenv("TM_SUPPORT_PATH"))
			candidates.push_back(supportPath + std::string("/nibs/") + nibName);
	}
	else
	{
		candidates.push_back(nibName);
	}

	for(typeof(candidates.begin()) it = candidates.begin(); it != candidates.end(); ++it)
	{
		struct stat sb;
		if(stat(it->c_str(), &sb) == 0)
			return *it;
	}

	fprintf(stderr, "nib could not be loaded: %s (does not exist)\n", nibName.c_str());
	abort();
	return NULL;
}

int main (int argc, char* argv[])
{
	extern int optind;

	static struct option const longopts[] = {
		{ "center",				no_argument,			0,		'c'	},
		{ "modal",				no_argument,			0,		'm'	},
		{ 0,						0,							0,		0		}
	};

	bool center = false, modal = false;
	char ch;
	while((ch = getopt_long(argc, argv, "cm", longopts, NULL)) != -1)
	{
		switch(ch)
		{
			case 'c':	center = true;				break;
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
		res = contact_server(find_nib(argv[0]), center, modal);
		[pool release];
	}
	else
	{
		usage();
	}
	return res;
}
