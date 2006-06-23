//
//  CommitWindowController.m
//
//  Created by Chris Thomas on 2/6/05.
//  Copyright 2005 Chris Thomas. All rights reserved.
//	MIT license.
//

#import "CommitWindowController.h"
#import "VersionControlColors.h"

#define kStatusColumnWidthForSingleChar	18

@interface CommitWindowController (Private)
- (void) populatePreviousSummaryMenu;
- (NSAttributedString *) attributedStatusString:(NSString *)statusString;
@end

// Forward string comparisons
@interface NSAttributedString (CommitWindowExtensions)
- (NSComparisonResult)compare:(id)anArgument;
@end

@implementation NSAttributedString (CommitWindowExtensions)
- (NSComparisonResult)compare:(id)aString
{
	return [[self string] compare:[aString string]];
}
@end


@implementation CommitWindowController

- (void) awakeFromNib
{
	NSCell * cell = [fPathColumn dataCell];
	if([cell respondsToSelector:@selector(setLineBreakMode:)])
		[cell setLineBreakMode:NSLineBreakByTruncatingHead];

	NSProcessInfo * processInfo = [NSProcessInfo processInfo];
	NSArray *		args;
	int				i;
	int				argc;
	
	args = [processInfo arguments];
	argc = [args count];

	if( args == nil || argc < 2 )
	{
		fprintf(stderr, "commit window: Arguments required\n");
		[self cancel:nil];
	}
	
	//
	// Parse the command line.
	//
	
	// Program name is the first argument -- get rid of it. (COW semantics should make this cheaper than it looks.)
	argc -= 1;
	args = [args subarrayWithRange:NSMakeRange(1, argc)];

	// Populate our NSArrayController with the command line arguments
	[fFilesController objectDidBeginEditing:nil];
	for( i = 0; i < argc; i += 1 )
	{
		NSString *				argument	= [args objectAtIndex:i];
		
		if( [argument isEqualToString:@"--ask"] )
		{
			// Next argument should be the query text.
			if( i >= (argc - 1) )
			{
				fprintf(stderr, "commit window: missing text: --ask \"some text\"\n");
				[self cancel:nil];
			}
			
			i += 1;
			argument	= [args objectAtIndex:i];
			[fRequestText setStringValue:argument];
		}
		else if( [argument isEqualToString:@"--status"] )
		{
			// Next argument should be a colon-seperated list of status strings, one for each path
			if( i >= (argc - 1) )
			{
				fprintf(stderr, "commit window: missing text: --status \"A:D:M:M:M\"\n");
				[self cancel:nil];
			}
			
			i += 1;
			argument	= [args objectAtIndex:i];
			fFileStatusStrings = [[argument componentsSeparatedByString:@":"] retain];
		}
		else if( [argument isEqualToString:@"--diff-cmd"] )
		{
			// Next argument should be a comma-seperated list of command arguments to use to execute the diff
			if( i >= (argc - 1) )
			{
				fprintf(stderr, "commit window: missing text: --diff-cmd \"/usr/bin/svn,diff\"\n");
				[self cancel:nil];
			}
			
			i += 1;
			argument	= [args objectAtIndex:i];
			fDiffCommand = [argument retain];
		}
		else
		{
			NSMutableDictionary *	dictionary	= [fFilesController newObject];

			[dictionary setObject:[argument stringByAbbreviatingWithTildeInPath] forKey:@"path"];
			[fFilesController addObject:dictionary];
		}
	}
	
	//
	// Done processing arguments, now add status to each item
	// 								and choose default commit state
	//
	if( fFileStatusStrings != nil )
	{
		NSArray *	files = [fFilesController arrangedObjects];
		int			count = MIN([files count], [fFileStatusStrings count]);
		
		UInt32		maxCharsToDisplay = 0;
		
		for( i = 0; i < count; i += 1 )
		{
			NSMutableDictionary *	dictionary	= [files objectAtIndex:i];
			NSString *				status		= [fFileStatusStrings objectAtIndex:i];
			BOOL					itemSelectedForCommit;
			UInt32					statusLength;
			
			// Set high-water mark
			statusLength = [status length];
			if( statusLength > maxCharsToDisplay )
			{
				maxCharsToDisplay = statusLength;
			}
			
			[dictionary setObject:status forKey:@"status"];
			[dictionary setObject:[self attributedStatusString:status] forKey:@"attributedStatus"];

			// Deselect external commits by default
			if([status hasPrefix:@"X"])
			{
				itemSelectedForCommit = NO;
			}
			else
			{
				itemSelectedForCommit = YES;
			}
			[dictionary setObject:[NSNumber numberWithBool:itemSelectedForCommit] forKey:@"commit"]; 
		}

		// Set status column size
		[fStatusColumn setWidth:maxCharsToDisplay * kStatusColumnWidthForSingleChar];
	}
	
	[fFilesController objectDidEndEditing:nil];

	
	//
	// Populate previous summary menu
	//
	[self populatePreviousSummaryMenu];

	[fTableView setTarget:self];
	[fTableView setDoubleAction:@selector(doubleClickRowInTable:)];

	//
	// Map the enter key to the OK button
	//
	[fOKButton setKeyEquivalent:@"\x03"];
	[fOKButton setKeyEquivalentModifierMask:0];

	//
	// Bring the window to absolute front.
	// -[NSWindow orderFrontRegardless] doesn't work (maybe because we're an LSUIElement).
	//
	
	// Process Manager works, though!
	{
		ProcessSerialNumber process;
	
		GetCurrentProcess(&process);
		SetFrontProcess(&process);
	}
	
	
	[self setWindow:fWindow];
	[fWindow setLevel:NSModalPanelWindowLevel];
	[fWindow center];
	
	//
	// Grow the window to fit as much of the file list onscreen as possible
	//
	{
		NSScreen *		screen		= [fWindow screen];
		NSRect			usableRect	= [screen visibleFrame];
		NSRect			windowRect	= [fWindow frame];
		NSTableView *	tableView	= [fPathColumn tableView];
		float			rowHeight	= [tableView rowHeight];
		int				rowCount	= [[fFilesController arrangedObjects] count];
		float			idealVisibleHeight;
		float			currentVisibleHeight;
		float			deltaVisibleHeight;
		
		currentVisibleHeight	= [[tableView superview] frame].size.height;
		idealVisibleHeight		= (rowHeight * rowCount) + [[tableView headerView] frame].size.height;
		
//		NSLog(@"current: %g ideal:%g", currentVisibleHeight, idealVisibleHeight );
		
		// Don't bother shrinking the window
		if(currentVisibleHeight < idealVisibleHeight)
		{
			deltaVisibleHeight = (idealVisibleHeight - currentVisibleHeight);

//			NSLog( @"old windowRect: %@", NSStringFromRect(windowRect) );

			// reasonable margin
			usableRect = NSInsetRect( usableRect, 20, 20 );
			windowRect = NSIntersectionRect(usableRect, NSInsetRect(windowRect, 0, -deltaVisibleHeight));
			
//			NSLog( @"new windowRect: %@", NSStringFromRect(windowRect) );
			
			[fWindow setFrame:windowRect display:NO];
		}
	}
	
	// center again after resize
	[fWindow center];
	[fWindow makeKeyAndOrderFront:self];
	
}

#if 0
#pragma mark -
#pragma mark Summary save/restore
#endif

#define kMaxSavedSummariesCount					5
#define kDisplayCharsOfSummaryInMenuItemCount	30
#define kPreviousSummariesKey					"prev-summaries"
#define kPreviousSummariesItemTitle				"Previous Summaries"

- (void) populatePreviousSummaryMenu
{
	NSUserDefaults *  	defaults		= [NSUserDefaults standardUserDefaults];
	NSArray *			summaries		= [defaults arrayForKey:@kPreviousSummariesKey];
	
	if( summaries == nil )
	{
		// No previous summaries, no menu
		[fPreviousSummaryPopUp setEnabled:NO];
	}
	else
	{
		NSMenu *			menu = [[NSMenu alloc] initWithTitle:@kPreviousSummariesItemTitle];
		NSMenuItem *		item;

		int	summaryCount = [summaries count];
		int	index;

		// PopUp title
		[menu addItemWithTitle:@kPreviousSummariesItemTitle action:@selector(restoreSummary:) keyEquivalent:@""];
		
		// Add items in reverse-chronological order
		for(index = (summaryCount - 1); index >= 0; index -= 1)
		{
			NSString *	summary = [summaries objectAtIndex:index];
			NSString *	itemName;
			
			itemName = summary;
			
			// Limit length of menu item names
			if( [itemName length] > kDisplayCharsOfSummaryInMenuItemCount )
			{
				itemName = [itemName substringToIndex:kDisplayCharsOfSummaryInMenuItemCount];
				
				// append ellipsis
				itemName = [itemName stringByAppendingFormat: @"%C", 0x2026];
			}

			item = [menu addItemWithTitle:itemName action:@selector(restoreSummary:) keyEquivalent:@""];
			[item setTarget:self];
			
			[item setRepresentedObject:summary];
		}

		[fPreviousSummaryPopUp setMenu:menu];
	}
}

- (void) restoreSummary:(id)sender
{
	NSString *	summary = [sender representedObject];

	[fCommitMessage setString:summary];
}

// Save, in a MRU list, the most recent commit summary
- (void) saveSummary
{
	NSUserDefaults *  	defaults		= [NSUserDefaults standardUserDefaults];
	NSString *			latestSummary	= [fCommitMessage string];
	
	// avoid empty string
	if( ! [latestSummary isEqualToString:@""] )
	{
		NSArray *			oldSummaries = [defaults arrayForKey:@kPreviousSummariesKey];
		NSMutableArray *	newSummaries;

		if( oldSummaries != nil )
		{
			unsigned int	oldIndex;
			
			newSummaries = [oldSummaries mutableCopy];
			
			// Already in the array? Move it to latest position
			oldIndex = [newSummaries indexOfObject:latestSummary];
			if( oldIndex != NSNotFound )
			{
				[newSummaries exchangeObjectAtIndex:oldIndex withObjectAtIndex:[newSummaries count] - 1];
			}
			else
			{
				// Add object, remove oldest object
				[newSummaries addObject:latestSummary];
				if( [newSummaries count] > kMaxSavedSummariesCount )
				{
					[newSummaries removeObjectAtIndex:0];
				}
			}
		}
		else
		{
			// First time
			newSummaries = [NSMutableArray arrayWithObject:latestSummary];
		}

		[defaults setObject:newSummaries forKey:@kPreviousSummariesKey];

		// Write the defaults to disk
		[defaults synchronize];
	}
}

#if 0
#pragma mark -
#pragma mark Actions
#endif



- (IBAction) commit:(id) sender
{
	NSArray *			objects = [fFilesController arrangedObjects];
	int					i;
	int					pathsToCommitCount = 0;
	NSMutableString *	commitString;
	
	[self saveSummary];
	
	//
	// Quote any single-quotes in the commit message
	// \' doesn't work with bash. We must use string concatenation.
	// This sort of thing is why the Unix Hater's Handbook exists.
	//
	commitString = [[[fCommitMessage string] mutableCopy] autorelease];
	[commitString replaceOccurrencesOfString:@"'" withString:@"'\"'\"'" options:0 range:NSMakeRange(0, [commitString length])];
	
	fprintf(stdout, "-m '%s' ", [commitString UTF8String] );
	
	//
	// Return only the files we care about
	//
	for( i = 0; i < [objects count]; i += 1 )
	{
		NSMutableDictionary *	dictionary;
		NSNumber *				commit;
		
		dictionary	= [objects objectAtIndex:i];
		commit		= [dictionary objectForKey:@"commit"];
		
		if( commit == nil || [commit boolValue] )	// missing commit key defaults to true
		{
			NSMutableString *		path;
			
			//
			// Quote any single-quotes in the path
			//
			path = [dictionary objectForKey:@"path"];
			path = [[[path stringByStandardizingPath] mutableCopy] autorelease];
			[path replaceOccurrencesOfString:@"'" withString:@"'\"'\"'" options:0 range:NSMakeRange(0, [path length])];

			fprintf( stdout, "'%s' ", [path UTF8String] );
			pathsToCommitCount += 1;
		}
	}
	
	fprintf( stdout, "\n" );
	
	//
	// SVN will commit the current directory, recursively, if we don't specify files.
	// So, to prevent surprises, if the user's unchecked all the boxes, let's be on the safe side and cancel.
	//
	if( pathsToCommitCount == 0 )
	{
		[self cancel:nil];
	}
	
	[NSApp terminate:self];
}

- (IBAction) cancel:(id) sender
{
	[self saveSummary];
		
	fprintf(stdout, "commit window: cancel\n");
	exit(-128);
}

- (IBAction) doubleClickRowInTable:(id)sender
{
	if(fDiffCommand != nil)
	{
		NSArray *			unquotedArguments	= [fDiffCommand componentsSeparatedByString:@","];
		NSString *			quoteArgument		= @"\"%@\"";
		NSString *			diffCommand			= @"";
		NSString *			mateCommand			= [NSString stringWithFormat:@"\"%s/bin/mate\" &> /dev/null &", getenv("TM_SUPPORT_PATH")];
		NSString *			filePath			= [[[fFilesController arrangedObjects] objectAtIndex:[sender selectedRow]] objectForKey:@"path"];
		unsigned int	argumentCount = [unquotedArguments count];
		unsigned int	index;
		
		for(index = 0; index < argumentCount; index += 1)
		{
			NSString *	argument = [unquotedArguments objectAtIndex:index];
			NSString *	quotedArgument = [NSString stringWithFormat:quoteArgument, argument];
			
			diffCommand = [diffCommand stringByAppendingString:quotedArgument];
			diffCommand = [diffCommand stringByAppendingString:@" "];
		}

		diffCommand = [diffCommand stringByAppendingString:[NSString stringWithFormat:quoteArgument, filePath]];
		diffCommand = [diffCommand stringByAppendingString:[NSString stringWithFormat:@" | %@", mateCommand]];
		
		system([diffCommand UTF8String]);
	}
	
}

//
// Attempt to mirror the appearance of the status and info displays
//

- (NSAttributedString *) attributedStatusString:(NSString *)statusString
{
	UInt32						length = [statusString length];
	NSMutableAttributedString *	attributedStatusString = [[[NSMutableAttributedString alloc] init] autorelease];
	unsigned int				i;
	unichar						emSpace		= 0x2003;
	unichar						hairSpace	= 0x200A;
	NSAttributedString *		spaceString	= [[[NSAttributedString alloc] initWithString:@" " attributes:nil] autorelease];
	
	for( i = 0; i < length; i += 1 )
	{
		unichar 				character = [statusString characterAtIndex:i];
		NSString *				charString;
		NSAttributedString *	attributedCharString;
		NSColor *				foreColor;
		NSColor *				backColor;
		NSDictionary *			attributes;
		
		// We pass in underscores for empty multicolumn attributes
		if(character == '_')
		{
			character = emSpace;
		}
		charString = [NSString stringWithCharacters:&character length:1];
		
		ColorsFromStatus( charString, &foreColor, &backColor );

		attributes = [NSDictionary dictionaryWithObjectsAndKeys:foreColor,	NSForegroundColorAttributeName,
																backColor,	NSBackgroundColorAttributeName,
																nil];

		attributedCharString = [[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%C%@%C", hairSpace, charString, hairSpace] attributes:attributes] autorelease];
		
		[attributedStatusString appendAttributedString:attributedCharString];
		[attributedStatusString appendAttributedString:spaceString];
	}
	
	return attributedStatusString;
}

@end
