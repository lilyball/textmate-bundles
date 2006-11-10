//
//  CXBrowserTableView.m
//
//  Created by Chris Thomas on 11/21/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "CXBrowserTableView.h"
#import "CXRoundRects.h"

@implementation CXBrowserTableView

// Select item during a context menu click, but preserve existing selection -- http://www.cocoadev.com/index.pl?RightClickSelectInTableView

- (NSMenu *) menuForEvent:(NSEvent *) event
{
	NSPoint where;
	int row = -1, col = -1;

	where = [self convertPoint:[event locationInWindow] fromView:nil];
	row = [self rowAtPoint:where];
	col = [self columnAtPoint:where];

	if( row >= 0 ) {
		NSTableColumn *column = nil;
		if( col >= 0 ) column = [[self tableColumns] objectAtIndex:col];

		if( [[self delegate] respondsToSelector:@selector( tableView:shouldSelectRow: )] ) {
			if( [[self delegate] tableView:self shouldSelectRow:row] )
				[self selectRow:row byExtendingSelection:NO];
		} else [self selectRow:row byExtendingSelection:NO];
	
		if( [[self dataSource] respondsToSelector:@selector( tableView:menuForTableColumn:row: )] )
			return [[self dataSource] tableView:self menuForTableColumn:column row:row];
		else return [self menu];
	}

	[self deselectAll:nil];
	return [self menu];
}

// Nicer drag highlight -- http://www.cocoadev.com/index.pl?UglyBlackHighlightRectWhenDraggingToNSTableView
// -- modified to use more accurate color and avoid crossing pixel boundaries
static float widthOffset = 5.0;
static float heightOffset = 3.0;

-(void)_drawDropHighlightOnRow:(int)rowIndex
{
	[self lockFocus];
	
	NSRect drawRect = [self rectOfRow:rowIndex];
	
	drawRect.size.width -= widthOffset;
	drawRect.origin.x += widthOffset/2.0;

	drawRect.size.height -= heightOffset;
	drawRect.origin.y += heightOffset/2.0;
	
	drawRect = NSIntegralRect(drawRect);
	
	[[[NSColor alternateSelectedControlColor] colorWithAlphaComponent:0.1]set];
	[NSBezierPath fillRoundRectInRect:drawRect radius:4.0];

	[[NSColor alternateSelectedControlColor] set];
	[NSBezierPath setDefaultLineWidth:2.0];
	[NSBezierPath strokeRoundRectInRect:drawRect radius:4.0];

	[self unlockFocus];
}

@end
