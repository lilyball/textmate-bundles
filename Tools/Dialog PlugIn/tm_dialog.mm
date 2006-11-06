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

bool output_property_list (id plist)
{
	bool res = false;
	NSString* error = nil;
	if(NSData* data = [NSPropertyListSerialization dataFromPropertyList:plist format:NSPropertyListXMLFormat_v1_0 errorDescription:&error])
	{
		if(NSFileHandle* fh = [NSFileHandle fileHandleWithStandardOutput])
		{
			[fh writeData:data];
			res = true;
		}
	}
	else
	{
		fprintf(stderr, "%s: %s\n", AppName, [error UTF8String] ?: "unknown error serializing returned property list");
		fprintf(stderr, "%s\n", [[plist description] UTF8String]);
	}
	return res;
}

int contact_server (std::string nibName, NSMutableDictionary* someParameters, bool center, bool modal, bool quiet)
{
	int res = -1;

	id proxy = [NSConnection rootProxyForConnectionWithRegisteredName:@"TextMate dialog server" host:nil];
	[proxy setProtocolForProxy:@protocol(TextMateDialogServerProtocol)];

	if([proxy textMateDialogServerProtocolVersion] == TextMateDialogServerProtocolVersion)
	{
		NSString* aNibPath = [NSString stringWithUTF8String:nibName.c_str()];

		NSDictionary* parameters = (NSDictionary*)[proxy showNib:aNibPath withParameters:someParameters modal:modal center:center];
		if(!quiet)
			output_property_list(parameters);
		res = [[parameters objectForKey:@"returnCode"] intValue];
	}
	else
	{
		if(proxy)
				fprintf(stderr, "%s: server version at v%d, this tool at v%d (they need to match)\n", AppName, [proxy textMateDialogServerProtocolVersion], TextMateDialogServerProtocolVersion);
		else	fprintf(stderr, "%s: failed to establish connection with TextMate.\n", AppName);
	}
	return res;
}

void usage ()
{
	fprintf(stderr, 
		"%1$s r%2$s (" DATE ")\n"
		"Usage: %1$s [-cmqp] nib_file\n"
		"Usage: %1$s [-p] -u\n"
		"Options:\n"
      " -c, --center               Center the window on screen.\n"
      " -m, --modal                Show window as modal.\n"
      " -q, --quiet                Do not write result to stdout.\n"
      " -p, --parameters <plist>   Provide parameters as a plist.\n"
      " -u, --menu                 Treat parameters as a menu structure.\n"
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
	NSAutoreleasePool* pool = [NSAutoreleasePool new];

	extern int optind;
	extern char* optarg;

	static struct option const longopts[] = {
		{ "center",				no_argument,			0,		'c'	},
		{ "modal",				no_argument,			0,		'm'	},
		{ "parameters",		required_argument,	0,		'p'	},
		{ "quiet",				no_argument,			0,		'q'	},
		{ "menu",				no_argument,			0,		'u'	},
		{ 0,						0,							0,		0		}
	};

	bool center = false, modal = false, quiet = false, menu = false;
	char const* parameters = NULL;
	char ch;
	while((ch = getopt_long(argc, argv, "cmp:qu", longopts, NULL)) != -1)
	{
		switch(ch)
		{
			case 'c':	center = true;				break;
			case 'm':	modal = true;				break;
			case 'p':	parameters = optarg;		break;
			case 'q':	quiet = true;				break;
			case 'u':	menu = true;				break;
			default:		usage();						break;
		}
	}

	argc -= optind;
	argv += optind;

	// ===================
	// = read parameters =
	// ===================
	
	NSMutableData* data = [NSMutableData data];
	if(parameters)
	{
		[data appendBytes:parameters length:strlen(parameters)];
	}
	else
	{
		if(isatty(STDIN_FILENO) == 0)
		{
			char buf[1024];
			while(size_t len = read(STDIN_FILENO, buf, sizeof(buf)))
				[data appendBytes:buf length:len];
		}
	}

	id plist = [data length] ? [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListMutableContainersAndLeaves format:nil errorDescription:NULL] : [NSMutableDictionary dictionary];

	int res = -1;
	if(argc == 1)
	{
		res = contact_server(find_nib(argv[0]), plist, center, modal, quiet);
	}
	else if(menu)
	{
		id proxy = [NSConnection rootProxyForConnectionWithRegisteredName:@"TextMate dialog server" host:nil];
		[proxy setProtocolForProxy:@protocol(TextMateDialogServerProtocol)];

		if([proxy textMateDialogServerProtocolVersion] == TextMateDialogServerProtocolVersion)
		{
			output_property_list([proxy showMenuWithOptions:plist]);
		}
		else
		{
			if(proxy)
					fprintf(stderr, "%s: server version at v%d, this tool at v%d (they need to match)\n", AppName, [proxy textMateDialogServerProtocolVersion], TextMateDialogServerProtocolVersion);
			else	fprintf(stderr, "%s: failed to establish connection with TextMate.\n", AppName);
		}
	}
	else
	{
		usage();
	}

	[pool release];
	return res;
}
