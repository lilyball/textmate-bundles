//
//  CommitWindowController.m
//
//  Created by Chris Thomas on 2/6/05.
//  Copyright 2005-2006 Chris Thomas. All rights reserved.
//	MIT license.
//

#import "CommitWindowController.h"
#import "NSString+StatusString.h"

#define kStatusColumnWidthForSingleChar	18

@interface CommitWindowController (Private)
- (void) populatePreviousSummaryMenu;
@end

// Forward string comparisons to NSString
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


// fFilesController and fFilesStatusStrings should be set up before calling setupUserInterface.
- (void) setupUserInterface
{
	NSCell * cell = [fPathColumn dataCell];
	if([cell respondsToSelector:@selector(setLineBreakMode:)])
		[cell setLineBreakMode:NSLineBreakByTruncatingHead];

	//
	// Done processing arguments, now add status to each item
	// 								and choose default commit state
	//
	if( fFileStatusStrings != nil )
	{
		NSArray *	files = [fFilesController arrangedObjects];
		int			count = MIN([files count], [fFileStatusStrings count]);
		int			i;
		
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
			[dictionary setObject:[status attributedStatusString] forKey:@"attributedStatus"];

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

// To make redo work, we need to add a new undo each time
- (void) restoreTextForUndo:(NSString *)newSummary
{
	NSUndoManager *	undoManager = [[fCommitMessage window] undoManager];
    NSString *		oldSummary = [fCommitMessage string];
    
    [undoManager registerUndoWithTarget:self
                                            selector:@selector(restoreTextForUndo:)
                                            object:[[oldSummary copy] autorelease]];

	[fCommitMessage setString:newSummary];

}

- (void) restoreSummary:(id)sender
{
	NSString *		newSummary = [sender representedObject];
	
	[self restoreTextForUndo:newSummary];
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

@end
