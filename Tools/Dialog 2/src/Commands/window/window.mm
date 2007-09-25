#import <string>
#import <vector>
#import <sys/stat.h>
#import "../../Dialog.h"
#import "../../TMDCommand.h"
#import "../../OptionParser.h"

// ==========
// = Window =
// ==========

static unsigned int NibTokenCount = 0;
static NSMutableDictionary* Nibs = [NSMutableDictionary new];

@interface TMDNibController : NSObject
{
	NSArray* topLevelObjects;
	NSWindow* window;
	NSMutableDictionary* parameters;
	NSMutableArray* fileHandles;
	unsigned int token;
	BOOL autoCloses;
}
- (NSWindow*)window;
- (void)setWindow:(NSWindow*)aValue;
- (NSString*)token;
- (void)updateParametersWith:(id)plist;
@end

@interface TMDWindowCommand : TMDCommand
{
}
@end

// ==================
// = Nib Controller =
// ==================

@implementation TMDNibController
- (NSWindow*)window					{ return window; }
- (id)parameters						{ return parameters; }
- (NSString*)token					{ return [NSString stringWithFormat:@"%u", token]; }
- (BOOL)autoCloses					{ return autoCloses; }

- (void)setAutoCloses:(BOOL)flag	{ autoCloses = flag; }

- (void)setWindow:(NSWindow*)aWindow
{
	if(window != aWindow)
	{
		[window setDelegate:nil];
		[window release];
		window = [aWindow retain];
		[window setDelegate:self];
		[window setReleasedWhenClosed:NO]; // incase this was set wrong in IB
	}
}

- (void)setParameters:(id)someParameters
{
	if(parameters != someParameters)
	{
		[parameters release];
		parameters = [someParameters retain];
	}
}

- (void)updateParametersWith:(id)plist
{
	enumerate([plist allKeys], id key)
		[parameters setValue:[plist valueForKey:key] forKey:key];
}

- (void)instantiateNib:(NSNib*)aNib
{
	BOOL didInstantiate = NO;
	@try {
	 	didInstantiate = [aNib instantiateNibWithOwner:self topLevelObjects:&topLevelObjects];
	}
	@catch(NSException* e) {
		// our retain count is too high if we reach this branch (<rdar://4803521>) so no RAII idioms for Cocoa, which is why we have the didLock variable, etc.
		NSLog(@"%s failed to instantiate nib (%@)", _cmd, [e reason]);
		return;
	}

	[topLevelObjects retain];
	enumerate(topLevelObjects, id object)
	{
		if([object isKindOfClass:[NSWindow class]])
			[self setWindow:object];
	}
	
	if(!window)
	{
		NSLog(@"%s didn't find a window in nib", _cmd);
		return;
	}
	
	// if(center)
	// {
	// 	if(NSWindow* keyWindow = [NSApp keyWindow])
	// 	{
	// 		NSRect frame = [window frame], parentFrame = [keyWindow frame];
	// 		[window setFrame:NSMakeRect(NSMidX(parentFrame) - 0.5 * NSWidth(frame), NSMidY(parentFrame) - 0.5 * NSHeight(frame), NSWidth(frame), NSHeight(frame)) display:NO];
	// 	}
	// 	else
	// 	{
	// 		[window center];
	// 	}
	// }

	[window makeKeyAndOrderFront:self];

	// // TODO: When TextMate is capable of running script I/O in it's own thread(s), modal blocking
	// // can go away altogether.
	// if(isModal)
	// 	[NSApp runModalForWindow:window];
}

- (id)initWithNibName:(NSString*)aName
{
	if(self = [super init])
	{
		if(![[NSFileManager defaultManager] fileExistsAtPath:aName])
		{
			NSLog(@"%s nib file not found: %@", _cmd, aName);
			[self release];
			return nil;
		}

		parameters = [[NSMutableDictionary dictionaryWithObjectsAndKeys:
			self, @"controller",
			nil] retain];

		NSNib* nib = [[[NSNib alloc] initWithContentsOfURL:[NSURL fileURLWithPath:aName]] autorelease];
		if(!nib)
		{
			NSLog(@"%s failed loading nib: %@", _cmd, aName);
			[self release];
			return nil;
		}

		token = ++NibTokenCount;
		[self instantiateNib:nib];
	}
	return self;
}

- (void)makeControllersCommitEditing
{
	enumerate(topLevelObjects, id object)
	{
		if([object respondsToSelector:@selector(commitEditing)])
			[object commitEditing];
	}

	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)tearDown
{
	[[self retain] autorelease];

	[parameters removeObjectForKey:@"controller"];
	// [self return:parameters]; // only if the non-async version is used

	// if we do not manually unbind, the object in the nib will keep us retained, and thus we will never reach dealloc
	enumerate(topLevelObjects, id object)
	{
		if([object isKindOfClass:[NSObjectController class]])
			[object unbind:@"contentObject"];
	}

	[Nibs removeObjectForKey:[self token]];
}

- (void)dealloc
{
	NSLog(@"%s TMDNibController", _cmd);
	[self setWindow:nil];
	[self setParameters:nil];

	NSLog(@"%s %@", _cmd, topLevelObjects);
	enumerate(topLevelObjects, id object)
		[object release];
	[topLevelObjects release];

	[fileHandles release];
	[super dealloc];
}

- (void)windowWillClose:(NSNotification*)aNotification
{
	NSLog(@"%s", _cmd);
	[self tearDown];
}

// ==================================
// = Getting stuff from this window =
// ==================================
- (void)notifyFileHandle:(NSFileHandle*)aFileHandle
{
	if(!fileHandles)
		fileHandles = [NSMutableArray new];
	[fileHandles addObject:aFileHandle];
}

- (void)return:(id)res
{
	[self makeControllersCommitEditing];

	enumerate(fileHandles, NSFileHandle* fileHandle)
		[TMDCommand writePropertyList:res toFileHandle:fileHandle];

	[fileHandles release];
	fileHandles = nil;

	if([self autoCloses])
		[self tearDown];
}

// ================================================
// = Faking a returnArgument:[…:]* implementation =
// ================================================
// returnArgument: implementation. See <http://lists.macromates.com/pipermail/textmate/2006-November/015321.html>
- (NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector
{
	NSString* str = NSStringFromSelector(aSelector);
	if([str hasPrefix:@"returnArgument:"])
	{
		std::string types;
		types += @encode(void);
		types += @encode(id);
		types += @encode(SEL);
	
		unsigned numberOfArgs = [[str componentsSeparatedByString:@":"] count];
		while(numberOfArgs-- > 1)
			types += @encode(id);
	
		return [NSMethodSignature signatureWithObjCTypes:types.c_str()];
	}
	return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation*)invocation
{
	NSString* str = NSStringFromSelector([invocation selector]);
	if([str hasPrefix:@"returnArgument:"])
	{
		NSArray* argNames = [str componentsSeparatedByString:@":"];

		NSMutableDictionary* res = [NSMutableDictionary dictionary];
		for(size_t i = 2; i < [[invocation methodSignature] numberOfArguments]; ++i)
		{
			id arg = nil;
			if([invocation getArgument:&arg atIndex:i], arg)
				[res setObject:arg forKey:[argNames objectAtIndex:i - 2]];
		}

		[self return:res];
	}
	else
	{
		[super forwardInvocation:invocation];
	}
}

// ===============================
// = The old performButtonClicl: =
// ===============================
- (IBAction)performButtonClick:(id)sender
{
	NSMutableDictionary* res = [[parameters mutableCopy] autorelease];
	[res removeObjectForKey:@"controller"];

	if([sender respondsToSelector:@selector(title)])
		[res setObject:[sender title] forKey:@"returnButton"];
	if([sender respondsToSelector:@selector(tag)])
		[res setObject:[NSNumber numberWithInt:[sender tag]] forKey:@"returnCode"];

	[self return:res];
}
@end

// ===================
// = Command handler =
// ===================

std::string find_nib (std::string nibName, std::string currentDirectory)
{
	std::vector<std::string> candidates;

	if(nibName.find(".nib") == std::string::npos)
		nibName += ".nib";

	if(nibName.size() && nibName[0] != '/') // relative path
	{
		candidates.push_back(currentDirectory + "/" + nibName);

		if(char const* bundleSupport = getenv("TM_BUNDLE_SUPPORT"))
			candidates.push_back(bundleSupport + std::string("/nibs/") + nibName);

		if(char const* supportPath = getenv("TM_SUPPORT_PATH"))
			candidates.push_back(supportPath + std::string("/nibs/") + nibName);
	}
	else
	{
		candidates.push_back(nibName);
	}

	iterate(it, candidates)
	{
		fprintf(stderr, "candidate: %s\n", it->c_str());
		struct stat sb;
		if(stat(it->c_str(), &sb) == 0)
			return *it;
	}

	fprintf(stderr, "nib could not be loaded: %s (does not exist)\n", nibName.c_str());
	return "";
}

@implementation TMDWindowCommand
+ (void)load
{
	[super registerObject:[self new] forCommand:@"window"];
}

- (void)handleCommand:(id)options
{
	NSLog(@"%s TMDNib %@", _cmd, options);

	NSArray* args = [options objectForKey:@"arguments"];

	static option_t const expectedOptions[] =
	{
		{ "c", "center",		option_t::no_argument										},
		{ "d", "defaults",	option_t::required_argument, option_t::plist			},
		{ "m", "modal",		option_t::no_argument										},
		{ "n", "new-items",	option_t::required_argument, option_t::plist			},
		{ "p", "parameters",	option_t::required_argument, option_t::plist			},
		{ "q", "quiet",		option_t::no_argument										},
	};

	NSDictionary* res = ParseOptions(args, expectedOptions);
	NSLog(@"%s %@", _cmd, res);

	NSString* command = [args objectAtIndex:2];
	if([command isEqualToString:@"create"] || [command isEqualToString:@"show"])
	{
		char const* nibName = [[args lastObject] UTF8String];
		char const* nibPath = [[options objectForKey:@"cwd"] UTF8String];
		NSString* nib = [NSString stringWithUTF8String:find_nib(nibName ?: "", nibPath ?: "").c_str()];

		TMDNibController* nibController = [[[TMDNibController alloc] initWithNibName:nib] autorelease];
		[Nibs setObject:nibController forKey:[nibController token]];

		NSFileHandle* fh = [options objectForKey:@"stdout"];
		if([command isEqualToString:@"show"])
		{
			[nibController notifyFileHandle:fh];
			[nibController setAutoCloses:YES];
		}
		else
		{
			[fh writeData:[[nibController token] dataUsingEncoding:NSUTF8StringEncoding]];
		}
	}
	else if([command isEqualToString:@"wait"])
	{
		NSString* token = [args lastObject];
		TMDNibController* nibController = [Nibs objectForKey:token];
		[nibController notifyFileHandle:[options objectForKey:@"stdout"]];
	}
	else if([command isEqualToString:@"update"])
	{
		NSString* token = [args lastObject];
		TMDNibController* nibController = [Nibs objectForKey:token];
		id newParameters = [TMDCommand readPropertyList:[options objectForKey:@"stdin"]];
		[nibController updateParametersWith:newParameters];
	}
	else if([command isEqualToString:@"list"])
	{
		NSFileHandle* fh = [options objectForKey:@"stdout"];
		enumerate([Nibs allKeys], NSString* token)
		{
			TMDNibController* nibController = [Nibs objectForKey:token];
			[fh writeData:[[NSString stringWithFormat:@"%@ (%@)\n", token, [[nibController window] title]] dataUsingEncoding:NSUTF8StringEncoding]];
		}
	}
	else if([command isEqualToString:@"close"])
	{
		NSString* token = [args lastObject];
		[[Nibs objectForKey:token] tearDown];
	}
}
@end
