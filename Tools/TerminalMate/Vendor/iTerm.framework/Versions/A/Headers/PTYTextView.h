// -*- mode:objc -*-
// $Id: PTYTextView.h,v 1.57 2006/10/02 22:57:40 yfabian Exp $
//
/*
 **  PTYTextView.h
 **
 **  Copyright (c) 2002, 2003
 **
 **  Author: Fabian, Ujwal S. Setlur
 **	     Initial code by Kiichi Kusama
 **
 **  Project: iTerm
 **
 **  Description: NSTextView subclass. The view object for the VT100 screen.
 **
 **  This program is free software; you can redistribute it and/or modify
 **  it under the terms of the GNU General Public License as published by
 **  the Free Software Foundation; either version 2 of the License, or
 **  (at your option) any later version.
 **
 **  This program is distributed in the hope that it will be useful,
 **  but WITHOUT ANY WARRANTY; without even the implied warranty of
 **  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 **  GNU General Public License for more details.
 **
 **  You should have received a copy of the GNU General Public License
 **  along with this program; if not, write to the Free Software
 **  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#import <Cocoa/Cocoa.h>
#import <iTerm/iTerm.h>

#include <sys/time.h>

#define MARGIN  5

@class VT100Screen;

typedef struct 
{
	int code;
	unsigned int color;
	NSImage *image;
	int count;
} CharCache;
	
#define CACHESIZE 2048
enum { SELECT_CHAR, SELECT_WORD, SELECT_LINE };

@interface PTYTextView : NSView <NSTextInput>
{
    // This is a flag to let us know whether we are handling this
    // particular drag and drop operation. We are using it because
    // the prepareDragOperation and performDragOperation of the
    // parent NSTextView class return "YES" even if the parent
    // cannot handle the drag type. To make matters worse, the
    // concludeDragOperation does not have any return value.
    // This all results in the inability to test whether the
    // parent could handle the drag type properly. Is this a Cocoa
    // implementation bug?
    // Fortunately, the draggingEntered and draggingUpdated methods
    // seem to return a real status, based on which we can set this flag.
    BOOL bExtendedDragNDrop;

    // anti-alias flag
    BOOL antiAlias;
	
	// option to not render in bold
	BOOL disableBold;

	// NSTextInput support
    BOOL IM_INPUT_INSERT;
    NSRange IM_INPUT_SELRANGE;
    NSRange IM_INPUT_MARKEDRANGE;
    NSDictionary *markedTextAttributes;
    NSAttributedString *markedText;
	
    BOOL CURSOR;
	BOOL forceUpdate;
	
    // geometry
	float lineHeight;
    float lineWidth;
	float charWidth;
	float charWidthWithoutSpacing, charHeightWithoutSpacing;
	int numberOfLines;
    
    NSFont *font;
    NSFont *nafont;
    NSColor* colorTable[16];
    NSColor* defaultFGColor;
    NSColor* defaultBGColor;
    NSColor* defaultBoldColor;
	NSColor* defaultCursorColor;
	NSColor* selectionColor;
	NSColor* selectedTextColor;
	NSColor* cursorTextColor;
	
	// transparency
	float transparency;
    BOOL useTransparency;
	
    // data source
    VT100Screen *dataSource;
    id _delegate;
	
    //selection
    int startX, startY, endX, endY;
	BOOL mouseDown;
	BOOL mouseDragged;
    char selectMode;
	BOOL mouseDownOnSelection;
	NSEvent *mouseDownEvent;
		
	//find support
	int lastFindX, lastFindY;
	
	BOOL reportingMouseDown;
	
	//cache
	CharCache	charImages[CACHESIZE];
	
	// blinking cursor
	BOOL blinkingCursor;
	BOOL showCursor;
	BOOL blinkShow;
    struct timeval lastBlink;
    int oldCursorX, oldCursorY;
	
	// trackingRect tab
	NSTrackingRectTag trackingRectTag;
	
	BOOL keyIsARepeat;
    
}

+ (NSCursor *) textViewCursor;
- (id)initWithFrame: (NSRect) aRect;
- (void)dealloc;
- (BOOL) becomeFirstResponder;
- (BOOL) resignFirstResponder;
- (BOOL)isFlipped;
- (BOOL)isOpaque;
- (BOOL)shouldDrawInsertionPoint;
- (void)drawRect:(NSRect)rect;
- (void)keyDown:(NSEvent *)event;
- (BOOL) keyIsARepeat;
- (void)mouseExited:(NSEvent *)event;
- (void)mouseEntered:(NSEvent *)event;
- (void)mouseDown:(NSEvent *)event;
- (void)mouseUp:(NSEvent *)event;
- (void)mouseDragged:(NSEvent *)event;
- (void) otherMouseDown: (NSEvent *) event;
- (void)otherMouseUp:(NSEvent *)event;
- (void)otherMouseDragged:(NSEvent *)event;
- (void)rightMouseDown:(NSEvent *)event;
- (void)rightMouseUp:(NSEvent *)event;
- (void)rightMouseDragged:(NSEvent *)event;
- (void)scrollWheel:(NSEvent *)event;
- (NSString *) contentFromX:(int)startx Y:(int)starty ToX:(int)endx Y:(int)endy breakLines: (BOOL) breakLines pad: (BOOL) pad;
- (NSString *) selectedText;
- (NSString *) selectedTextBreakingLines: (BOOL) breakLines pad: (BOOL) pad;
- (NSString *) content;
- (void)copy: (id) sender;
- (void)paste:(id)sender;
- (void) pasteSelection: (id) sender;
- (BOOL)validateMenuItem:(NSMenuItem *)item;
- (void)changeFont:(id)sender;
- (NSMenu *)menuForEvent:(NSEvent *)theEvent;
- (void) browse:(id)sender;
- (void) mail:(id)sender;

//get/set methods
- (NSFont *)font;
- (NSFont *)nafont;
- (void) setFont:(NSFont*)aFont nafont:(NSFont*)naFont;
- (BOOL) antiAlias;
- (void) setAntiAlias: (BOOL) antiAliasFlag;
- (BOOL) disableBold;
- (void) setDisableBold: (BOOL) boldFlag;
- (BOOL) blinkingCursor;
- (void) setBlinkingCursor: (BOOL) bFlag;

//color stuff
- (NSColor *) defaultFGColor;
- (NSColor *) defaultBGColor;
- (NSColor *) defaultBoldColor;
- (NSColor *) colorForCode:(unsigned int) index;
- (NSColor *) selectionColor;
- (NSColor *) defaultCursorColor;
- (NSColor *) selectedTextColor;
- (NSColor *) cursorTextColor;
- (void) setFGColor:(NSColor*)color;
- (void) setBGColor:(NSColor*)color;
- (void) setBoldColor:(NSColor*)color;
- (void) setColorTable:(int) index highLight:(BOOL)hili color:(NSColor *) c;
- (void) setSelectionColor: (NSColor *) aColor;
- (void)setCursorColor:(NSColor*) color;
- (void) setSelectedTextColor: (NSColor *) aColor;
- (void) setCursorTextColor:(NSColor*) color;


- (NSDictionary*) markedTextAttributes;
- (void) setMarkedTextAttributes: (NSDictionary *) attr;

- (id) dataSource;
- (void) setDataSource: (id) aDataSource;
- (id) delegate;
- (void) setDelegate: (id) delegate;
- (float) lineHeight;
- (void) setLineHeight: (float) aLineHeight;
- (float) lineWidth;
- (void) setLineWidth: (float) aLineWidth;
- (float) charWidth;
- (void) setCharWidth: (float) width;

- (void) refresh;
- (void) setFrameSize: (NSSize) aSize;
- (void) setForceUpdate: (BOOL) flag;
- (void) showCursor;
- (void) hideCursor;

// selection
- (IBAction) selectAll: (id) sender;

// transparency
- (float) transparency;
- (void) setTransparency: (float) fVal;
- (BOOL) useTransparency;
- (void) setUseTransparency: (BOOL) flag;

//
// Drag and Drop methods for our text view
//
- (unsigned int) draggingEntered: (id<NSDraggingInfo>) sender;
- (unsigned int) draggingUpdated: (id<NSDraggingInfo>) sender;
- (void) draggingExited: (id<NSDraggingInfo>) sender;
- (BOOL) prepareForDragOperation: (id<NSDraggingInfo>) sender;
- (BOOL) performDragOperation: (id<NSDraggingInfo>) sender;
- (void) concludeDragOperation: (id<NSDraggingInfo>) sender;

// Cursor control
- (void)resetCursorRects;

// Scrolling control
- (NSRect)adjustScroll:(NSRect)proposedVisibleRect;
- (void) scrollLineUpWithoutMoving;
- (void) scrollLineUp: (id) sender;
- (void) scrollLineDown: (id) sender;
- (void) scrollPageUp: (id) sender;
- (void) scrollPageDown: (id) sender;
- (void) scrollHome;
- (void) scrollEnd;
- (void) scrollToSelection;

    // Save method
- (void) saveDocumentAs: (id) sender;
- (void) print:(id)sender;
- (void) printContent: (NSString *) aString;

// Find method
- (void) findString: (NSString *) aString forwardDirection: (BOOL) direction ignoringCase: (BOOL) ignoreCase;

// NSTextInput
- (void)insertText:(id)aString;
- (void)setMarkedText:(id)aString selectedRange:(NSRange)selRange;
- (void)unmarkText;
- (BOOL)hasMarkedText;
- (NSRange)markedRange;
- (NSRange)selectedRange;
- (NSArray *)validAttributesForMarkedText;
- (NSAttributedString *)attributedSubstringFromRange:(NSRange)theRange;
- (void)doCommandBySelector:(SEL)aSelector;
- (unsigned int)characterIndexForPoint:(NSPoint)thePoint;
- (long)conversationIdentifier;
- (NSRect)firstRectForCharacterRange:(NSRange)theRange;

	// service stuff
- (id)validRequestorForSendType:(NSString *)sendType returnType:(NSString *)returnType;
- (BOOL)writeSelectionToPasteboard:(NSPasteboard *)pboard types:(NSArray *)types;
- (BOOL)readSelectionFromPasteboard:(NSPasteboard *)pboard;	

- (void)resetCharCache;

@end

//
// private methods
//
@interface PTYTextView (Private)

- (unsigned int) _checkForSupportedDragTypes:(id <NSDraggingInfo>) sender;
- (void) _savePanelDidEnd: (NSSavePanel *) theSavePanel returnCode: (int) theReturnCode contextInfo: (void *) theContextInfo;

- (void) _scrollToLine:(int)line;
- (void) _selectFromX:(int)startx Y:(int)starty toX:(int)endx Y:(int)endy;
- (NSString *) _getWordForX: (int) x 
					y: (int) y 
			   startX: (int *) startx 
			   startY: (int *) starty 
				 endX: (int *) endx 
				 endY: (int *) endy;
- (NSString *) _getURLForX: (int) x y: (int) y;
- (void) _renderChar:(NSImage *)image withChar:(unichar) carac withColor:(NSColor*)color withFont:(NSFont*)aFont bold:(int)bold;
- (NSImage *) _getCharImage:(unichar) code color:(int)fg doubleWidth:(BOOL) dw;
- (void) _drawCharacter:(unichar)c fgColor:(int)fg AtX:(float)X Y:(float)Y doubleWidth:(BOOL) dw;
- (BOOL) _isBlankLine: (int) y;
- (void) _openURL: (NSString *) aURLString;
- (void) _clearCacheForColor:(int)colorIndex;
- (BOOL) _findString: (NSString *) aString forwardDirection: (BOOL) direction ignoringCase: (BOOL) ignoreCase;
- (BOOL) _mouseDownOnSelection: (NSEvent *) theEvent;
- (void) _dragText: (NSString *) aString forEvent: (NSEvent *) theEvent;

@end

