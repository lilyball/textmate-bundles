#import "Dialog.h"

#ifndef enumerate
#define enumerate(container,var) for(NSEnumerator* _enumerator = [container objectEnumerator]; var = [_enumerator nextObject]; )
#endif

NSLock* Lock = [NSLock new];

@interface CatchAllNibLoader : NSObject
{
	NSMutableDictionary* parameters;
	NSMutableArray* topLevelObjects;
}
- (NSDictionary*)instantiateNib:(NSNib*)aNib;
@end

@implementation CatchAllNibLoader
- (id)initWithParameters:(NSMutableDictionary*)someParameters
{
	if(self = [super init])
	{
		parameters = [someParameters retain];
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

- (void)windowWillClose:(NSNotification*)aNotification
{
	enumerate(topLevelObjects, id object)
	{
		if([object isKindOfClass:[NSObjectController class]])
			[object unbind:@"contentObject"];
	}
	[[aNotification object] setDelegate:nil];
	[self autorelease];
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
		{
			[object setDelegate:self];
			[object makeKeyAndOrderFront:self];
		}
	}
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
	return 1;
}

- (id)showNib:(NSString*)aNibPath withArguments:(id)someArguments
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

	CatchAllNibLoader* nibOwner = [[CatchAllNibLoader alloc] initWithParameters:someArguments];
	[nibOwner performSelectorOnMainThread:@selector(instantiateNib:) withObject:nib waitUntilDone:YES];
	[Lock lock];
	[Lock unlock];

	return someArguments;
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
