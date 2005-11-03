//
//  Clock.mm
//  Clock
//
//  Created by Allan Odgaard on 2005-10-29.
//  Copyright 2005 MacroMates. All rights reserved.
//

#import "Clock.h"

@interface NSWindowPoser : NSWindow
{
}
@end

@implementation NSWindowPoser
// called when the user switches tabs (or load files)
- (void)setRepresentedFilename:(NSString*)aPath
{
//	NSLog(@"%s %@", _cmd, aPath);
	[super setRepresentedFilename:aPath];
}

// called when a document change state (e.g. when saved to disk)
- (void)setDocumentEdited:(BOOL)flag
{
//	NSLog(@"%s %s", _cmd, flag ? "YES" : "NO");
	[super setDocumentEdited:flag];
}
@end

@implementation Clock
- (id)initWithPlugInController:(id <TMPlugInController>)aController
{
//	[NSWindowPoser poseAsClass:[NSWindow class]];

	NSApp = [NSApplication sharedApplication];
	if(self = [super init])
		[self installMenuItem];
	return self;
}

- (void)dealloc
{
	[self uninstallMenuItem];
	[self disposeClock];
	[super dealloc];
}

- (void)installMenuItem
{
	if(windowMenu = [[[[NSApp mainMenu] itemWithTitle:@"Window"] submenu] retain])
	{
		unsigned index = 0;
		NSArray* items = [windowMenu itemArray];
		for(int separators = 0; index != [items count] && separators != 2; index++)
			separators += [[items objectAtIndex:index] isSeparatorItem] ? 1 : 0;

		showClockMenuItem = [[NSMenuItem alloc] initWithTitle:@"Show Clock" action:@selector(showClock:) keyEquivalent:@""];
		[showClockMenuItem setTarget:self];
		[windowMenu insertItem:showClockMenuItem atIndex:index ? index-1 : 0];
	}
}

- (void)uninstallMenuItem
{
	[windowMenu removeItem:showClockMenuItem];

	[showClockMenuItem release];
	showClockMenuItem = nil;

	[windowMenu release];
	windowMenu = nil;
}

- (void)showClock:(id)sender
{
	if(!clockWindowController)
	{
		NSWindowController* obj = [NSWindowController alloc]; // this is a little hacky, since initXYZ could change the obj, but the path variant of initWithNib needs an owner
		NSString* nibPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Clock" ofType:@"nib"];
		clockWindowController = [obj initWithWindowNibPath:nibPath owner:obj];
	}
	[clockWindowController showWindow:self];
}

- (void)disposeClock
{
	[clockWindowController close];
	[clockWindowController release];
	clockWindowController = nil;
}
@end
