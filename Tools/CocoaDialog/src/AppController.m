/*
	AppController.m
	CocoaDialog
	Copyright (C) 2004 Mark A. Stratman <mark@sporkstorms.org>
 
	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#import "AppController.h"
#import "CDFileSelectControl.h"
#import "CDMsgboxControl.h"
#import "CDYesNoMsgboxControl.h"
#import "CDOkMsgboxControl.h"
#import "CDTextboxControl.h"
#import "CDProgressbarControl.h"
#import "CDInputboxControl.h"
#import "CDStandardInputboxControl.h"
#import "CDPopUpButtonControl.h"
#import "CDStandardPopUpButtonControl.h"

@implementation AppController

- (void) awakeFromNib
{
	CDControl *control;
	CDOptions *options;
	NSArray *rv;
	NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:10];
	NSString *runMode = nil;

	NSDictionary *globalKeys;
	NSNumber *vOne = [NSNumber numberWithInt:CDOptionsOneValue];
	NSNumber *vNone = [NSNumber numberWithInt:CDOptionsNoValues];
	
	globalKeys = [NSDictionary dictionaryWithObjectsAndKeys:
		vNone, @"help",
		vNone, @"debug",
		vOne,  @"title",
		vOne,  @"width",
		vOne,  @"height",
		vNone, @"string-output",
		vNone, @"no-newline",
		nil];

	[arguments addObjectsFromArray:[[NSProcessInfo processInfo] arguments]];
	if ([arguments count] >= 2) {
		[arguments removeObjectAtIndex:0]; // Remove program name.
		runMode = [arguments objectAtIndex:0];
		[arguments removeObjectAtIndex:0]; // Remove the run-mode
	}

	options = [CDOptions getOpts:arguments availableKeys:globalKeys];
		
	// Bring application into focus.
	// Because this application isn't going to be double-clicked, or
	// launched with the "open" command-line tool, it won't necessarily
	// come to the front automatically.
	[[NSApplication sharedApplication] activateIgnoringOtherApps:YES];

	control = [self chooseControl:runMode useOptions:options];

	if (control != nil) {
		int i = 0;
		
		// Add the control's local options to our global options
		options = [control controlOptionsFromArgs:arguments 
					   withGlobalKeys:globalKeys];
		
		// Run the control (a modal window)
		rv = [control runControlFromOptions:options];
		
		// print all the returned lines
		if (rv != nil) {
			NSFileHandle *fh = [NSFileHandle fileHandleWithStandardOutput];
			for (; i < [rv count]; i++) {
				[fh writeData:[[rv objectAtIndex:i] dataUsingEncoding:NSUTF8StringEncoding]];
				if (![options hasOpt:@"no-newline"]
				    || i+1 < [rv count]) 
				{
					[fh writeData:[[NSString stringWithString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding]];
				}
			}
		} else if ([options hasOpt:@"debug"]) {
			[CDControl debug:@"Control returned nil."];
		}
	} else if ([options hasOpt:@"debug"]
		   || [runMode isEqualToString:@"--debug"]) 
	{
		[CDControl debug:@"No run-mode, or invalid runmode provided as first argument."];
	}
	[NSApp terminate:self];
}

- (CDControl *) chooseControl:(NSString *)runMode useOptions:options
{
	if (runMode == nil || [runMode isEqualToString:@"--help"]) {
		NSLog(@"Available dialog types:\nfileselect, msgbox, yesno-msgbox, ok-msgbox, textbox, progressbar, inputbox, standard-inputbox, dropdown, standard-dropdown.");
		return nil;
	} else if ([runMode isEqualToString:@"fileselect"]) {
		return [[[CDFileSelectControl alloc] initWithOptions:options] autorelease];
	} else if ([runMode isEqualToString:@"msgbox"]) {
		return [[[CDMsgboxControl alloc] initWithOptions:options] autorelease];
	} else if ([runMode isEqualToString:@"yesno-msgbox"]) {
		return [[[CDYesNoMsgboxControl alloc] initWithOptions:options] autorelease];
	} else if ([runMode isEqualToString:@"ok-msgbox"]) {
		return [[[CDOkMsgboxControl alloc] initWithOptions:options] autorelease];
	} else if ([runMode isEqualToString:@"textbox"]) {
		return [[[CDTextboxControl alloc] initWithOptions:options] autorelease];
	} else if ([runMode isEqualToString:@"progressbar"]) {
		return [[[CDProgressbarControl alloc] initWithOptions:options] autorelease];
	} else if ([runMode isEqualToString:@"inputbox"]) {
		return [[[CDInputboxControl alloc] initWithOptions:options] autorelease];
	} else if ([runMode isEqualToString:@"standard-inputbox"]) {
		return [[[CDStandardInputboxControl alloc] initWithOptions:options] autorelease];
	} else if ([runMode isEqualToString:@"dropdown"]) {
		return [[[CDPopUpButtonControl alloc] initWithOptions:options] autorelease];
	} else if ([runMode isEqualToString:@"standard-dropdown"]) {
		return [[[CDStandardPopUpButtonControl alloc] initWithOptions:options] autorelease];
	} else {
		NSLog(@"Unknown dialog type %@. Available types:\nfileselect, msgbox, yesno-msgbox, ok-msgbox, textbox, progressbar, inputbox, standard-inputbox, dropdown, standard-dropdown.",runMode);
		return nil;
	}
}

@end
