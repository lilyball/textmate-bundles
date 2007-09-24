//
//  TMDIncrementalPopUpMenu.mm
//
//  Created by Joachim MŒrtensson on 2007-08-10.
//  Copyright (c) 2007 __MyCompanyName__. All rights reserved.
//

#import "TMDIncrementalPopUpMenu.h"
@interface NSObject (OakTextView)
- (id)insertSnippetWithOptions:(NSDictionary*)options;
@end

@implementation TMDIncrementalPopUpMenu
- (id)initWithDictionary:(NSDictionary*)aDictionary andEditor:(id)editor
{
////NSLog(@"%@", aDictionary);
    if(self = [super initWithWindowNibName:@"IncrementalPopUpMenu"])
    //if(self = [super init])
	{
        mutablePrefix = [[NSMutableString alloc] init];

        ed = [editor retain];
        suggestions = [NSArray arrayWithArray:[aDictionary objectForKey:@"suggestions"]];

        [mutablePrefix setString:[NSString stringWithString:[aDictionary objectForKey:@"currentWord"]]];
        if([aDictionary objectForKey:@"staticPrefix"]){
			staticPrefix = [NSString stringWithString:[aDictionary objectForKey:@"staticPrefix"]];
			[staticPrefix retain];
		}
		else
		{
			staticPrefix = @"";
		}
		shell = nil;
		if([aDictionary objectForKey:@"shell"]){
			shell = [NSString stringWithString:[aDictionary objectForKey:@"shell"]];
			[shell retain];
		}
		//NSPredicate* predicate = [NSPredicate predicateWithFormat:@"filterOn beginswith %@", [staticPrefix stringByAppendingString:mutablePrefix]];
		suggestions = [suggestions retain];
        //[self setFiltered:[suggestions filteredArrayUsingPredicate:predicate]];
		attrString = [[NSMutableAttributedString alloc] initWithString:@"No completion found"];
		[self filter];
		closeMe = NO;
    }
    return self;
}
- (NSMutableString*)mutablePrefix;
{
	return mutablePrefix;
}
- (id)theTableView
{	
	return theTableView;
}
// osascript -e 'tell application "TextMate" to activate'$'\n''tell application "System Events" to keystroke (ASCII character 8)'
-(void)tab
{
    if([filtered count]>1)
	{
        NSEnumerator *enumerator = [filtered objectEnumerator];
        id eachString;
        id previousString = [[enumerator nextObject] objectForKey:@"filterOn"];
		id dict;
        while (dict = [enumerator nextObject] )
        {
		
			eachString = [dict objectForKey:@"filterOn"];
            NSString *commonPrefix = [eachString commonPrefixWithString:previousString options:NSLiteralSearch];
            previousString = commonPrefix;
        }
		NSString* tStatic;// = [staticPrefix copy];
		NSString* temp = [staticPrefix stringByAppendingString:mutablePrefix];
		//[tStatic release];
		if([previousString length] > [temp length]){
			if(previousString){
				tStatic = [previousString substringFromIndex:[temp length]];
				[mutablePrefix appendString:tStatic];
			} else {//NSLog(@"previousString was nil !!!: []", temp);
			//[temp release];
			}
			
            [self writeToTM:tStatic asSnippet:NO];
			[self filter];
		}
        
    }
      // [self close];
}

- (void)filter
{
	NSArray* myArray2;
	if ([mutablePrefix length] > 0){
		NSPredicate* predicate = [NSPredicate predicateWithFormat:@"filterOn beginswith %@", [staticPrefix stringByAppendingString:mutablePrefix]];
		myArray2 = [suggestions filteredArrayUsingPredicate:predicate];

		//[anArrayController rearrangeObjects];
	} else {
		myArray2 = suggestions;
	}
	NSPoint old = NSMakePoint([[self window] frame].origin.x,[[self window] frame].origin.y +[[self window] frame].size.height);
	float newHeight = 0;
	if([myArray2 count]>MAX_ROWS)
	{
		newHeight = [theTableView rowHeight]*MAX_ROWS*1.15;
	}
	else if([myArray2 count]>1)
	{
		newHeight = [theTableView rowHeight]*[myArray2 count]*1.15;
	}
	else
	{
		newHeight = [theTableView rowHeight] * 1.2;
	}

	float maxLen = 1;
	NSString* item;
	int i;
	float maxWidth = [[self window] frame].size.width;
	if([myArray2 count]>0)
	{
		for(i=0; i<[myArray2 count]; i++)
		{
			item = [[myArray2 objectAtIndex:i] objectForKey:@"title"];
			if([item length]>maxLen)
				maxLen = [item length];
		}
		maxWidth = maxLen*18;
		maxWidth = (maxWidth>340) ? 340 : maxWidth;
	}
	if(caretPos.y>=0 && (isAbove || caretPos.y<newHeight))
	{
		[self setAbove:YES];
		old.y = caretPos.y + (newHeight + [[NSUserDefaults standardUserDefaults] integerForKey:@"OakTextViewNormalFontSize"]*1.5);
	}
	if(caretPos.y<0 && (isAbove || (mainScreen.size.height-newHeight)<(caretPos.y*-1)))
	{
		old.y = caretPos.y + (newHeight + [[NSUserDefaults standardUserDefaults] integerForKey:@"OakTextViewNormalFontSize"]*1.5);
	}
	[[self window] setFrame:NSMakeRect(old.x,old.y-newHeight,maxWidth,newHeight) display:YES];
	//NSLog(@"myArray2 retaincount %d",[myArray2 retainCount]);
	//NSLog(@"filtered retaincount in filter %d",[filtered retainCount]);
	//[self setValue:myArray2 forKey:@"filtered"];
	[self setFiltered:myArray2];
	//NSLog(@"filtered retaincount in filter after - %d",[filtered retainCount]);
	
}
- (void)windowDidLoad
{
    //NSLog(@"%d controller windowDidLoad",[controllerObject retainCount]);

//    [self showWindow:self];
//  [[self window] setContentView:theTableView];
[[self window] setDelegate:self];
    [self filter];
    NSMutableAttributedString* s = [[NSMutableAttributedString alloc] initWithString:mutablePrefix];
    [s addAttribute:NSFontAttributeName
              value:[NSFont fontWithName:[[NSUserDefaults standardUserDefaults] stringForKey:@"OakTextViewNormalFontName"] ?:[[NSFont userFixedPitchFontOfSize:12.0] fontName]
                                    size:[[NSUserDefaults standardUserDefaults] integerForKey:@"OakTextViewNormalFontSize"] ?: 12 ]
              range:NSMakeRange(0,[mutablePrefix length])];
    stringWidth = [s size].width;
    [s release];
}
-(void)windowWillClose:(NSNotification*)aNotification
{
	//NSLog(@"windowDidClose");
	if([controllerObject isKindOfClass:[NSObjectController class]])
		//NSLog(@"is Kind of class");
	[controllerObject unbind:@"contentObject"];
	//NSLog(@"windowDidClose self %d",[self retainCount]);
		//NSLog(@"%d arrayControll",[anArrayController retainCount]);
	//NSLog(@"%d theTableView",[theTableView retainCount]);
	//NSLog(@"%d static",[staticPrefix retainCount]);
	//NSLog(@"%d controller",[controllerObject retainCount]);
		//NSLog(@"%d mutablePrefix",[mutablePrefix retainCount]);
	//NSLog(@"%d filtered",[filtered retainCount]);
	//NSLog(@"%d shell",[shell retainCount]);
	//NSLog(@"%d controller",[controllerObject retainCount]);
}
- (int) stringWidth;
{ return stringWidth; }
- (void)setCaretPos:(NSPoint)aPos
{
	caretPos = aPos;
}
- (void)setMainScreen:(NSRect)aScreen
{
	mainScreen = aScreen;
}
- (void)setAbove:(BOOL)aBool
{
	isAbove = aBool;
}
- (BOOL)getCloseStatus
{
	return closeMe;
}
- (void)awakeFromNib
{
  //  [theTableView setNextResponder: self];
	[theTableView setTarget:self];
	[theTableView setDoubleAction:@selector(completeAndInsertSnippet:)];
}
- (void)completeAndInsertSnippet:(id)nothing
{
	if ([anArrayController selectionIndex] != NSNotFound){
		id selection = [filtered objectAtIndex:[anArrayController selectionIndex]];
		NSString* aString = [selection valueForKey:@"filterOn"];
		NSString* temp = [staticPrefix stringByAppendingString:mutablePrefix];
		//[temp retain];
		if([temp length] > [aString length]){
			;
		}
		else if([aString length] > [temp length]){
			NSString* temp2 = [aString substringFromIndex:[temp length]];
			[self writeToTM:temp2 asSnippet:NO];
		}
		if([selection valueForKey:@"snippet"]){
			//[self writeToTM:[[ob valueForKey:@"snippet"] copy] asSnippet:YES];
			[self writeToTM:[selection valueForKey:@"snippet"] asSnippet:YES];
		}
		else if(shell)
		{
			//NSLog(@"shell");
			NSString* fromShell =[[self executeShellCommand:shell WithDictionary:selection] retain];
			[self writeToTM:fromShell asSnippet:YES];
		}
		closeMe = YES;
	}
}
- (void)scrollLineUp:(id)sender
{
	int row = [anArrayController selectionIndex];
	if (--row >= 0) [anArrayController setSelectionIndex:row];
}
-(void)scrollLineDown:(id)sender
{
	int row = [anArrayController selectionIndex];
	if (++row < [filtered count]) [anArrayController setSelectionIndex:row];
}
- (void)moveToBeginningOfDocument:(id)sender 
{
	[anArrayController setSelectionIndex:0];
}
- (void)moveToEndOfDocument:(id)sender 
{
	[anArrayController setSelectionIndex:[filtered count]-1];
}
- (void)pageDown:(id)sender
{
	int oldIndex = [anArrayController selectionIndex];
	if([filtered count]<(MAX_ROWS+1))
		[anArrayController setSelectionIndex:[filtered count]-1];
	else
	{
		if(oldIndex+MAX_ROWS>=[filtered count])
			[anArrayController setSelectionIndex:[filtered count]-1];
		else 
			[anArrayController setSelectionIndex:oldIndex+MAX_ROWS-1];
		[[self theTableView] scrollRowToVisible:[anArrayController selectionIndex]];
	}
	//NSLog(@"%d arrayControll",[anArrayController retainCount]);
	//NSLog(@"%d theTableView",[theTableView retainCount]);
	//NSLog(@"%d static",[staticPrefix retainCount]);
	//NSLog(@"%d controller",[controllerObject retainCount]);
	//NSLog(@"%d mutablePrefix",[mutablePrefix retainCount]);
	//NSLog(@"%d filtered",[filtered retainCount]);
	//NSLog(@"%d shell",[shell retainCount]);
	//NSLog(@"%d controller",[controllerObject retainCount]);

}
- (void)pageUp:(id)sender 
{
	int oldIndex = [anArrayController selectionIndex];
	if(oldIndex<MAX_ROWS)
		[anArrayController setSelectionIndex:0];
	else
	{
		[anArrayController setSelectionIndex:oldIndex-MAX_ROWS+1];
		[[self theTableView] scrollRowToVisible:[anArrayController selectionIndex]];
	}
	
}
- (void)keyDown:(NSEvent*)anEvent
{
    
   // //NSLog(@"%@  <-prefix", mutablePrefix);
    NSString* aString = [anEvent characters];
    unichar		key = 0;
    if([aString length] == 1){
        key = [aString characterAtIndex:0];
        if (key == NSBackspaceCharacter || key == NSDeleteCharacter){			
			[mutablePrefix deleteCharactersInRange:NSMakeRange([mutablePrefix length]-1,1)];
			[self filter];
			//[self close];
        }
		else if (key == NSUpArrowFunctionKey || key == NSDownArrowFunctionKey){
			; // we need to catch this since an empty tableView passes the event on here.
		}
		else if (key == NSPageUpFunctionKey || key == NSPageDownFunctionKey){
			; // we need to catch this since an empty tableView passes the event on here.
		}
		else if(key == NSCarriageReturnCharacter ){
			[self completeAndInsertSnippet:nil];
			//[self close];
        } else if([aString isEqualToString:@"\t"]){
			if([filtered count] == 1)
				[self completeAndInsertSnippet:nil];
			else
				[self tab];
		} else {
        
        //[self interpretKeyEvents:[NSArray arrayWithObject:anEvent]];
        [mutablePrefix appendString:aString];
		//[mutablePrefix retain];
        //[self writeToTM:aString asSnippet:NO];
        [self filter];
		}
    }
}
-(NSString*)executeShellCommand:(NSString*)command WithDictionary:(NSDictionary*)dict
{
	NSString* stdIn = [dict description];
	NSTask* task = [[ NSTask alloc ] init ];
	[task setLaunchPath: @"/bin/sh"];
	NSArray *arguments;
    arguments = [NSArray arrayWithObjects:@"-c", command, nil];
	[task setArguments: arguments];
	[task setStandardInput:[[NSPipe alloc ] init]];
	NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
	NSFileHandle* taskInput = [[task standardInput ] fileHandleForWriting ];

	//const char* cStringToSendToTask = [ stdIn UTF8String ];

	[taskInput writeData: [stdIn dataUsingEncoding:NSUTF8StringEncoding]];
	[taskInput closeFile];

    NSFileHandle* taskOutput;
    taskOutput = [pipe fileHandleForReading];

    [task launch];

    NSData *data;
    data = [taskOutput readDataToEndOfFile];
	NSString* r = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    return [r autorelease];
}

-(void)writeToTM:(NSString*)string asSnippet:(BOOL)snippet
{
	if(snippet){
		if(id textView = [NSApp targetForAction:@selector(insertSnippetWithOptions:)]){
			[textView insertSnippetWithOptions:[NSDictionary dictionaryWithObjectsAndKeys:string, @"content",nil]];
		}
	}
	else
	{
		if(id textView = [NSApp targetForAction:@selector(insertText:)]){
			[textView insertText:string];
		}
	}
}

- (NSArray*)filtered
{
    return filtered;
}

- (void)setFiltered:(NSArray*)aValue
{
	[aValue retain];
	[filtered release];
	filtered = aValue;
	
  //  NSArray* oldFiltered = filtered;
  //  filtered = [aValue retain];
  //  [oldFiltered release];
}

-(void)dealloc
{
	NSLog(@"%d staticPrefix",[staticPrefix retainCount]);
	[staticPrefix release];
	NSLog(@"%d staticPrefix",[staticPrefix retainCount]);
	[mutablePrefix release];
	[suggestions release];
	if(shell)
		[shell release];
	[super dealloc];
}
@end
