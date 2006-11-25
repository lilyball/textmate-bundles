//
//  CXMenuButton.m
//
//  Created by Chris Thomas on 2006-10-09.
//  Copyright 2006 Chris Thomas. All rights reserved.
//	MIT license.
//

#import "CXMenuButton.h"

@implementation CXMenuButton

// Initialization

- (void) commonInit
{
	// Use alternateImage for pressed state
	[[self cell] setHighlightsBy:NSCellLightsByContents];
}

- (void) awakeFromNib
{
	[self commonInit];
}

// Events

- (void) mouseDown:(NSEvent *)event
{
	[self highlight:YES];
	
	[NSMenu popUpContextMenu:menu withEvent:event forView:self withFont:[NSFont systemFontOfSize:[NSFont smallSystemFontSize]]];
	[self highlight:NO];
}

// Accessors

- (NSMenu *)menu
{
	return menu;
}

- (void)setMenu:(NSMenu *)aValue
{
	NSMenu *oldMenu = menu;
	menu = [aValue retain];
	[oldMenu release];
}

#if 0
#pragma mark -
#pragma mark Array synchronization

- (void) setMenuFromArray:(NSArray *)array
{
	NSMenu * newMenu = [[[NSMenu alloc] init] autorelease];
	
	unsigned int	objectCount = [array count];

	for(unsigned int index = 0; index < objectCount; index += 1)
	{
		NSString *		object = [array objectAtIndex:index];
		NSMenuItem *	item;
		
		item = [newMenu addItemWithTitle:object action:@selector(test:) keyEquivalent:@""];
		
	}
	
	[self setMenu:newMenu];
}

static NSString *	kCXMenuButtonArrayContext = @"CXMenuButtonArrayContext";

- (void)bind:(NSString *)binding
    toObject:(id)observableObject
 withKeyPath:(NSString *)keyPath
     options:(NSDictionary *)options
{
	if ([binding isEqualToString:@"array"])
	{
		[observableObject addObserver:self
							forKeyPath:keyPath
							options:0
							context:kCXMenuButtonArrayContext];

		observedObjectForArray	= [observableObject retain];
		observedKeyPathForArray	= [keyPath copy];
	}
}


- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
{
    if (context == kCXMenuButtonArrayContext)
    {
		id array = [observedObjectForArray valueForKeyPath:observedKeyPathForArray];
		
		[self setMenuFromArray:array];
	}
 
	[self setNeedsDisplay:YES];
}
#endif

@end




