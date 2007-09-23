#import "../Dialog.h"
#import "../TMDCommand.h"

// =========
// = Alert =
// =========

@interface TMDAlertCommand : TMDCommand
{
}
@end

@implementation TMDAlertCommand
+ (void)load
{
	[super registerObject:[self new] forCommand:@"alert"];
}

- (void)handleCommand:(id)options
{
	NSFileHandle* fh = [options objectForKey:@"stderr"];
	[fh writeData:[@"Alerts are not implemented yet." dataUsingEncoding:NSUTF8StringEncoding]];
#if 0
	NSAlertStyle		alertStyle = NSInformationalAlertStyle;
	NSAlert*			alert;
	NSDictionary*		resultDict = nil;
	NSArray*			buttonTitles = [parameters objectForKey:@"buttonTitles"];
	NSString*			alertStyleString = [parameters objectForKey:@"alertStyle"];
		
	alert = [[[NSAlert alloc] init] autorelease];
	
	if([alertStyleString isEqualToString:@"warning"])
	{
		alertStyle = NSWarningAlertStyle;
	}
	else if([alertStyleString isEqualToString:@"critical"])
	{
		alertStyle = NSCriticalAlertStyle;
	}
	else if([alertStyleString isEqualToString:@"informational"])
	{
		alertStyle = NSInformationalAlertStyle;
	}
	
	[alert setAlertStyle:alertStyle];
	[alert setMessageText:[parameters objectForKey:@"messageTitle"]];
	[alert setInformativeText:[parameters objectForKey:@"informativeText"]];
	
	// Setup buttons
	if(buttonTitles != nil && [buttonTitles count] > 0)
	{
		unsigned int	buttonCount = [buttonTitles count];

		// NSAlert always preallocates the OK button.
		// No -- docs are not entirely correct.
//		[[[alert buttons] objectAtIndex:0] setTitle:[buttonTitles objectAtIndex:0]];

		for(unsigned int index = 0; index < buttonCount; index += 1)
		{
			NSString *	buttonTitle = [buttonTitles objectAtIndex:index];

			[alert addButtonWithTitle:buttonTitle];
		}
	}
	
	// Show the alert
	if(not modal)
	{
#if 1
		// Not supported yet; needs same infrastructure as will be required for nib-based sheets.
		[NSException raise:@"NotSupportedYet" format:@"Sheet alerts not yet supported."];
#else
		// Window-modal (sheet).NSWindowController
		// Find the window corresponding to the given path

		NSArray* windows = [NSApp windows];
		NSWindow* chosenWindow = nil;
		
		enumerate(windows, NSWindow * window)
		{
			OakDocumentController*	documentController = [window controller];
			if([documentController isKindOfClass:[OakDocumentController class]])
			{
				if(filePath == nil)
				{
					// Take first visible document window
					if( [window isVisible] )
					{
						chosenWindow = window;
						break;
					}
				}
				else
				{
					// Find given document window
					// TODO: documentWithContentsOfFile may be a better way to do this
					// FIXME: standardize paths
					if([[documentController->textDocument filename] isEqualToString:filePath])
					{
						chosenWindow = window;
						break;
					}
				}
			}
		}
		
		// Fall back to modal
		if(chosenWindow == nil)
		{
			modal = YES;
		}
#endif
	}
	
	if(modal)
	{
		int alertResult = ([alert runModal] - NSAlertFirstButtonReturn);
		
		resultDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:alertResult] forKey:@"buttonClicked"];
	}
	return resultDict;
#endif
}
@end
