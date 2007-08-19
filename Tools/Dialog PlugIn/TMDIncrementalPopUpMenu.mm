//
//  TMDIncrementalPopUpMenu.mm
//
//  Created by Joachim Mårtensson on 2007-08-10.
//  Copyright (c) 2007 __MyCompanyName__. All rights reserved.
//

#import "TMDIncrementalPopUpMenu.h"

@implementation TMDIncrementalPopUpMenu
- (id)initWithDictionary:(NSDictionary*)aDictionary andEditor:(id)editor
{
	[aDictionary retain];
//NSLog(@"%@", aDictionary);
    if(self = [super initWithWindowNibName:@"IncrementalPopUpMenu"])
    {
        mutablePrefix = [[NSMutableString alloc] init];

        ed = [editor retain];
        suggestions = [NSArray arrayWithArray:[aDictionary objectForKey:@"suggestions"]];

        
        [mutablePrefix setString:[NSString stringWithString:[aDictionary objectForKey:@"mutablePrefix"]]];
        staticPrefix = [NSString stringWithString:[aDictionary objectForKey:@"staticPrefix"]];
		shell = nil;
		if([aDictionary objectForKey:@"shell"]){
			shell = [NSString stringWithString:[aDictionary objectForKey:@"shell"]];
			[shell retain];
		}
		NSPredicate* predicate = [NSPredicate predicateWithFormat:@"filterOn beginswith %@", [staticPrefix stringByAppendingString:mutablePrefix]];
		suggestions = [suggestions retain];
        [self setFiltered:[suggestions filteredArrayUsingPredicate:predicate]];
			[staticPrefix retain];
		
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
		NSString* tStatic = [staticPrefix copy];
		NSString* temp = [tStatic stringByAppendingString:mutablePrefix];
		//[tStatic release];
		if([previousString length] > [temp length]){
			if(previousString){
				tStatic = [previousString substringFromIndex:[temp length]];
				[mutablePrefix appendString:tStatic];
			} else NSLog(@"previousString was nil !!!: []", temp);
			//[temp release];
			
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
		myArray2 = [suggestions copy];
	}
	[self setValue:myArray2 forKey:@"filtered"];
	NSPoint old = NSMakePoint([[self window] frame].origin.x,[[self window] frame].origin.y +[[self window] frame].size.height);
	if([filtered count]>15)
	{
			[[self window] setContentSize:NSMakeSize([[self window] frame].size.width, [theTableView rowHeight]*(15 + 1))];
	}
	else if([filtered count]>1)
	{
			[[self window] setContentSize:NSMakeSize([[self window] frame].size.width, [theTableView rowHeight]*([filtered count] + 1))];
	}
	else
	{
			[[self window] setContentSize:NSMakeSize([[self window] frame].size.width, [theTableView rowHeight] *2)];
	}
	[[self window] setFrameTopLeftPoint:old];
}
- (void)windowDidLoad
{
//    [self showWindow:self];
//	[[self window] setContentView:theTableView];
    [self filter];
}

- (void)awakeFromNib
{
    [theTableView setNextResponder: self];
	[theTableView setDoubleAction:@selector(completeAndInsertSnippet)];
}
- (void)completeAndInsertSnippet
{
	//NSLog(@"insert");
	if ([anArrayController selectionIndex] != NSNotFound){
				id selection = [[filtered objectAtIndex:[anArrayController selectionIndex]] copy];
				NSString* aString = [selection valueForKey:@"filterOn"];
				NSString* temp = [staticPrefix stringByAppendingString:[mutablePrefix copy]];
				[temp retain];
				if([temp length] > [aString length]){
					;
				}
				else if([aString length] > [temp length]){
					NSString* temp2 = [aString substringFromIndex:[temp length]];
					[self writeToTM:[temp2 copy] asSnippet:NO];
				}
				if([selection valueForKey:@"snippet"]){
					//[self writeToTM:[[ob valueForKey:@"snippet"] copy] asSnippet:YES];
					[self writeToTM:[[selection valueForKey:@"snippet"] copy] asSnippet:YES];
				}
				else if(shell)
				{
					NSString* fromShell =[[self executeShellCommand:shell WithDictionary:[selection copy]] retain];
					[self writeToTM:fromShell asSnippet:YES];
				} 
			} 
}


- (void)keyDown:(NSEvent*)anEvent
{
    
   // NSLog(@"%@  <-prefix", mutablePrefix);
    NSString* aString = [anEvent characters];
    unichar		key = 0;
    if([aString length] == 1){
        key = [aString characterAtIndex:0];
        if (key == NSBackspaceCharacter || key == NSDeleteCharacter){			
			[mutablePrefix deleteCharactersInRange:NSMakeRange([mutablePrefix length]-1,1)];
			[self filter];
			//[self close];
        }
        else if(key == NSCarriageReturnCharacter ){
			[self completeAndInsertSnippet];
			//[self close];
        } else if([aString isEqualToString:@"\t"]){
			[self tab];
		} else {
        printf("key pressed: %s\n", [[anEvent description] cString]);
        
        //[self interpretKeyEvents:[NSArray arrayWithObject:anEvent]];
        [mutablePrefix appendString:aString];
		[mutablePrefix retain];
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
	NSString* r = [[NSString alloc] initWithData: data encoding: NSASCIIStringEncoding];
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
    NSArray* oldFiltered = filtered;
    filtered = [aValue retain];
    [oldFiltered release];
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
