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

+ (void) initialize
{
	[self exposeBinding:@"contentValues"];
}

- (void) commonInit
{
	NSButtonCell *	cell = [self cell];
	
	[self setEnabled:( menu != nil && [menu numberOfItems] > 0 )];
	
	// Use alternateImage for pressed state (if there is an alternateImage)
	if( [cell alternateImage] != nil )
	{
		[cell setHighlightsBy:NSCellLightsByContents];
	}
}

- (void) awakeFromNib
{
	[self commonInit];
}

- (void) dealloc
{
	[menu release];
	[super dealloc];
}

// Events

- (void) mouseDown:(NSEvent *)event
{
	if( menu != nil && [menu numberOfItems] > 0 )
	{
		[self highlight:YES];
		[NSMenu popUpContextMenu:menu withEvent:event forView:self withFont:[NSFont systemFontOfSize:[NSFont smallSystemFontSize]]];
		[self highlight:NO];
	}
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
	
	[self setEnabled:( menu != nil && [menu numberOfItems] > 0 )];
}

#if 0
#pragma mark -
#pragma mark Binding Support
#endif

- (void) setMenuFromArray:(NSArray *)array
{
	NSMenu *		newMenu = [[[NSMenu alloc] init] autorelease];
	SEL				action = [self action];
	id 				target = [self target];
	
	unsigned int	objectCount = [array count];
	
	for(unsigned int index = 0; index < objectCount; index += 1)
	{
		NSString *		object = [array objectAtIndex:index];
		NSMenuItem *	item;
		
		item = [newMenu addItemWithTitle:object action:@selector(test:) keyEquivalent:@""];
		
		if( target != nil && action != NULL )
		{
			[item setTarget:target];
			[item setAction:action];
		}

		[item setRepresentedObject:object];
	}
	
	[self setMenu:newMenu];
}

static NSString *	kCXMenuButtonContentValuesContext = @"CXMenuButtonContentValuesContext";

- (void)bind:(NSString *)binding
    toObject:(id)observableObject
 withKeyPath:(NSString *)keyPath
     options:(NSDictionary *)options
{
	if ([binding isEqualToString:@"contentValues"])
	{
		// Establish binding
		[observableObject addObserver:self
							forKeyPath:keyPath
							options:0
							context:kCXMenuButtonContentValuesContext];

		observedObjectForArray	= [observableObject retain];
		observedKeyPathForArray	= [keyPath copy];
		
		// Read initial value
		NSArray * array = [observedObjectForArray valueForKeyPath:observedKeyPathForArray];

		[self setMenuFromArray:array];
		
	}
}

- (void)unbind:(NSString *)binding
{
	if ([binding isEqualToString:@"contentValues"])
	{
		[observedObjectForArray release];
		[observedKeyPathForArray release];
		observedObjectForArray	= nil;
		observedKeyPathForArray	= nil;
		
		[self setMenu:nil];
	}
}


- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
		               context:(void *)context
{
    if (context == kCXMenuButtonContentValuesContext)
    {
		NSArray * array = [observedObjectForArray valueForKeyPath:observedKeyPathForArray];

		[self setMenuFromArray:array];
	}
}

@end

