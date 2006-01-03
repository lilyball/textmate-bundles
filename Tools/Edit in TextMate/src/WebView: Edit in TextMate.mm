//
//  WebView: Edit in TextMate.mm
//
//  Created by Allan Odgaard on 2005-11-27.
//  Copyright (c) 2005 MacroMates. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "Edit in TextMate.h"

@interface WebView (EditInTextMate)
- (void)editInTextMate:(id)sender;
@end

@interface NSString (EditInTextMate)
- (NSString*)stringByTrimmingWhitespace;
- (NSString*)stringByReplacingString:(NSString*)aSearchString withString:(NSString*)aReplaceString;
- (NSString*)stringByNbspEscapingSpaces;
@end

@implementation NSString (EditInTextMate)
- (NSString*)stringByTrimmingWhitespace
{
	NSString* str = self;
	while([str hasPrefix:@" "])
		str = [str substringFromIndex:1];

	while([str hasSuffix:@"  "])
		str = [str substringToIndex:[str length]-1];
	return str;
}

- (NSString*)stringByReplacingString:(NSString*)aSearchString withString:(NSString*)aReplaceString
{
	return [[self componentsSeparatedByString:aSearchString] componentsJoinedByString:aReplaceString];
}

- (NSString*)stringByNbspEscapingSpaces
{
	unsigned len = [self length];
	unichar* buf = new unichar[len];
	[self getCharacters:buf];
	for(unsigned i = 0; i != len; i++)
	{
		if(buf[i] == ' ' && (i+1 == len || buf[i+1] == ' '))
			buf[i] = 0xA0;
	}
	return [NSString stringWithCharacters:buf length:len];
}
@end

struct convert_dom_to_text
{
	convert_dom_to_text (DOMTreeWalker* treeWalker) : string([NSMutableString new]), quoteLevel(0), pendingFlush(NO), didOutputText(NO), atBeginOfLine(YES) { visit_nodes(treeWalker); }
	~convert_dom_to_text () { [string autorelease]; }
	operator NSString* () const { return string; }

private:
	void enter_block_tag ()
	{
		pendingFlush |= didOutputText;
		didOutputText = NO;
	}

	void leave_block_tag ()
	{
		pendingFlush |= didOutputText;
		didOutputText = NO;
	}

	void output_text (NSString* str)
	{
		str = [str stringByTrimmingWhitespace];
		if([str isEqualToString:@""])
			return;

		str = [str stringByReplacingString:[NSString stringWithUTF8String:" "] withString:@" "];

		if(pendingFlush)
		{
			[string appendString:@"\n"];
			pendingFlush = NO;
			atBeginOfLine = YES;
		}

		if(atBeginOfLine && quoteLevel)
		{
			for(unsigned i = 0; i < quoteLevel; i++)
				[string appendString:@"> "];
		}

		[string appendString:str];
		atBeginOfLine = NO;
		didOutputText = YES;
	}

	void visit_nodes (DOMTreeWalker* treeWalker);

	NSMutableString* string;
	unsigned quoteLevel;
	BOOL pendingFlush;
	BOOL didOutputText;
	BOOL atBeginOfLine;
};

void convert_dom_to_text::visit_nodes (DOMTreeWalker* treeWalker)
{
	for(DOMNode* node = [treeWalker currentNode]; node; node = [treeWalker nextSibling])
	{
		if([node nodeType] == DOM_TEXT_NODE)
			output_text([node nodeValue]);
		else if([[[node nodeName] uppercaseString] isEqualToString:@"BR"])
			output_text(@"\n"), (atBeginOfLine = YES), (didOutputText = NO);
		else if([[[node nodeName] uppercaseString] isEqualToString:@"DIV"])
			enter_block_tag();
		else if([[[node nodeName] uppercaseString] isEqualToString:@"BLOCKQUOTE"])
			enter_block_tag(), ++quoteLevel;
		else if([[[node nodeName] uppercaseString] isEqualToString:@"P"])
			enter_block_tag();

		if([treeWalker firstChild])
		{
			visit_nodes(treeWalker);
			[treeWalker parentNode];
		}

		if([[[node nodeName] uppercaseString] isEqualToString:@"DIV"])
			leave_block_tag();
		else if([[[node nodeName] uppercaseString] isEqualToString:@"BLOCKQUOTE"])
			leave_block_tag(), --quoteLevel;
		else if([[[node nodeName] uppercaseString] isEqualToString:@"P"])
			leave_block_tag();
	}
}

@implementation WebView (EditInTextMate)
- (void)editInTextMate:(id)sender
{
//	NSLog(@"%s %@", _cmd, [(DOMHTMLElement*)[[[self mainFrame] DOMDocument] documentElement] outerHTML]);
	if(![self isEditable])
		return (void)NSBeep();

	NSString* str = @"";
	if(DOMDocumentFragment* selection = [[self selectedDOMRange] cloneContents] ?: ([self selectAll:nil], [[self selectedDOMRange] cloneContents]))
	{
		str = convert_dom_to_text([[[self mainFrame] DOMDocument] createTreeWalker:selection :DOM_SHOW_ALL :nil :YES]);
		while([str hasSuffix:@"\n\n"])
			str = [str substringToIndex:[str length]-1];
	}
	[EditInTextMate externalEditString:str forView:self];
}

- (void)didModifyString:(NSString*)newString
{
	NSArray* lines = [newString componentsSeparatedByString:@"\n"];
	NSMutableString* res = [NSMutableString string];
	unsigned quoteLevel = 0;
	for(unsigned i = 0; i != [lines count]; i++)
	{
		NSString* line = [lines objectAtIndex:i];

		unsigned newQuoteLevel = 0;
		while([line hasPrefix:@"> "])
		{
			line = [line substringFromIndex:2];
			newQuoteLevel++;
		}

		if(newQuoteLevel > quoteLevel)
		{
			for(unsigned j = 0; j != newQuoteLevel - quoteLevel; j++)
				[res appendString:@"<BLOCKQUOTE type=\"cite\">"];
		}
		else if(newQuoteLevel < quoteLevel)
		{
			for(unsigned j = 0; j != quoteLevel - newQuoteLevel; j++)
				[res appendString:@"</BLOCKQUOTE>"];
		}
		quoteLevel = newQuoteLevel;

		if([line isEqualToString:@""])
		{
			[res appendString:@"<DIV><BR></DIV>"];
		}
		else
		{
			line = [line stringByNbspEscapingSpaces];
			line = [line stringByReplacingString:@"&" withString:@"&amp;"];
			line = [line stringByReplacingString:@"<" withString:@"&lt;"];
			line = [line stringByReplacingString:@">" withString:@"&gt;"];
			[res appendFormat:@"<DIV>%@</DIV>", line];
		}
	}

//	NSLog(@"%s %@", _cmd, res);

	[self replaceSelectionWithMarkupString:res];
	if(![[self selectedDOMRange] cloneContents])
		[self selectAll:nil];
}
@end
