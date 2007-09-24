//
//  TMDIncrementalPopUpMenu.h
//
//  Created by Joachim MŒrtensson on 2007-08-10.
//  Copyright (c) 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#define MAX_ROWS 15

@interface TMDIncrementalPopUpMenu : NSWindowController
{
    IBOutlet NSArrayController* anArrayController;
    NSArray* suggestions;
    NSMutableString* mutablePrefix;
    NSString* staticPrefix;
    NSArray* filtered;
	NSString* shell;
	NSMutableAttributedString* attrString;
	IBOutlet id theTableView;
	float stringWidth;
	NSPoint caretPos;
	BOOL isAbove;
	NSRect mainScreen;
	BOOL closeMe;
    id ed;
    id controllerObject;
}
- (id)initWithDictionary:(NSDictionary*)aDictionary
               andEditor:(id)editor;
- (void)filter;
- (NSMutableString*)mutablePrefix;
- (id)theTableView;
- (void)keyDown:(NSEvent*)anEvent;
- (void)tab;
- (int)stringWidth;
- (void)writeToTM:(NSString*)aString asSnippet:(BOOL)snippet;
- (NSString*)executeShellCommand:(NSString*)command WithDictionary:(NSDictionary*)dict;
- (NSArray*)filtered;
- (void)setFiltered:(NSArray*)aValue;
- (void)setCaretPos:(NSPoint)aPos;
- (void)setMainScreen:(NSRect)aScreen;
- (void)setAbove:(BOOL)aBool;
- (void)completeAndInsertSnippet:(id)nothing;
- (BOOL)getCloseStatus;

@end
