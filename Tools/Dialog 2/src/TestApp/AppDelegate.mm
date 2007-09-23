//
//  AppDelegate.mm
//  Created by Allan Odgaard on 2007-09-22.
//

#import <Carbon/Carbon.h>
#import "../TMDCommand.h"
#import "AppDelegate.h"

@implementation AppDelegate
- (void)dispatch:(id)options
{
	NSArray* args           = [options objectForKey:@"arguments"];
	NSString* cwd           = [options objectForKey:@"cwd"];
	NSFileHandle* stdin_fh  = [NSFileHandle fileHandleForReadingAtPath:[options objectForKey:@"stdin"]];
	NSFileHandle* stdout_fh = [NSFileHandle fileHandleForWritingAtPath:[options objectForKey:@"stdout"]];
	NSFileHandle* stderr_fh = [NSFileHandle fileHandleForWritingAtPath:[options objectForKey:@"stderr"]];

	NSDictionary* newOptions = [NSDictionary dictionaryWithObjectsAndKeys:
		stdin_fh,	@"stdin",
		stdout_fh,	@"stdout",
		stderr_fh,	@"stderr",
		args,			@"arguments",
		cwd,			@"cwd",
		nil];

	NSString* command = [args count] <= 1 ? @"help" : [args objectAtIndex:1];
	id target = [TMDCommand objectForCommand:command];
	NSLog(@"%s target: %@", _cmd, target);
	[(target ?: self) performSelector:@selector(handleCommand:) withObject:newOptions];
}

- (void)hello:(id)options
{
	NSLog(@"%s %@", _cmd, options);
	[self performSelector:@selector(dispatch:) withObject:options afterDelay:0.0];
}

- (void)handleCommand:(id)options
{
	NSLog(@"%s fallback", _cmd);
	NSFileHandle* stderr_fh = [options objectForKey:@"stderr"];
	[stderr_fh writeData:[@"No such command\n" dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)awakeFromNib
{
	[TMDCommand registerObject:self forCommand:@"help"];

	NSConnection* connection = [NSConnection new];
	[connection setRootObject:self];
	if([connection registerName:@"com.macromates.dialog"] == NO)
	{
		NSLog(@"couldn't setup dialog server."), NSBeep();
		[NSApp terminate:self];
	}
}
@end
