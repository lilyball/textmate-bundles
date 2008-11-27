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

- (NSString *)commandDescription
{
	return @"Gives a brief list of available commands, or usage details for a specific command.";
}

- (NSString *)usageForInvocation:(NSString *)invocation;
{
	return [NSString stringWithFormat:@"%@ help [command]", invocation];
}

- (NSString *)commandSummaryText
{
	NSDictionary *commands = [TMDCommand registeredCommands];
	
	NSMutableString *help = [NSMutableString stringWithCapacity:100];

	int commandCount = 0;
	for(NSEnumerator *enumerator = [commands keyEnumerator]; NSString *commandName = [enumerator nextObject]; )
	{
		if(![commandName hasPrefix:@"x-"])
		{
			++commandCount;
			TMDCommand *command = [commands objectForKey:commandName];
			NSString *description = [command commandDescription];
			[help appendFormat:@"\t%@: %@\n", commandName, description];
		}
	}
	[help insertString:[NSString stringWithFormat:@"%d commands registered:\n", commandCount] atIndex:0];

	[help appendString:@"Use `\"$DIALOG\" help command` for detailed help\n"];

	return help;
}

- (NSString *)helpForCommand:(NSString *)commandName
{
	NSMutableString *help = [NSMutableString stringWithCapacity:100];
	
	TMDCommand *command = nil;
	if(![commandName hasPrefix:@"x-"] && (command = [TMDCommand objectForCommand:commandName]))
	{
		[help appendFormat:@"%@\n\n",[command commandDescription]];
		[help appendFormat:@"%@ usage:\n",commandName];
		[help appendFormat:@"%@\n",[command usageForInvocation:[NSString stringWithFormat:@"\"$DIALOG\" %@", commandName]]];
	}
	else
		[help appendFormat:@"Unknown command '%@'\n", commandName];

	return help;
}

- (void)handleCommand:(CLIProxy*)proxy
{
	NSString *text = @"";
	
	if([proxy numberOfArguments] < 3)
		text = [self commandSummaryText];
	else
		text = [self helpForCommand:[proxy argumentAtIndex:2]];

	[proxy writeStringToError:text];
}
@end
/*
"$DIALOG" help
"$DIALOG" help help
*/