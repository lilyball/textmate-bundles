// g++ -arch ppc -arch i386 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -DDATE=\"`date +%Y-%m-%d`\" -Os "$TM_FILEPATH" -o ~/Library/tm/Support/bin/play -framework Cocoa && strip ~/Library/tm/Support/bin/play

#import <Cocoa/Cocoa.h>
#import <unistd.h>
#import <libgen.h>

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
	else
	{
		fprintf(stderr, "%s (%s)\nUsage: %1$s file\n", basename(argv[0]), DATE);
	}

	[pool release];
	return 0;
}
