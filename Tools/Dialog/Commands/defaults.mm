#import "../TMDCommand.h"

@interface TMDDefaults : TMDCommand
{
}
@end

@implementation TMDDefaults
+ (void)load
{
	[TMDDefaults registerObject:[self new] forCommand:@"defaults"];
}

- (void)handleCommand:(CLIProxy*)proxy
{
	NSDictionary* args = [proxy parameters];

	if(NSDictionary* defaults = [args objectForKey:@"register"])
	{
		// FIXME this is needed only because we presently can’t express argument constraints (CLIProxy would otherwise correctly validate/convert CLI arguments)
		if([defaults isKindOfClass:[NSString class]])
			defaults = [NSPropertyListSerialization propertyListFromData:[(NSString*)defaults dataUsingEncoding:NSUTF8StringEncoding] mutabilityOption:NSPropertyListImmutable format:nil errorDescription:NULL];

		[[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
	}

	if(NSString* key = [args objectForKey:@"read"])
	{
		if(id obj = [[NSUserDefaults standardUserDefaults] objectForKey:key])
			[TMDCommand writePropertyList:obj toFileHandle:[proxy outputHandle]];
	}
}

- (NSString *)commandDescription
{
	return @"Register default values for user settings.";
}

- (NSString *)usageForInvocation:(NSString *)invocation;
{
	return [NSString stringWithFormat:@"\t%1$@ --register '{ webOutputTheme = night; }'\n", invocation];
}
@end
