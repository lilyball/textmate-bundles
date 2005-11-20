/*
	CDFileSelectControl.m
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

#import "CDFileSelectControl.h"


@implementation CDFileSelectControl

- (NSDictionary *) availableKeys
{
	NSNumber *vMul = [NSNumber numberWithInt:CDOptionsMultipleValues];
	NSNumber *vOne = [NSNumber numberWithInt:CDOptionsOneValue];
	NSNumber *vNone = [NSNumber numberWithInt:CDOptionsNoValues];

	return [NSDictionary dictionaryWithObjectsAndKeys:
		vOne,  @"text",
		vNone, @"select-directories",
		vNone, @"no-select-directories",
		vNone, @"select-multiple",
		vNone, @"no-select-multiple",
		vMul,  @"with-extensions",
		vOne,  @"with-directory",
		vOne,  @"with-file",
		nil];
}

- (NSArray *) runControlFromOptions:(CDOptions *)options
{
	int result;
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	NSArray *types = nil;
	NSString *file = nil;
	NSString *dir = nil;
	
	[self setOptions:options];

	// set select-multiple
	if ([options hasOpt:@"select-multiple"]) {
		[panel setAllowsMultipleSelection:YES];
	} else {
		[panel setAllowsMultipleSelection:NO];
	}

	// set select-directories
	if ([options hasOpt:@"select-directories"]) {
		[panel setCanChooseDirectories:YES];
	} else {
		[panel setCanChooseDirectories:NO];
	}

	// set panel title
	if ([options optValue:@"title"] != nil) {
		[panel setTitle:[options optValue:@"title"]];
	}

	// set allowable file extensions (to be used later with 
	// runModal...)
	if ([options optValues:@"with-extensions"] != nil) {
		BOOL hasChanged = NO;
		NSMutableArray *newTypes = nil;
		
		types = [options optValues:@"with-extensions"];
		
		// Strip leading '.' from each extension
		newTypes = [NSMutableArray arrayWithCapacity:
			[[options optValues:@"with-extensions"] count]];
		NSEnumerator *en;
		NSString *extension;
		en = [types objectEnumerator];
		while (extension = [en nextObject]) {
			if ([extension length] > 1
			    && [[extension substringWithRange:NSMakeRange(0,1)]
				    isEqualToString:@"."])
			{
				extension = [extension substringFromIndex:1];
				hasChanged = YES;
			}
			[newTypes addObject:extension];
		}
		if (hasChanged) {
			types = newTypes;
		}
	}

	// set starting file (to be used later with 
	// runModal...) - doesn't work. TODO - FIXME
	if ([options optValue:@"with-file"] != nil) {
		file = [options optValue:@"with-file"];
	}
	// set starting directory (to be used later with runModal...)
	if ([options optValue:@"with-directory"] != nil) {
		dir = [options optValue:@"with-directory"];
	}

	// set message displayed on file select panel
	if ([options optValue:@"text"] != nil) {
		[panel setMessage:[options optValue:@"text"]];
	}

	// resize window if user specified alternate width/height
	if ([self windowNeedsResize:panel]) {
		[panel setContentSize:[self findNewSizeForWindow:panel]];
	}
	
	result = [panel runModalForDirectory:dir file:file types:types];

	if (result == NSOKButton) {
		return [panel filenames];
	} else {
		return [NSArray array];
	}
}


@end
