#import "../../TMDCommand.h"
#import "../../Dialog.h"
#import "TMDIncrementalPopUpMenu.h"

// ==================
// = Extended Popup =
// ==================
@interface NSObject (OakTextView)
- (NSPoint)positionForWindowUnderCaret;
@end

@interface TMDXPopUp : TMDCommand
{
}
@end

@implementation TMDXPopUp
+ (void)load
{
	[TMDCommand registerObject:[self new] forCommand:@"extended-popup"];
}

- (void)handleCommand:(id)options
{
	NSDictionary* initialValues = [TMDCommand readPropertyList:[options objectForKey:@"stdin"]];
	NSLog(@"initialValues: %@", initialValues);
    
	NSPoint pos = NSZeroPoint;
	if(id textView = [NSApp targetForAction:@selector(positionForWindowUnderCaret)])
		pos = [textView positionForWindowUnderCaret];

	NSRect mainScreen = [[NSScreen mainScreen] frame];
	enumerate([NSScreen screens], NSScreen* candidate)
	{
		if(NSMinX([candidate frame]) == 0.0f && NSMinY([candidate frame]) == 0.0f)
			mainScreen = [candidate frame];
	}

	pos = NSMakePoint(pos.x,  pos.y);
    TMDIncrementalPopUpMenu* xPopUp = [[TMDIncrementalPopUpMenu alloc] initWithDictionary:initialValues andEditor:nil];
	NSLog(@"%d xpop",[xPopUp retainCount]);
	[xPopUp setCaretPos:pos];
	[xPopUp setMainScreen:mainScreen];
	[xPopUp setAbove:NO];

	int offx = (pos.x/mainScreen.size.width) + 1;
	if((pos.x + [[xPopUp window] frame].size.width) > (mainScreen.size.width*offx))
		pos.x = pos.x - [[xPopUp window] frame].size.width;
	pos.x = pos.x - [xPopUp stringWidth];

	if(pos.y>=0 && pos.y<[[xPopUp window] frame].size.height)
	{
		pos.y = pos.y + ([[xPopUp window] frame].size.height + [[NSUserDefaults standardUserDefaults] integerForKey:@"OakTextViewNormalFontSize"]*1.5);
		[xPopUp setAbove:YES];
	}
	if(pos.y<0 && (mainScreen.size.height-[[xPopUp window] frame].size.height)<(pos.y*-1))
	{
		pos.y = pos.y + ([[xPopUp window] frame].size.height + [[NSUserDefaults standardUserDefaults] integerForKey:@"OakTextViewNormalFontSize"]*1.5);
		[xPopUp setAbove:YES];
	}
	id extraChars;
	if ([initialValues objectForKey:@"extraChars"])
		extraChars = [initialValues objectForKey:@"extraChars"];
	else
		extraChars = [NSNull null];
	[[xPopUp window] setFrameTopLeftPoint:pos];
    [xPopUp showWindow:self];
	int i;
	for(i=0;i<=1000;i++)
	{
		[[xPopUp window] setAlphaValue:i*0.001];
	}
	NSLog(@"%d xpop before",[xPopUp retainCount]);
	[self performSelector: @selector(eventHandlingForExtendedPopupMenu:)
               withObject: [NSDictionary dictionaryWithObjectsAndKeys:xPopUp,@"xPopUp",extraChars,@"extraChars",nil]
               afterDelay: 0.1];
	[xPopUp release];
	NSLog(@"%d xpop after",[xPopUp retainCount]);
}

-(void) eventHandlingForExtendedPopupMenu:(id)dict
{	
	id extraChars = [dict objectForKey:@"extraChars"];
	TMDIncrementalPopUpMenu* xPopUp = [dict objectForKey:@"xPopUp"];
	NSLog(@"%d xpop eventHandlingForExtendedPopupMenu",[xPopUp retainCount]);
	NSCharacterSet* whiteList;
	if (extraChars == [NSNull null]){
		whiteList = nil;
	}
	else{
		whiteList = [NSCharacterSet characterSetWithCharactersInString:extraChars];
	}
	NSDate *distantFuture = [NSDate distantFuture];
	NSEvent *event;
	do{
		event = [NSApp nextEventMatchingMask: NSAnyEventMask
                                   untilDate: distantFuture
                                      inMode: NSDefaultRunLoopMode
                                     dequeue: YES];
		if([xPopUp getCloseStatus])
			break;
		if (event != nil)
		{
			NSEventType t = [event type];
			if(t == NSKeyDown){
				NSString* aString = [event characters];
				unsigned int flags = [event modifierFlags];
				unichar		key = 0;
				if((flags & NSControlKeyMask) || (flags & NSAlternateKeyMask) || (flags & NSCommandKeyMask))
				{
					[NSApp sendEvent:event];
					break;
				}
				else if([aString length] == 1){
					key = [aString characterAtIndex:0];
					if(key == NSCarriageReturnCharacter ){
						[xPopUp keyDown:event];
						break;
					}
					else if (key == NSBackspaceCharacter || key == NSDeleteCharacter){
						[NSApp sendEvent:event];
						if([[xPopUp mutablePrefix] length] > 0){
							[xPopUp keyDown:event];
							}
						else{
							break;
						}
					}else if ([event keyCode] == 53){
						break;
					
					}else if(key == NSTabCharacter)
					{
						if ([[xPopUp filtered] count] == 0){
							[NSApp sendEvent:event];
							break;
						}
						if ([[xPopUp filtered] count] == 1){
							[xPopUp keyDown:event];
							break;
						}
						[xPopUp keyDown:event];
					}   
					else if (key == NSUpArrowFunctionKey || key == NSDownArrowFunctionKey)
					{ 
						[[xPopUp theTableView] keyDown:event];
					}
					else if (key == NSEndFunctionKey)
					{ 
						[xPopUp moveToEndOfDocument:self];
					}
					else if (key == NSHomeFunctionKey)
					{ 
						[xPopUp moveToBeginningOfDocument:self];
					}
					else if (key == NSPageDownFunctionKey)
					{ 
						[xPopUp pageDown:self];
					}
					else if (key == NSPageUpFunctionKey)
					{ 
						[xPopUp pageUp:self];
					}
					else if ([[NSCharacterSet alphanumericCharacterSet] characterIsMember:key] ||
							(whiteList && [whiteList characterIsMember:key])) {
						[NSApp sendEvent:event];
						[xPopUp keyDown:event];
					}else{
						[NSApp sendEvent:event];
						//[xPopUp keyDown:event];
						break;
					}
				}
				else{
						[NSApp sendEvent:event];
						//[xPopUp keyDown:event];
						break;
				}
			
			
			}
 			else if(t == NSScrollWheel){
 				if([event deltaY] >= 0.0)
 					[xPopUp scrollLineUp:self];
				else
					[xPopUp scrollLineDown:self];
			}else if(t == NSRightMouseDown || t == NSLeftMouseDown){
				[NSApp sendEvent:event];
				if(! NSPointInRect([NSEvent mouseLocation], [[xPopUp window] frame]))
					break;
			}
			  else
			{ 
				[NSApp sendEvent:event];
			}
			
			
		}
	}
	while(1);
	[xPopUp close];
	NSLog(@"windowDidClose xPopUp %d",[xPopUp retainCount]);
	[xPopUp release];
}


@end
