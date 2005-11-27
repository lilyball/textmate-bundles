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
/*		NSMutableCharacterSet* whitespace = [NSMutableCharacterSet whitespaceCharacterSet];
		[whitespace removeCharactersInRange:NSMakeRange(0xA0, 1)];
		str = [str stringByTrimmingCharactersInSet:whitespace];
*/
		while([str hasPrefix:@" "])
			str = [str substringFromIndex:1];

		while([str hasSuffix:@"  "])
			str = [str substringToIndex:[str length]-1];

		if([str isEqualToString:@""])
			return;
		str = [[str componentsSeparatedByString:[NSString stringWithUTF8String:" "]] componentsJoinedByString:@" "];

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
	if(![self isEditable])
		return (void)NSBeep();

	DOMDocumentFragment* selection = [[self selectedDOMRange] cloneContents];
	if(!selection)
		selection = ([self selectAll:nil], [[self selectedDOMRange] cloneContents]);

	NSLog(@"%s %@", _cmd, [(DOMHTMLElement*)[[[self mainFrame] DOMDocument] documentElement] outerHTML]);
	NSString* str = convert_dom_to_text([[[self mainFrame] DOMDocument] createTreeWalker:selection :DOM_SHOW_ALL :nil :YES]);
	if(![str isEqualToString:@""])
	{
		while([str hasSuffix:@"\n\n"])
			str = [str substringToIndex:[str length]-1];

		[EditInTextMate externalEditString:str forView:self];
	}
}

- (void)didModifyString:(NSString*)newString
{
	NSMutableString* res = [NSMutableString string];
	unsigned quoteLevel = 0;
	NSArray* lines = [newString componentsSeparatedByString:@"\n"];
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
			[res appendString:@"<DIV>"];

//			if([line rangeOfString:@"  "].location != NSNotFound)
			{
				char const* str = [line UTF8String];
				size_t len = strlen(str);
				char* buf = new char[len+1];
				size_t j = 0;
				for(size_t i = 0; i != len; i++)
				{
					if(str[i] == ' ' && (str[i+1] == ' ' || !str[i+1]))
					{
						buf[j++] = '\xC2';
						buf[j++] = '\xA0';
					}
					else
					{
						buf[j++] = str[i];
					}	
				}
				buf[j] = 0;
				line = [NSString stringWithUTF8String:buf] ?: @"";
			}

			line = [[line componentsSeparatedByString:@"&"] componentsJoinedByString:@"&amp;"];
			line = [[line componentsSeparatedByString:@"<"] componentsJoinedByString:@"&lt;"];
			line = [[line componentsSeparatedByString:@">"] componentsJoinedByString:@"&gt;"];
			[res appendString:line];
			[res appendString:@"</DIV>"];
		}
	}
	NSLog(@"%s %@", _cmd, res);

	[self replaceSelectionWithMarkupString:res];
	if(![[self selectedDOMRange] cloneContents])
		[self selectAll:nil];
}
@end
