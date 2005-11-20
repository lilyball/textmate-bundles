/*
	CDInputboxControl.m
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

#import "CDInputboxControl.h"


@implementation CDInputboxControl

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
		vNone,@"no-show",
		vNone,@"float",
		vOne, @"timeout",
		nil];
}

- (NSArray *) runControlFromOptions:(CDOptions *)options
{
	NSString *returnString = nil;

	[self setOptions:options];

	// check that they specified at least a button1
	// return nil if not
	if (![options optValue:@"button1"] 
	    && [self isMemberOfClass:[CDInputboxControl class]]) 
	{
		if ([options hasOpt:@"debug"]) {
			[CDControl debug:@"Must supply at least a --button1"];
		}
		return nil;
	}	
	
	// Load Inputbox.nib or return nil
	NSString *nib = [options hasOpt:@"no-show"] ? @"SecureInputbox" : @"Inputbox";
	if (![NSBundle loadNibNamed:nib owner:self]) {
		if ([options hasOpt:@"debug"]) {
			[CDControl debug:@"Could not load Inputbox.nib"];
		}
		return nil;
	}

	// set informative text (label outlet)
	if ([options optValue:@"informative-text"]) {
		[label setStringValue:[options optValue:@"informative-text"]];
	} else {
		[label setStringValue:@""];
	}
	
	// Set initial text in textfield
	if ([options optValue:@"text"]) {
		[textField setStringValue:[options optValue:@"text"]];
	} else {
		[textField setStringValue:@""];
	}
	inputText = [[textField stringValue] retain];
	
	// set title
	if ([options optValue:@"title"] != nil) {
		[panel setTitle:[options optValue:@"title"]];
	}

	// set the buttons
	[self setButtons];
		
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
	
	// resize if necessary
	if ([self windowNeedsResize:panel]) {
		[panel setContentSize:[self findNewSizeForWindow:panel]];
	}
		
	// select all the text
	if ([options hasOpt:@"selected"]) {
		[textField selectText:self];
	}
	
	// Run modal
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
	return [NSArray arrayWithObjects:returnString, inputText, nil];
}

- (void) setButtons
{
	CDOptions *options = [self options];
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
	return;
}

- (IBAction) button2Pressed:(id)sender
{
	rv = 2;
	[NSApp stop:nil];
	return;
}

- (IBAction) button3Pressed:(id)sender
{
	rv = 3;
	[NSApp stop:nil];
	return;
}

- (void)controlTextDidChange:(NSNotification *)aNotification
{
	[inputText release];
	inputText = [[textField stringValue] retain];
}
- (void) dealloc
{
	[inputText release];
	[super dealloc];
}

@end
