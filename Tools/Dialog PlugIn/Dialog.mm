#import "Dialog.h"

#ifndef enumerate
#define enumerate(container,var) for(NSEnumerator* _enumerator = [container objectEnumerator]; var = [_enumerator nextObject]; )
#endif

@interface CatchAllNibLoader : NSObject
{
}
@end

@implementation CatchAllNibLoader
- (void)setValue:(id)aValue forKey:(NSString*)aKey
{
	NSLog(@"%s %@ = %@", _cmd, aKey, aValue);
}
@end

@interface DialogServer : NSObject <TextMateDialogServerProtocol>
{
}
@end

@implementation DialogServer
- (int)textMateDialogServerProtocolVersion
{
	return 1;
}

- (void)showNib:(NSString*)aNibPath withArguments:(id)someArguments
{
	NSFileManager* fm = [NSFileManager defaultManager];

	if(![aNibPath hasPrefix:@"/"]) // relative URL
		aNibPath = [[fm currentDirectoryPath] stringByAppendingPathComponent:aNibPath];

	if(![aNibPath hasSuffix:@".nib"])
		aNibPath = [aNibPath stringByAppendingPathExtension:@"nib"];

	if(![fm fileExistsAtPath:aNibPath])
	{
		NSLog(@"%s nib file not found: %@", _cmd, aNibPath);
		return;
	}

	NSNib* nib = [[NSNib alloc] initWithContentsOfURL:[NSURL fileURLWithPath:aNibPath]];
	if(!nib)
	{
		NSLog(@"%s failed loading nib: %@", _cmd, aNibPath);
		return;
	}

	NSMutableArray* topLevelObjects = nil;
	BOOL didInstantiate = [nib instantiateNibWithOwner:[[CatchAllNibLoader new] autorelease] topLevelObjects:&topLevelObjects];
	if(!didInstantiate)
	{
		NSLog(@"%s failed to instantiate nib", _cmd);
	}

	NSLog(@"%s loaded nib with top levle objects %@", _cmd, topLevelObjects);
	enumerate(topLevelObjects, id object)
	{
		if([object isKindOfClass:[NSWindow class]])
			[object makeKeyAndOrderFront:self];
	}
}
@end

@implementation Dialog
- (id)initWithPlugInController:(id <TMPlugInController>)aController
{
	NSApp = [NSApplication sharedApplication];
	if(self = [super init])
	{
		NSConnection* connection = [NSConnection defaultConnection];
		[connection setRootObject:[[DialogServer new] autorelease]];
		if([connection registerName:@"TextMate dialog server"] == NO)
			NSLog(@"couldn't setup TextMate dialog server."), NSBeep();
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}
@end
