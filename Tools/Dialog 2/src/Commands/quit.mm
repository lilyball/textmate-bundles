#import "../TMDCommand.h"

// ========
// = Quit =
// ========

@interface TMDQuitCommand : TMDCommand
{
}
@end

@implementation TMDQuitCommand
+ (void)load
{
	[TMDCommand registerObject:[self new] forCommand:@"quit"];
}

- (void)handleCommand:(id)options
{
	[NSApp terminate:self];
}
@end

