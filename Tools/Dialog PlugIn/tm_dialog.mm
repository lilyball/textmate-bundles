/*
    g++ -Wmost -arch ppc -arch i386 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -DDATE=\"`date +%Y-%m-%d`\" -Os "$TM_FILEPATH" -o ~/Library/tm/Support/bin/tm_dialog -framework Cocoa && strip ~/Library/tm/Support/bin/tm_dialog
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

char const* current_version ()
{
	char res[32];
	return sscanf("$Revision: 1 $", "$%*[^:]: %s $", res) == 1 ? res : "???";
}

char const* AppName;

@protocol TextMateDialogServerProtocol
- (int)textMateDialogServerProtocolVersion;
- (void)showNib:(NSString*)aNib withArguments:(id)someArguments;
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
		[proxy showNib:[NSString stringWithUTF8String:nibName] withArguments:nil];
	}
	else
	{
		fprintf(stderr, "%s: you need to update this helper tool (server at version %d).\n", AppName, [proxy textMateDialogServerProtocolVersion]);
	}
}

void usage ()
{
	std::vector<char> pad(10 - std::min(strlen(AppName), size_t(10)), ' ');
	pad.push_back('\0');

	char* buf = NULL;
	int len = 0;
	asprintf(&buf,
		"%1$s r%2$s (" DATE ")\n"
		"Usage: %1$s [-awl<number>rdnhv] [file ...]\n"
		"Options:\n"
		" -a, --async            Do not wait for file to be closed by TextMate.\n"
		" -w, --wait             Wait for file to be closed by TextMate.\n"
		" -l, --line <number>    Place caret on line <number> after loading file.\n"
		" -r, --recent           Add file to Open Recent menu.\n"
		" -d, --change-dir       Change TextMates working directory to that of the file.\n"
		" -n, --no-reactivation  After edit with -w, do not re-activate the calling app.\n"
		" -h, --help             Show this information.\n"
		" -v, --version          Print version information.\n"
		"\n"
		"If multiple files are given, a project is created consisting of these\n"
		"files, -a is then default and -w will be ignored (e.g. \"%1$s *.tex\").\n"
		"\n%4$n"
		"By default %1$s will not wait for the file to be closed\nexcept when used as filter:\n"
		" ls *.tex|%1$s|sh%3$s-w implied\n"
		" %1$s -|cat -n   %3$s-w implied (read from stdin)\n"
		"\n"
		"An exception is made if the command is started as something which ends\nwith \"_wait\". "
		"So to have a command with --wait as default, you can\ncreate a symbolic link like this:\n"
		" ln -s %1$s %1$s_wait\n"
		"\n", AppName, current_version(), &pad[0], &len
	);

	if(strstr(AppName, "_wait") == AppName + strlen(AppName) - 5)
		buf[len] = '\0';
	fprintf(stderr, "%s", buf);
	free(buf);

	exit(-1);
}

void version ()
{
	printf("%s r%s (" DATE ")\n", AppName, current_version());
	exit(-1);
}

NSString* read_from_stdin ()
{
	NSString* res = nil;
	char name[] = "/tmp/textmate stdin XXXXXX.txt";
	int fd = mkstemps(name, 4);
	if(fd != -1)
	{
		if(isatty(STDIN_FILENO) == 1)
			fprintf(stderr, "%s: Reading from stdin... (press CTRL-D to proceed)\n", AppName);

		char buf[1024];
		while(size_t len = read(STDIN_FILENO, buf, sizeof(buf)))
			write(fd, buf, len);
		close(fd);

		res = [[NSString stringWithUTF8String:name] stringByStandardizingPath];
	}
	return res;
}

int main (int argc, char* argv[])
{
#if 0
	extern char* optarg;
	extern int optind;
#endif
	if(AppName = strrchr(argv[0], '/'))
			AppName++;
	else	AppName = argv[0];
#if 0
	static struct option const longopts[] = {
		{ "async",				no_argument,			0,		'a'	},
		{ "wait",				no_argument,			0,		'w'	},
		{ "line",				required_argument,	0,		'l'	},
		{ "recent",				no_argument,			0,		'r'	},
		{ "change-dir",		no_argument,			0,		'd'	},
		{ "no-reactivation",	no_argument,			0,		'n'	},
		{ "help",				no_argument,			0,		'h'	},
		{ "version",			no_argument,			0,		'v'	},
		{ 0,						0,							0,		0		}
	};

	while((ch = getopt_long(argc, argv, "awrdnhvl:", longopts, NULL)) != -1)
	{
		switch(ch)
		{
			case 'a':	should_wait = false;		break;
			case 'w':	should_wait = true;		break;
			case 'l':	line = atoi(optarg);		break;
			case 'r':	add_to_recent = true;	break;
			case 'd':	change_dir = true;		break;
			case 'n':	reactivate = false;		break;
			case 'h':	usage();						break;
			case 'v':	version();					break;
			default:		usage();						break;
		}
	}

	argc -= optind;
	argv += optind;
#endif

	NSAutoreleasePool* pool = [NSAutoreleasePool new];
	NSApp = [NSApplication sharedApplication];

	contact_server(argc == 2 ? argv[1] : "foo");

	[pool release];
	return 0;
}
