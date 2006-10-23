#import "Dialog.h"

NSLock* Lock = [NSLock new];

@interface Dialog : NSObject <TextMateDialogServerProtocol>
{
}
- (id)initWithPlugInController:(id <TMPlugInController>)aController;
- (void)dealloc;
@end

@interface NibLoader : NSObject
{
	NSMutableDictionary* parameters;
	NSMutableArray* topLevelObjects;
	NSWindow* window;
	BOOL isModal;
	BOOL center;
}
- (NSDictionary*)instantiateNib:(NSNib*)aNib;
@end

@implementation NibLoader
- (id)initWithParameters:(NSMutableDictionary*)someParameters modal:(BOOL)flag center:(BOOL)shouldCenter
{
	if(self = [super init])
	{
		parameters = [someParameters retain];
		isModal = flag;
		center = shouldCenter;
		[Lock lock];
	}
	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	enumerate(topLevelObjects, id object)
		[object release];
	[topLevelObjects release];
	[parameters release];

	[Lock unlock];
	[super dealloc];
}

- (void)setWindow:(NSWindow*)aWindow
{
	if(window != aWindow)
	{
		[window setDelegate:nil];
		[window release];
		window = [aWindow retain];
		[window setDelegate:self];
	}
}

- (void)cleanupAndRelease
{
	enumerate(topLevelObjects, id object)
	{
		if([object isKindOfClass:[NSObjectController class]])
			[object unbind:@"contentObject"];
	}
	[self setWindow:nil];

	if(isModal)
		[NSApp stopModal];

	[self autorelease];
}

- (void)windowWillClose:(NSNotification*)aNotification
{
	[self cleanupAndRelease];
}

- (void)performButtonClick:(id)sender
{
	if([sender respondsToSelector:@selector(title)])
		[parameters setObject:[sender title] forKey:@"returnButton"];
	if([sender respondsToSelector:@selector(tag)])
		[parameters setObject:[NSNumber numberWithInt:[sender tag]] forKey:@"returnCode"];

	[window orderOut:self];
	[self cleanupAndRelease];
}

- (void)connectionDidDie:(NSNotification*)aNotification
{
	[window orderOut:self];
	[self cleanupAndRelease];

	[NSApp postEvent:[NSEvent otherEventWithType:NSApplicationDefined location:NSZeroPoint modifierFlags:0 timestamp:0.0f windowNumber:0 context:nil subtype:0 data1:0 data2:0] atStart:NO];
}

- (NSDictionary*)instantiateNib:(NSNib*)aNib
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionDidDie:) name:NSPortDidBecomeInvalidNotification object:nil];

	BOOL didInstantiate = [aNib instantiateNibWithOwner:self topLevelObjects:&topLevelObjects];
	if(!didInstantiate)
	{
		NSLog(@"%s failed to instantiate nib", _cmd);
	}

	[topLevelObjects retain];
	enumerate(topLevelObjects, id object)
	{
		if([object isKindOfClass:[NSWindow class]])
			[self setWindow:object];
	}

	if(center)
	{
		if(NSWindow* keyWindow = [NSApp keyWindow])
		{
			NSRect frame = [window frame], parentFrame = [keyWindow frame];
			[window setFrame:NSMakeRect(NSMidX(parentFrame) - 0.5 * NSWidth(frame), NSMidY(parentFrame) - 0.5 * NSHeight(frame), NSWidth(frame), NSHeight(frame)) display:NO];
		}
		else
		{
			[window center];
		}
	}

	[window makeKeyAndOrderFront:self];

	if(isModal && window)
		[NSApp runModalForWindow:window];

	return parameters;
}
@end

@implementation Dialog
- (id)initWithPlugInController:(id <TMPlugInController>)aController
{
	NSApp = [NSApplication sharedApplication];
	if(self = [super init])
		[NSThread detachNewThreadSelector:@selector(vendObject:) toTarget:self withObject:nil];
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (int)textMateDialogServerProtocolVersion
{
	return TextMateDialogServerProtocolVersion;
}

- (id)showNib:(NSString*)aNibPath withParameters:(id)someParameters modal:(BOOL)flag center:(BOOL)shouldCenter
{
	if(![[NSFileManager defaultManager] fileExistsAtPath:aNibPath])
	{
		NSLog(@"%s nib file not found: %@", _cmd, aNibPath);
		return nil;
	}

	NSNib* nib = [[[NSNib alloc] initWithContentsOfURL:[NSURL fileURLWithPath:aNibPath]] autorelease];
	if(!nib)
	{
		NSLog(@"%s failed loading nib: %@", _cmd, aNibPath);
		return nil;
	}

	NibLoader* nibOwner = [[NibLoader alloc] initWithParameters:someParameters modal:flag center:shouldCenter];
	[nibOwner performSelectorOnMainThread:@selector(instantiateNib:) withObject:nib waitUntilDone:YES];
	[Lock lock];
	[Lock unlock];

	return someParameters;
}

- (void)vendObject:(id)arguments
{
	NSAutoreleasePool* pool = [NSAutoreleasePool new];
	
	NSConnection* connection = [NSConnection defaultConnection];
	[connection setRootObject:self];
	if([connection registerName:@"TextMate dialog server"] == NO)
		NSLog(@"couldn't setup TextMate dialog server."), NSBeep();

	[[NSRunLoop currentRunLoop] run];

	[pool release];
}
@end
