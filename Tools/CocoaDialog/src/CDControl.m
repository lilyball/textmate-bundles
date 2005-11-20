/*
	CDControl.m
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

#import "CDControl.h"


@implementation CDControl

- initWithOptions:(CDOptions *)options
{
	self = [super init];
	_options = [options retain];
	return self;
}
- init
{
	return [self initWithOptions:nil];
}

- (CDOptions *) options { return _options; }
- (void) setOptions:(CDOptions *)options
{
	[options retain];
	[_options release];
	_options = options;
}

- (NSArray *) runControl
{
	if ([self options] != nil) {
		return [self runControlFromOptions:[self options]];
	} else {
		return nil;
	}
}
// This must be overridden
- (NSArray *) runControlFromOptions:(CDOptions *)options
{
	return nil;
}

// This must be overridden if you want local options for your control
- (NSDictionary *) availableKeys
{
	return nil;
}

- (CDOptions *) controlOptionsFromArgs:(NSArray *)args
{
	return [CDOptions getOpts:args availableKeys:[self availableKeys]];
}
- (CDOptions *) controlOptionsFromArgs:(NSArray *)args 
			withGlobalKeys:(NSDictionary *)globalKeys
{
	CDOptions* options;
	NSMutableDictionary *allKeys;
	NSDictionary *localKeys = [self availableKeys];
	if (localKeys != nil) {
		allKeys = [NSMutableDictionary dictionaryWithCapacity:
			[globalKeys count]+[localKeys count]];
		[allKeys addEntriesFromDictionary:globalKeys];
		[allKeys addEntriesFromDictionary:localKeys];
	} else {
		allKeys = [NSMutableDictionary dictionaryWithCapacity:[globalKeys count]];
		[allKeys addEntriesFromDictionary:globalKeys];
		
	}
	options=[CDOptions getOpts:args availableKeys:allKeys];
	if ([options hasOpt:@"help"]) {
		[CDOptions printOpts:allKeys];
		exit(1);
	}
	return options;
}

- (NSSize) findNewSizeForWindow:(NSWindow *)window
{
	NSSize size = NSZeroSize;
	NSSize newSize;
	NSString *width, *height;
	CDOptions *options = [self options];

	if (options == nil || window == nil) {
		return size;
	}
	
	size = [[window contentView] frame].size;
	newSize.width = size.width;
	newSize.height = size.height;
	if ([options hasOpt:@"width"]) {
		width = [options optValue:@"width"];
		if ([width floatValue] != 0.0) {
			size.width = [width floatValue];
		}
	}
	if ([options hasOpt:@"height"]) {
		height = [options optValue:@"height"];
		if ([height floatValue] != 0.0) {
			size.height = [height floatValue];
		}
	}
	if (size.width != newSize.width || size.height != newSize.height) {
		return size;
	} else {
		return NSMakeSize(0.0,0.0);
	}
}
- (BOOL) windowNeedsResize:(NSWindow *)window
{
	NSSize size = [self findNewSizeForWindow:window];
	if (size.width != 0.0 || size.height != 0.0) {
		return YES;
	} else {
		return NO;
	}
}

+ (void) debug:(NSString *)message
{
	NSFileHandle *fh = [NSFileHandle fileHandleWithStandardOutput];
	NSString *output = [NSString stringWithFormat:@"ERROR: %@\n", message]; 
	[fh writeData:[output dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void) dealloc
{
	[_options release];
	[super dealloc];
}

@end
