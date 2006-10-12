//
//  CXTextWithButtonStripCell.m
//  NSCell supporting iTunes-store-ish action buttons
//
//  Created by Chris Thomas on 2006-10-11.
//  Copyright 2006 Chris Thomas. All rights reserved.
//

#import "CXTextWithButtonStripCell.h"
#import "CXShading.h"

#define kVerticalMargin					1.0
#define kHorizontalMargin				2.0
#define kMarginBetweenTextAndButtons	8.0
#define kIconButtonWidth				18.0

@interface NSBezierPath (CXBezierPathAdditions)
+ (NSBezierPath*)bezierPathWithCapsuleRect:(NSRect)rect;
@end

@implementation NSBezierPath (CXBezierPathAdditions)

+ (NSBezierPath*)bezierPathWithCapsuleRect:(NSRect)rect
{
	NSBezierPath	*	path = [self bezierPath];
	float				radius = 0.5f * MIN(NSWidth(rect), NSHeight(rect));

	rect = NSInsetRect(rect, radius, radius);

	[path appendBezierPathWithArcWithCenter:NSMakePoint(NSMinX(rect), NSMidY(rect)) radius:radius startAngle:90.0 endAngle:270.0];
	[path appendBezierPathWithArcWithCenter:NSMakePoint(NSMaxX(rect), NSMidY(rect)) radius:radius startAngle:270.0 endAngle:90.0];
	[path closePath];
	return path;
}

@end


@implementation CXTextWithButtonStripCell

#if 0
#pragma mark -
#pragma mark Geometry
#endif

// Maintaining a cache of the rects simplifies the rest of the code
- (void)calcButtonRects
{
	NSRect			buttonRect		= NSMakeRect(0,0,16,16);
	unsigned int	buttonsCount	= [fButtons count];
	float			currentX		= 0.0;
	float 			currentButtonWidth;

	for(unsigned int index = 0; index < buttonsCount; index += 1)
	{
		NSMutableDictionary *	buttonDefinition = [fButtons objectAtIndex:index];

		currentButtonWidth = kIconButtonWidth; 	// TODO support text string too
		// [self sizeOfButton:buttonDefinition];

		buttonRect.origin.x		= currentX;
		buttonRect.size.width 	= currentButtonWidth;

		NSValue *	rectValue = [NSValue valueWithRect:buttonRect];			
		[buttonDefinition setObject:rectValue forKey:@"_cachedRect"];

		currentX += (currentButtonWidth + kHorizontalMargin);
		
	}	
	fButtonStripWidth = currentX;
}

- (NSRect)rectForButtonAtIndex:(UInt32)rectIndex inCellFrame:(NSRect)cellFrame
{	
	NSRect buttonRect = [[[fButtons objectAtIndex:rectIndex] objectForKey:@"_cachedRect"] rectValue];
	if( !fRightToLeft )
	{
		// Left to right: need to offset the buttonRects to the right edge of the cellFrame
		buttonRect = NSOffsetRect(buttonRect, NSMaxX(cellFrame) - fButtonStripWidth, 0.0);
	}

	buttonRect.origin.y		= cellFrame.origin.y;
	buttonRect.size.height	= cellFrame.size.height;
	
	return buttonRect;
}


#if 0
#pragma mark -
#pragma mark Mouse tracking
#endif

- (UInt32) buttonIndexAtPoint:(NSPoint)point inRect:(NSRect)cellFrame ofView:(NSView *)controlView
{
	UInt32			buttonIndexHit	= NSNotFound;
	unsigned int	buttonsCount	= [fButtons count];
	
	for( unsigned int i = 0; i < buttonsCount; i += 1 )
	{
		NSRect buttonRect = [self rectForButtonAtIndex:i inCellFrame:cellFrame];
		
		if( [controlView mouse:point inRect:buttonRect] )
		{
			buttonIndexHit = i;
			break;
		}
	}
	
	return buttonIndexHit;
}

+ (BOOL)prefersTrackingUntilMouseUp
{
	return YES;
}

- (BOOL)trackMouse:(NSEvent *)theEvent inRect:(NSRect)cellFrame ofView:(NSView *)controlView untilMouseUp:(BOOL)flag
{
	NSPoint origPoint;
	NSPoint	curPoint;
	BOOL	firstIteration	= YES;
	BOOL	handledMouseUp	= YES;

    origPoint	= [controlView convertPoint:[theEvent locationInWindow] fromView:nil];
	curPoint	= origPoint;

    for (;;)
	{
		UInt32 hitButton = [self buttonIndexAtPoint:[controlView convertPoint:[theEvent locationInWindow] fromView:nil]
							inRect:cellFrame
							ofView:controlView];
		
		// Exit early if the first hit wasn't a button
		if( firstIteration && hitButton == NSNotFound )
		{
			handledMouseUp = NO;
			break;
		}
		
		// Got a hit?
		if( hitButton != fButtonPressedIndex )
		{
			// Refresh old button
			if(fButtonPressedIndex != NSNotFound)
			{
				[controlView setNeedsDisplayInRect:[self rectForButtonAtIndex:fButtonPressedIndex inCellFrame:cellFrame]];
			}
			
			// Refresh current button
			if(hitButton != NSNotFound)
			{
				[controlView setNeedsDisplayInRect:[self rectForButtonAtIndex:hitButton inCellFrame:cellFrame]];
			}
			
			fButtonPressedIndex = hitButton;
		}
		
		// Next event
        theEvent = [[controlView window] nextEventMatchingMask:(NSLeftMouseDraggedMask | NSLeftMouseUpMask)];
        curPoint = [controlView convertPoint:[theEvent locationInWindow] fromView:nil];

        if ([theEvent type] == NSLeftMouseUp)
		{
			fButtonPressedIndex = NSNotFound;
            break;
        }

		firstIteration = NO;
    }
    
	return handledMouseUp;
}

#if 0
#pragma mark -
#pragma mark Drawing
#endif


- (void)drawButtonInRect:(NSRect)rect selected:(BOOL)selected
{
	NSColor * 	borderColor		= [NSColor lightGrayColor];
	NSColor *	lightColor		= [NSColor colorWithDeviceWhite:1.0 alpha:1.0];
	NSColor *	darkColor		= [NSColor colorWithDeviceWhite:0.85 alpha:1.0];

	// On?
	if( [self isHighlighted] )
	// [self state] == NSOnState
		//&& ([self showsStateBy] != NSNoCellMask) )
	{
		NSColor *	litColor				= [NSColor colorForControlTint:[NSColor currentControlTint]];

		darkColor		= [[darkColor shadowWithLevel:0.1] blendedColorWithFraction:0.7 ofColor:litColor];
	}

	// Highlighted?
	if( selected )
	{
		// swap
		NSColor *	newDarkColor = lightColor;

		lightColor = darkColor;
		darkColor = newDarkColor;
	}

	//
	// Outline
	// offset by 0.5 so we sit on pixel boundaries for nice, crisp lines
	NSBezierPath * path = [NSBezierPath bezierPathWithCapsuleRect:NSInsetRect(rect, 0.5f, 0.5f)];
//	NSBezierPath * path = [NSBezierPath bezierPathWithRect:NSInsetRect(rect, 1.0f, 1.0f)];
//	NSBezierPath * path = [NSBezierPath bezierPathWithRect:rect];

	[path setLineWidth:0.0f];

	// Interior
	[NSGraphicsContext saveGraphicsState];

		[path addClip];
		[CXShading fillRect:rect withVerticalLinearShadingFromColor:lightColor
																 toColor:darkColor];
	[NSGraphicsContext restoreGraphicsState];

	// Button outline goes on top of the fill, so that we don't lose the inner antialising.
	[borderColor set];
	[path stroke];

	// TODO: draw icon or text
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	unsigned int	buttonsCount	= [fButtons count];
	
	for( unsigned int i = 0; i < buttonsCount; i += 1 )
	{
		NSRect buttonRect = [self rectForButtonAtIndex:i inCellFrame:cellFrame];
		
		[self drawButtonInRect:buttonRect selected:(fButtonPressedIndex == i)];
	}
	
	if( fRightToLeft )
	{
		cellFrame.origin.x += (fButtonStripWidth + kMarginBetweenTextAndButtons);
	}
	else
	{
		cellFrame.size.width -= (fButtonStripWidth + kMarginBetweenTextAndButtons);
	}

	[super drawWithFrame:cellFrame inView:controlView];
}

#if 0
#pragma mark -
#pragma mark Accessors
#endif

- (void)setButtonDefinitions:(NSArray *)newDefs
{
	NSArray *		oldButtonDefinitions = fButtons;
	unsigned int	buttonsCount = [newDefs count];
	
	// Get mutable copies of the button definitions; we want to store additional data in them
	fButtons = [[NSMutableArray alloc] init];

	for(unsigned int index = 0; index < buttonsCount; index += 1)
	{
		NSDictionary *	button = [newDefs objectAtIndex:index];
		
		[fButtons addObject:[button mutableCopy]];
	}
	
	[oldButtonDefinitions release];
	
	[self calcButtonRects];
	fButtonPressedIndex = NSNotFound;
}

- (NSArray *)buttonDefinitions
{
	return fButtons;
}

@end
