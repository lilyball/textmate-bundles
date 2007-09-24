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
	if(id target = [TMDCommand objectForCommand:command])
			[target performSelector:@selector(handleCommand:) withObject:newOptions];
	else	[stderr_fh writeData:[@"unknown command, try help.\n" dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)hello:(id)options
{
	NSLog(@"%s %@", _cmd, options);
	[self performSelector:@selector(dispatch:) withObject:options afterDelay:0.0];
}

- (void)awakeFromNib
{
	NSConnection* connection = [NSConnection new];
	[connection setRootObject:self];
	if([connection registerName:@"com.macromates.dialog"] == NO)
	{
		NSLog(@"couldn't setup dialog server."), NSBeep();
		[NSApp terminate:self];
	}
}
@end
