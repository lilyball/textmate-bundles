//
//  CommitWindowController.m
//
//  Created by Chris Thomas on 2/6/05.
//  Copyright 2005 Chris Thomas. All rights reserved.
//	MIT license.
//

#import "CommitWindowController.h"
#import "VersionControlColors.h"

@interface CommitWindowController (Private)
- (void) populatePreviousSummaryMenu;
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
		else
		{
			NSMutableDictionary *	dictionary	= [fFilesController newObject];
			BOOL					itemSelectedForCommit;

			[dictionary setObject:[argument stringByAbbreviatingWithTildeInPath] forKey:@"path"];
			if( fFileStatusStrings != nil )
			{
				// Deselect external commits by default
				if([[fFileStatusStrings objectAtIndex:[[fFilesController content] count]] hasPrefix:@"X"])
				{
					itemSelectedForCommit = NO;
				}
				else
				{
					itemSelectedForCommit = YES;
				}
				[dictionary setObject:[NSNumber numberWithBool:itemSelectedForCommit] forKey:@"commit"]; 
			}
	
			[fFilesController addObject:dictionary];
		}
	}
	
	//
	// Done processing arguments, now add status to each item
	//
	if( fFileStatusStrings != nil )
	{
		NSArray * files = [fFilesController arrangedObjects];
		for( i = 0; i < MIN([files count], [fFileStatusStrings count]); i += 1 )
		{
			NSMutableDictionary *	dictionary = [files objectAtIndex:i];
			[dictionary setObject:[fFileStatusStrings objectAtIndex:i] forKey:@"status"];
		}
	}
	
	[fFilesController objectDidEndEditing:nil];

	
	//
	// Populate previous summary menu
	//
	[self populatePreviousSummaryMenu];

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

		unsigned int	summaryCount = [summaries count];
		unsigned int	index;

		// PopUp title
		[menu addItemWithTitle:@kPreviousSummariesItemTitle action:@selector(restoreSummary:) keyEquivalent:@""];
		
		for(index = 0; index < summaryCount; index += 1)
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

// Save, in an LRU list, the most recent commit summary
- (void) saveSummary
{
	NSUserDefaults *  	defaults		= [NSUserDefaults standardUserDefaults];
	NSString *			latestSummary	= [fCommitMessage string];
	
	NSLog(@"%s%@", _cmd, latestSummary);
	
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

//
// Attempt to mirror the appearance of the status and info displays
//
- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(int)row
{
	// Set colors if appropriate
	if(fFileStatusStrings != nil && tableColumn == fStatusColumn )
	{

		NSArray * 				files		= [fFilesController arrangedObjects];
		NSMutableDictionary *	dictionary	= [files objectAtIndex:row];
		NSString * 				status		= [dictionary objectForKey:@"status"];
		NSColor *				foreColor;
		NSColor *				backColor;

		backColor = BackColorFromStatus(status);
		
		[cell setDrawsBackground:YES];
		[cell setBackgroundColor:backColor];
		
		if( tableColumn == fStatusColumn )
		{
			foreColor = ForeColorFromStatus(status);
			[cell setTextColor:foreColor];
		}
		else
		{
			[cell setTextColor:[NSColor blackColor]];
		}
	}
}


@end
