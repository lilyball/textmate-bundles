#import <Cocoa/Cocoa.h>
#import <unistd.h>

@interface SoundDelegate : NSObject { }
@end

@implementation SoundDelegate
- (void)sound:(NSSound*)sound didFinishPlaying:(BOOL)aBool
{
	[NSApp terminate:self];
}
@end

int main (int argc, char const* argv[])
{
	NSAutoreleasePool* pool = [NSAutoreleasePool new];
	NSApp = [NSApplication sharedApplication];

	if(argc == 2)
	{
		NSString* str = [NSString stringWithUTF8String:argv[1]];
		if(NSSound* snd = [[[NSSound alloc] initWithContentsOfFile:str byReference:YES] autorelease])
		{
			[snd setDelegate:[[SoundDelegate new] autorelease]];
			[snd play];
			[NSApp run];
		}
	}

	[pool release];
	return 0;
}
