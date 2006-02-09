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
	NSRange selectedRange = [self selectedRange];
	BOOL hadSelection = selectedRange.length != 0;
	selectedRange = hadSelection ? selectedRange : NSMakeRange(0, [[self textStorage] length]);
	if([self shouldChangeTextInRange:selectedRange replacementString:newString])
	{
		if(!hadSelection)
			[self setSelectedRange:NSMakeRange(0, [[self textStorage] length])];
		[self insertText:newString];
		if(hadSelection)
			[self setSelectedRange:NSMakeRange(selectedRange.location, [newString length])];
		[self didChangeText];
	}
	else
	{
		NSBeep();
		NSLog(@"%s couldn't edit text", _cmd);
	}
}
@end
