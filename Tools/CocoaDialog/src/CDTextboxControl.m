/*
	CDTextboxControl.m
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

#import "CDTextboxControl.h"


@implementation CDTextboxControl

- (NSDictionary *) availableKeys
{
	NSNumber *vOne = [NSNumber numberWithInt:CDOptionsOneValue];
	NSNumber *vNone = [NSNumber numberWithInt:CDOptionsNoValues];
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
		vOne, @"text",
		vOne, @"text-from-file",
		vOne, @"informative-text",
		vOne, @"button1",
		vOne, @"button2",
		vOne, @"button3",
		vNone, @"editable",
		vNone, @"no-editable",
		vNone, @"selected",
		vNone, @"focus-textbox",
		vOne, @"scroll-to",
		nil];
}

- (NSArray *) runControlFromOptions:(CDOptions *)options
{
	int rv;
	NSAttributedString *text;
	NSString *returnString = nil;

	[self setOptions:options];

	// check that they specified at least a button1
	// return nil if not
	if (![options optValue:@"button1"]) {
		if ([options hasOpt:@"debug"]) {
			[CDControl debug:@"Must supply at least a --button1"];
		}
		return nil;
	}	
	
	// Load Textbox.nib or return nil
	if (![NSBundle loadNibNamed:@"Textbox" owner:self]) {
		if ([options hasOpt:@"debug"]) {
			[CDControl debug:@"Could not load Textbox.nib"];
		}
		return nil;
	}
	
	// set editable
	if ([options hasOpt:@"editable"]) {
		[textView setEditable:YES];
	} else {
		[textView setEditable:NO];
	}

	// set informative text (label outlet)
	if ([options optValue:@"informative-text"]) {
		[label setStringValue:[options optValue:@"informative-text"]];
	} else {
		[label setStringValue:@""];
	}
	
	// Set initial text in textview
	if ([options optValue:@"text"]) {
		text = [[NSAttributedString alloc] initWithString:
			[options optValue:@"text"]];
		[[textView textStorage] setAttributedString:text];
		[textView scrollRangeToVisible:NSMakeRange([text length], 0)];
		[text release];
	} else if ([options optValue:@"text-from-file"]) {
		NSString *contents = [NSString stringWithContentsOfFile:
			[options optValue:@"text-from-file"]];
		if (contents == nil) {
			if ([options hasOpt:@"debug"]) {
				[CDControl debug:@"Could not read file"];
			}
			return nil;
		} else {
			text = [[NSAttributedString alloc] initWithString:contents];
		}
		[[textView textStorage] setAttributedString:text];
		[text release];
	} else {
		[[textView textStorage] setAttributedString:
			[[[NSAttributedString alloc] initWithString:@""] autorelease]];
	}
	
	// set title
	if ([options optValue:@"title"] != nil) {
		[panel setTitle:[options optValue:@"title"]];
	}
		
	// resize if necessary
	if ([self windowNeedsResize:panel]) {
		[panel setContentSize:[self findNewSizeForWindow:panel]];
	}
	
	// scroll to top or bottom (do this AFTER resizing, setting the text, 
	// etc). Default is top
	if ([options optValue:@"scroll-to"] 
	    && [[options optValue:@"scroll-to"] isCaseInsensitiveLike:@"bottom"]) 
	{
		[textView scrollRangeToVisible:
			NSMakeRange([[textView textStorage] length]-1, 0)];
	} else {
		[textView scrollRangeToVisible:NSMakeRange(0, 0)];
	}
	
	// select all the text
	if ([options hasOpt:@"selected"]) {
		[textView setSelectedRange:
			NSMakeRange(0, [[textView textStorage] length])];
	}
	
	// set buttons
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
	
	// Set first responder
	// Why doesn't this work for the button?
	if ([options hasOpt:@"focus-textbox"]) {
		[panel makeFirstResponder:textView];
	} else {
		[panel makeFirstResponder:button1];
	}
	
	// Run modal
	rv = [NSApp runModalForWindow:panel];

	// set returnString
	if ([options hasOpt:@"string-output"]) {
		if (rv == 1) {
			returnString = [options optValue:@"button1"];
		} else if (rv == 2) {
			returnString = [options optValue:@"button2"];
		} else if (rv == 3) {
			returnString = [options optValue:@"button3"];
		}
	} else {
		returnString = [NSString stringWithFormat:@"%d",rv];
	}
		
	if ([options hasOpt:@"editable"]) {
		return [NSArray arrayWithObjects:returnString, 
				[[textView textStorage] string], nil];
	} else {
		return returnString == nil ? nil :
			[NSArray arrayWithObject:returnString];
	}
}

- (IBAction) button1Pressed:(id)sender
{
	[NSApp stopModalWithCode:1];
}

- (IBAction) button2Pressed:(id)sender
{
	[NSApp stopModalWithCode:2];
}

- (IBAction) button3Pressed:(id)sender
{
	[NSApp stopModalWithCode:3];
}


@end
