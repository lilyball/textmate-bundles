//
//  CXTransientStatusWindow
//
//  Transient window is for advisory information that shouldn't interrupt workflow 
//	-- no dialog or sheet -- but that the user still cares about.
//
//  Created by Chris Thomas on 2005-11-18.
//  Copyright 2005 Chris Thomas. All rights reserved.
//

#include "CXRoundRects.h"
#include "CXTransientStatusWindow.h"

@interface CXTransCloseBox : NSButtonCell
@end

@implementation CXTransCloseBox

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{	
	NSBezierPath * path;

	cellFrame = NSInsetRect(cellFrame, 2, 2);

	path = [NSBezierPath bezierPathWithOvalInRect:cellFrame];
	
	[[NSColor colorWithDeviceWhite:0.2 alpha:0.7] set];
	[path fill];
	
	if( [self isHighlighted] )
	{
		[[NSColor lightGrayColor] set];
	}
	else
	{
		[[NSColor whiteColor] set];
	}

	cellFrame = NSInsetRect(cellFrame, 3, 3);
		
	[NSBezierPath setDefaultLineWidth:2.0];
	[NSBezierPath strokeLineFromPoint:	NSMakePoint(NSMaxX(cellFrame), NSMinY(cellFrame)) 						
							toPoint:	NSMakePoint(NSMinX(cellFrame), NSMaxY(cellFrame))];
	[NSBezierPath strokeLineFromPoint:	NSMakePoint(NSMaxX(cellFrame), NSMaxY(cellFrame)) 						
							toPoint:	NSMakePoint(NSMinX(cellFrame), NSMinY(cellFrame))];
							
	[path setLineWidth:1.0];
	[path stroke];
}

@end


@interface CXTransparentView : NSView
{
	NSString *					fStringValue;
	NSButton *					fCloseBox;
	CXTransientStatusWindow *	fController;
	NSRect						fTextRect;
	NSRect						fBackgroundRect;
}
- (void) setupWithController:(CXTransientStatusWindow *)controller;
- (void) setStringValue:(NSString *)string;
- (NSString *)stringValue;
@end

@implementation CXTransparentView


- (NSString *)stringValue
{
	return fStringValue;
}

static const float kXMargin = 12.0;
static const float kYMargin = 5.0;

- (NSDictionary *) drawingAttributes
{
	NSMutableDictionary *	attributes = [NSMutableDictionary dictionary];
	
	[attributes setObject:[NSFont systemFontOfSize:11.0f] forKey:NSFontAttributeName];
	[attributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
	
	return attributes;
}

// TODO: wrap long lines
- (void) setStringValue:(NSString *) stringValue
{
	NSSize		oldSize = [self frame].size;
	NSString *	oldStringValue = fStringValue;
	
	fStringValue = [stringValue copy];
	[oldStringValue release];

	fTextRect		= [stringValue boundingRectWithSize:oldSize options:0 attributes:[self drawingAttributes]];
	
	fTextRect.origin.x = oldSize.width - fTextRect.size.width - (kXMargin * 2);
	fTextRect.origin.y = 100;
	
	fBackgroundRect	= NSInsetRect(fTextRect, -kXMargin, -kYMargin);
	[fCloseBox setFrameOrigin:NSMakePoint(NSMinX(fBackgroundRect) - 4.0, NSMinY(fBackgroundRect) - 4.0)];
	
	[self setNeedsDisplay:YES];
}

// easier than overriding initWithFrame...
- (void) setupWithController:(CXTransientStatusWindow *)controller
{
	fController = controller;

//	fCloseBox = [NSWindow standardWindowButton:NSWindowCloseButton
//						forStyleMask:NSTitledWindowMask | NSClosableWindowMask | NSUtilityWindowMask];

	fCloseBox = [[NSButton alloc] initWithFrame:NSMakeRect(0,0,16,16)];
	[fCloseBox setCell:[[[CXTransCloseBox alloc] init] autorelease]];

	[self addSubview:fCloseBox];
	[fCloseBox release];
	
	[fCloseBox setTarget:fController];
	[fCloseBox setAction:@selector(closeWindow:)];
}

- (BOOL) isFlipped
{
	return YES;
}

- (void) drawRect:(NSRect)rect
{
	[[NSColor clearColor] set];
	NSRectFill(rect);
	
	[[NSColor colorWithDeviceWhite:0.2 alpha:0.7] set];
	
	[NSBezierPath fillRoundRectInRect:fBackgroundRect radius:12.0];
	
	[fStringValue drawInRect:fTextRect withAttributes:[self drawingAttributes]];
}



@end


@implementation CXTransientStatusWindow

- (void) showStatus:(NSString *)statusText onParent:(NSWindow *)parentWindow
{

	NSRect		windowRect = [parentWindow frame];
	NSRect		viewRect = NSZeroRect;

	viewRect.size = windowRect.size;

	if( fWindow == nil )
	{
		windowRect = [NSWindow contentRectForFrameRect:windowRect
									styleMask:NSBorderlessWindowMask];

		// Create the window
		fWindow = [[NSWindow alloc] initWithContentRect:windowRect
							   styleMask:NSBorderlessWindowMask
							   backing:NSBackingStoreBuffered
							   defer:NO];

		[fWindow setOpaque:NO];

		fView = [[CXTransparentView alloc] initWithFrame:viewRect];

		[fView setupWithController:self];

		// set the content view
		[fWindow setContentView:fView];
		[fWindow setHasShadow:NO];
	}
	else
	{
		// Reset the frames
		[fWindow setFrame:windowRect display:NO];
		[fView setFrame:viewRect];
	}
	
	[fView setStringValue:statusText];

	// order it into the parent
	[parentWindow addChildWindow:fWindow ordered:NSWindowAbove];

	NSLog(@"%s Opacity:%g", _cmd, [fWindow alphaValue]);

	[fWindow setAlphaValue:1.0];

}

- (void) closeWindow:(id)sender
{
	NSMutableArray * 		array = [NSMutableArray array];
	NSMutableDictionary *	dict = [NSMutableDictionary dictionary];
	
	[dict setObject:fWindow forKey:NSViewAnimationTargetKey];
	[dict setObject:NSViewAnimationFadeOutEffect forKey:NSViewAnimationEffectKey];
	
	[array addObject:dict];
	if(fAnimation == nil)
	{
		fAnimation = [[NSViewAnimation alloc] initWithViewAnimations:array];
	}
	else
	{
		[fAnimation setViewAnimations:array];
	}
	
	[[fWindow parentWindow] removeChildWindow:fWindow];
	
	[fAnimation startAnimation];
//	[fWindow orderOut:sender];
}

- (void) dealloc
{
	[fWindow release];
	[fAnimation release];
	
	[super dealloc];
}

@end
