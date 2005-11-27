//
//  NSTextView: Edit in TextMate.mm
//
//  Created by Allan Odgaard on 2005-11-27.
//  Copyright (c) 2005 MacroMates. All rights reserved.
//

#import "Edit in TextMate.h"

@interface NSTextView (EditInTextMate)
- (void)editInTextMate:(id)sender;
@end

@implementation NSTextView (EditInTextMate)
- (void)editInTextMate:(id)sender
{
	if(![self isEditable])
		return (void)NSBeep();

	NSString* str = [[self textStorage] string];
	NSRange selectedRange = [self selectedRange];
	if(selectedRange.length == 0)
		selectedRange = NSMakeRange(0, [str length]);

	[EditInTextMate externalEditString:[str substringWithRange:selectedRange] forView:self];
}

- (void)didModifyString:(NSString*)newString
{
	BOOL skipReselect = NO;
	NSRange selectedRange = [self selectedRange];
	if(skipReselect = selectedRange.length == 0)
		selectedRange = NSMakeRange(0, [[self textStorage] length]);

	[[self textStorage] replaceCharactersInRange:selectedRange withString:newString];
	if(!skipReselect)
		[self setSelectedRange:NSMakeRange(selectedRange.location, [newString length])];
}
@end
