#import "Dialog.h"

#ifndef enumerate
#define enumerate(container,var) for(NSEnumerator* _enumerator = [container objectEnumerator]; var = [_enumerator nextObject]; )
#endif

NSLock* Lock = [NSLock new];

@interface Dialog : NSObject
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
}
- (NSDictionary*)instantiateNib:(NSNib*)aNib;
@end

@implementation NibLoader
- (id)initWithParameters:(NSMutableDictionary*)someParameters modal:(BOOL)flag
{
	if(self = [super init])
	{
		parameters = [someParameters retain];
		isModal = flag;
		[Lock lock];
	}
	return self;
}

- (void)dealloc
{
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

- (void)detachFromNib
{
	enumerate(topLevelObjects, id object)
	{
		if([object isKindOfClass:[NSObjectController class]])
			[object unbind:@"contentObject"];
	}
	[self setWindow:nil];
}

- (void)windowWillClose:(NSNotification*)aNotification
{
	[self detachFromNib];
	if(isModal)
		[NSApp stopModal];
	[self autorelease];
}

- (void)performButtonClick:(id)sender
{
	[parameters setObject:[sender title] forKey:@"returnButton"];
	[parameters setObject:[NSNumber numberWithInt:[sender tag]] forKey:@"returnCode"];

	[window orderOut:self];
	[self windowWillClose:nil];
}

- (NSDictionary*)instantiateNib:(NSNib*)aNib
{
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
	[window makeKeyAndOrderFront:self];

	if(isModal && window)
		[NSApp runModalForWindow:window];

	return parameters;
}
@end

@interface ObjectVendor : NSObject <TextMateDialogServerProtocol>
{
}
@end

@implementation ObjectVendor
- (int)textMateDialogServerProtocolVersion
{
	return 2;
}

- (id)showNib:(NSString*)aNibPath withParameters:(id)someParameters modal:(BOOL)flag
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

	NibLoader* nibOwner = [[NibLoader alloc] initWithParameters:someParameters modal:flag];
	[nibOwner performSelectorOnMainThread:@selector(instantiateNib:) withObject:nib waitUntilDone:YES];
	[Lock lock];
	[Lock unlock];

	return someParameters;
}

- (void)vendObject:(Dialog*)dialogServer
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

@implementation Dialog
- (id)initWithPlugInController:(id <TMPlugInController>)aController
{
	NSApp = [NSApplication sharedApplication];
	if(self = [super init])
		[NSThread detachNewThreadSelector:@selector(vendObject:) toTarget:[[ObjectVendor new] autorelease] withObject:self];
	return self;
}

- (void)dealloc
{
	[super dealloc];
}
@end
