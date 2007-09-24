#import "../TMDCommand.h"

// ========
// = Help =
// ========

@interface TMDHelpCommand : TMDCommand
{
}
@end

@implementation TMDHelpCommand
+ (void)load
{
	[TMDCommand registerObject:[self new] forCommand:@"help"];
}

- (void)handleCommand:(id)options
{
	NSFileHandle* fh = [options objectForKey:@"stderr"];
	[fh writeData:[@"Help is not yet implemented.\n" dataUsingEncoding:NSUTF8StringEncoding]];
}
@end
