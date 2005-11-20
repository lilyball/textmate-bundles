/*
	CDPopUpButtonControl.m
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

#import "CDPopUpButtonControl.h"


@implementation CDPopUpButtonControl

- (NSDictionary *) availableKeys
{
	NSNumber *vNone = [NSNumber numberWithInt:CDOptionsNoValues];
	NSNumber *vOne = [NSNumber numberWithInt:CDOptionsOneValue];
	NSNumber *vMul = [NSNumber numberWithInt:CDOptionsMultipleValues];

	return [NSDictionary dictionaryWithObjectsAndKeys:
		vOne, @"text",
		vOne, @"button1",
		vOne, @"button2",
		vOne, @"button3",
		vMul, @"items",
		vNone, @"exit-onchange",
		vNone, @"pulldown",
		nil];
}

- (NSArray *) runControlFromOptions:(CDOptions *)options
{
	int rv;
	NSString *buttonRv = nil;
	NSString *itemRv   = nil;
	NSArray *items;

	[self setOptions:options];

	// check that they specified at least a button1
	// return nil if not
	if (![options optValue:@"button1"] 
	    && [self isMemberOfClass:[CDPopUpButtonControl class]]) 
	{
		if ([options hasOpt:@"debug"]) {
			[CDControl debug:@"Must supply at least a --button1"];
		}
		return nil;
	}

	// Load PopUpButton.nib or return nil
	if (![NSBundle loadNibNamed:@"PopUpButton" owner:self]) {
		if ([options hasOpt:@"debug"]) {
			[CDControl debug:@"Could not load PopUpButton.nib"];
		}
		return nil;
	}

	// Setup the menu items
	[popup removeAllItems];
	items = [options optValues:@"items"];
	if (items != nil && [items count]) {
		NSEnumerator *en = [items objectEnumerator];
		id obj;
		while (obj = [en nextObject]) {
			[popup addItemWithTitle:(NSString *)obj];
		}
	} else {
		if ([options hasOpt:@"debug"]) {
			[CDControl debug:@"No items provided."];
		}
		return nil;
	}
	[popup selectItemAtIndex:0];

	// set text (label outlet)
	if ([options optValue:@"text"]) {
		[label setStringValue:[options optValue:@"text"]];
	} else {
		[label setStringValue:@""];
	}

	// Set popup/pulldown style
	if ([options hasOpt:@"pulldown"]) {
		[popup setPullsDown:YES];
	} else {
		[popup setPullsDown:NO];
	}

	// set title
	if ([options optValue:@"title"] != nil) {
		[panel setTitle:[options optValue:@"title"]];
	}

	// set the buttons
	[self setButtons];

	// resize if necessary
	if ([self windowNeedsResize:panel]) {
		[panel setContentSize:[self findNewSizeForWindow:panel]];
	}

	// Run modal
	rv = [NSApp runModalForWindow:panel];

	// set return values 
	if ([options hasOpt:@"string-output"]) {
		if (rv == 1) {
			buttonRv = [options optValue:@"button1"];
		} else if (rv == 2) {
			buttonRv = [options optValue:@"button2"];
		} else if (rv == 3) {
			buttonRv = [options optValue:@"button3"];
		} else if (rv == 0) {
			buttonRv = @"0";
		}
		itemRv = [popup titleOfSelectedItem];
	} else {
		buttonRv = [NSString stringWithFormat:@"%d",rv];
		itemRv   = [NSString stringWithFormat:@"%d", [popup indexOfSelectedItem]];
	}
	return [NSArray arrayWithObjects:buttonRv, itemRv, nil];
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

- (IBAction) selectionChanged:(id)sender
{
	if ([[self options] hasOpt:@"exit-onchange"]) {
		[NSApp stopModalWithCode:0];
	}
}

- (void) dealloc
{
	[super dealloc];
}

@end
