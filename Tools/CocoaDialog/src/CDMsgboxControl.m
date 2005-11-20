/*
	CDMsgboxControl.m
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

#import "CDMsgboxControl.h"


@implementation CDMsgboxControl

- (NSDictionary *) availableKeys
{
	NSNumber *vOne = [NSNumber numberWithInt:CDOptionsOneValue];
	NSNumber *vNone = [NSNumber numberWithInt:CDOptionsNoValues];

	return [NSDictionary dictionaryWithObjectsAndKeys:
		vOne, @"text",
		vOne, @"informative-text",
		vOne, @"button1",
		vOne, @"button2",
		vOne, @"button3",
//		vOne, @"style",
		vNone,@"float",
		vOne, @"timeout",
		nil];
}

- (NSArray *) runControlFromOptions:(CDOptions *)options
{
	NSString *returnString = nil;
	
	[self setOptions:options];

	if (![NSBundle loadNibNamed:@"msgbox" owner:self]) {
		if ([options hasOpt:@"debug"]) {
			[CDControl debug:@"Could not load msgbox.nib"];
		}
		return nil;
	}

	[self setButtons];

	// set title
	if ([options optValue:@"title"] != nil) {
		[panel setTitle:[options optValue:@"title"]];
	}
	
	// add the main bold text
	if ([options optValue:@"text"]) {
		[text setStringValue:[options optValue:@"text"]];
	}
	// add the smaller informative text
	if ([options optValue:@"informative-text"]) {
		[informative setStringValue:[options optValue:@"informative-text"]];
	}

	// set alert style
	// TODO fake this. Probably by using the composeAtPoint NSImage functions.
	// TODO come up with some icons or something
//	if ([options hasOpt:@"style"]) { 
//		if ([[options optValue:@"style"] isCaseInsensitiveLike:@"warning"]) {
//			[alert setAlertStyle:NSWarningAlertStyle];
//		} else if ([[options optValue:@"style"] isCaseInsensitiveLike:@"critical"]) {
//			[alert setAlertStyle:NSCriticalAlertStyle];
//		} else {
//			[alert setAlertStyle:NSInformationalAlertStyle];
//		}
//	} else {
//		[alert setAlertStyle:NSInformationalAlertStyle];
//	}

	if ([options hasOpt:@"timeout"]) {
		NSTimeInterval t;
		if ([[NSScanner scannerWithString:[options optValue:@"timeout"]] scanDouble:&t]) {
			[self performSelector:@selector(timeout:) withObject:panel afterDelay:t];
		} else {
			if ([options hasOpt:@"debug"]) {
				[CDControl debug:@"Could not parse the timeout option"];
			}
		}
	}

	if ([self windowNeedsResize:panel]) {
		[panel setContentSize:[self findNewSizeForWindow:panel]];
	}
	
	[panel center];
	if ([options hasOpt:@"float"]) {
		[panel setFloatingPanel: YES];
		[panel setLevel:NSScreenSaverWindowLevel];
	}		
	
	[panel makeKeyAndOrderFront:nil];
	[NSApp run];

	// set returnString
	if ([options hasOpt:@"string-output"]) {
		if (rv == 1) {
			returnString = [button1 title];
		} else if (rv == 2) {
			returnString = [button2 title];
		} else if (rv == 3) {
			returnString = [button3 title];
		} else if (rv == 0) {
			returnString = @"timeout";
		}
	} else {
		returnString = [NSString stringWithFormat:@"%d",rv];
	}
	if (returnString == nil) {
		returnString = @"";
	}
	return [NSArray arrayWithObject:returnString];
}

- (void) setButtons
{
	CDOptions *options = [self options];

	// check that they specified at least a button1
	if (![options optValue:@"button1"]) {
		if ([options hasOpt:@"debug"]) {
			[CDControl debug:@"Must supply at least a --button1"];
		}
		return;
	}
	
	[button1 setTitle:[options optValue:@"button1"]];
	if ([options optValue:@"button2"]) {
		[button2 setTitle:[options optValue:@"button2"]];
		if ([[options optValue:@"button2"] isEqualToString:@"Cancel"]) {
			[button2 setKeyEquivalent:@"\e"];
		}
		if ([options optValue:@"button3"]) {
			[button3 setTitle:[options optValue:@"button3"]];
			if ([[options optValue:@"button3"] isEqualToString:@"Cancel"]) {
				[button3 setKeyEquivalent:@"\e"];
			}
		} else {
			[button3 setEnabled:NO];
			[button3 setHidden:YES];
		}
	} else {
		[button2 setEnabled:NO];
		[button2 setHidden:YES];
		[button3 setEnabled:NO];
		[button3 setHidden:YES];
	}
}

- (IBAction) timeout:(id)sender
{
	rv=0;
	// For some reason, this doesn't return the run loop until the mouse is moved over the window or something. I think it has something to do with threading.
	[NSApp stop:self];
	// So termination is needed or it won't return
	// But since that doesn't return, we have to put the exit stuff here.
	// Bah.
	NSFileHandle *fh = [NSFileHandle fileHandleWithStandardOutput];
	if ([[self options] hasOpt:@"string-output"]) {
		[fh writeData:[@"timeout\n" dataUsingEncoding:NSUTF8StringEncoding]];
	} else {
		[fh writeData:[@"0\n" dataUsingEncoding:NSUTF8StringEncoding]];
	}
	[NSApp terminate:nil];
}

- (IBAction) button1Pressed:(id)sender
{
	rv = 1;
	[NSApp stop:nil];
}

- (IBAction) button2Pressed:(id)sender
{
	rv = 2;
	[NSApp stop:nil];
}

- (IBAction) button3Pressed:(id)sender
{
	rv = 3;
	[NSApp stop:nil];
}


@end
