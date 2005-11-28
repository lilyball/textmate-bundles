#include "CXSVNRepoBrowser.h"
#include "CXSVNRepoNode.h"
#include "CXSVNTask.h"
#include "CXTransientStatusWindow.h"
#include <Foundation/NSDebug.h>
#include "ImageAndTextCell.h"

@implementation CXSVNRepoBrowser

+ (CXSVNRepoBrowser *) browser
{
	return [self browserAtURL:nil];
}

+ (CXSVNRepoBrowser *) browserAtURL:(NSString *)URL	// may be nil
{
	static NSNib *		sBrowserNib = nil;
	
	NSArray *			array;
	CXSVNRepoBrowser *	outBrowser = nil;
	
	if(sBrowserNib == nil)
	{
		sBrowserNib = [[NSNib alloc] initWithNibNamed:@"SVNRepoBrowser" bundle:[NSBundle bundleForClass:[self class]]];
	}
	
	[sBrowserNib instantiateNibWithOwner:self topLevelObjects:&array];
	
	if(array == nil)
	{
		NSLog(@"Storehouse: can't find the browser nib!");
	}
	else
	{
		//
		// Find the new repo object
		//
		for( unsigned int index = 0; index < [array count]; index += 1 )
		{
			id	object = [array objectAtIndex:index];
		
			if([object isKindOfClass:[CXSVNRepoBrowser class]])
			{
				outBrowser = (CXSVNRepoBrowser *)object;
			}
		}
	
		[[outBrowser->fOutlineView window] makeKeyAndOrderFront:self];
	
		outBrowser->fStatusWindow = [[CXTransientStatusWindow alloc] init];
	
		// Load the requested URL
		if(URL != nil)
		{
			[outBrowser loadURL:URL];
		}
	
//		[outBrowser->fStatusWindow showStatus:@"testing" onParent:[outBrowser->fOutlineView window]];

	}
	
	
	return [outBrowser autorelease];
}

- (CXSVNRepoNode *) visibleNodeForURL:(NSString *)URL
{
	CXSVNRepoNode *	node = [fRootNode visibleNodeForURL:URL];
	
	if(node == nil)
	{
		NSLog(@"No visible node for %@", URL);
	}

	return node;
}

- (NSString *) URL
{
	return [fURLField stringValue];
}

- (void) awakeFromNib
{
//	NSBrowserCell *	cell = [[[NSBrowserCell alloc] init] autorelease];
	ImageAndTextCell *	cell = [[[ImageAndTextCell alloc] init] autorelease];
//	NSZombieEnabled = 1;

	[cell setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSSmallControlSize]]];
	
	[[fOutlineView window] setHidesOnDeactivate:NO];

	[[fOutlineView tableColumnWithIdentifier:@"1"] setDataCell:cell];
	
	// TODO: accept filenanes and URLs
	[fOutlineView registerForDraggedTypes:[NSArray arrayWithObjects:NSStringPboardType, nil]];

	[fOutlineView setDraggingSourceOperationMask:NSDragOperationCopy|NSDragOperationMove forLocal:NO];
	[fOutlineView setDraggingSourceOperationMask:NSDragOperationCopy|NSDragOperationMove forLocal:YES];
}

- (IBAction) getRootURLFromField:(id)sender
{
	[self takeRootURLFrom:fURLField];
}

- (IBAction) takeRootURLFrom:(id)sender
{
	[self loadURL:[sender stringValue]];
}

// Position the given browser right next to this one
- (void) syncNextBrowserWindowFrame:(CXSVNRepoBrowser *)browser
{
	NSRect	frame = [[fOutlineView window] frame];
	
	frame.origin.x += frame.size.width + 2;
	
	[[browser->fOutlineView window] setFrameOrigin:frame.origin];
}

- (void)loadURL:(NSString *)URL
{
	URL = [URL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	[fURLField setStringValue:URL];
	
	if( fRepoLocation == nil || ![fRepoLocation isEqualToString:URL] )
	{
		fRepoLocation = [URL copy];

		[fRootNode release];
		fRootNode = [[CXSVNRepoNode rootNodeWithURL:fRepoLocation] retain];

		[fRootNode setDelegate:self];
		[fOutlineView reloadData];
	}
}

- (CXSVNRepoNode *) nextNodeFromPath:(NSMutableArray *)path inChildren:(NSArray *)children
{
	CXSVNRepoNode * outNode = NULL;
	NSString *		name = [path objectAtIndex:0];
	
	for( unsigned int index = 0; index < [children count]; index += 1 )
	{
		CXSVNRepoNode * node = [children objectAtIndex:index];
		
		if( [[node displayName] isEqualToString:name] )
		{
			outNode = node;
			break;
		}
	}
	
	[path removeObjectAtIndex:0];
	
	return outNode;
}

- (CXSVNRepoNode *) nodeFromPath:(NSArray *)path
{
	NSMutableArray *	mutablePath = [path mutableCopy];
	CXSVNRepoNode *		outNode		= nil;
	CXSVNRepoNode *		currentNode = fRootNode;
	
	while(true)
	{
		currentNode = [self nextNodeFromPath:mutablePath inChildren:[currentNode children]];
		
		if(currentNode == nil)
		{
			break;
		}
		else if([mutablePath count] == 0)
		{
			outNode = currentNode;
			break;
		}
	}
	
	return outNode;
}

#if 0
#pragma mark Context menu
#endif

// FIXME: item validation

- (IBAction) contextRefresh:(id)sender
{
	CXSVNRepoNode *	node;
	node = [fOutlineView itemAtRow:[fOutlineView selectedRow]];
	
	[node invalidateChildren];
	[node loadChildren];
}

- (IBAction) contextMakeDir:(id)sender
{
	CXSVNRepoNode *	node;
	node = [fOutlineView itemAtRow:[fOutlineView selectedRow]];
	
	if(node != nil)
	{
		[self makeDirAtNode:node];
	}
}



#if 0
#pragma mark Outline View delegate
#endif

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
	static NSMutableDictionary *	sFileTypeCache = nil;
	
	//
	// The filetype cache prevents us from recreating the image
	// object each time the same file type is encountered.
	//
	// Although IconServices caches the underlying icon representation,
	// so memory isn't wasted, NSWorkspace cannot (for various reasons)
	// return the same NSImage object instance each time, and it turns
	// out that creating an IconRef-based NSImage is relatively expensive.
	//
	if(sFileTypeCache == nil)
	{
		sFileTypeCache = [[NSMutableDictionary alloc] init];
	}
	
	if( item == nil )
	{
		// ignore root item, not really displayed as such
//		item = fRootNode;
	}
	else
	{
		NSString *		fileType;
		NSImage *		image;
		
		// folder?
		if( [item isBranch] )
		{
			fileType = NSFileTypeForHFSTypeCode(kGenericFolderIcon);
		}
		else
		{	
			// try for icon name
			fileType = [[item displayName] pathExtension];
		}
		
		image = [sFileTypeCache objectForKey:fileType];
		if(image == nil)
		{
			NSWorkspace *	workspace = [NSWorkspace sharedWorkspace];
			
			image = [workspace iconForFileType:fileType];
			[image setSize:NSMakeSize(16,16)];
			[sFileTypeCache setObject:image forKey:fileType];
		}
		
		[cell setImage:image];
		
	}
}

#if 0
#pragma mark Outline View data source
#endif

- (id)outlineView:(NSOutlineView *)outlineView child:(int)index ofItem:(id)item
{
//	NSLog(@"%s child:%d", _cmd, index);
	
	if( item == nil )
	{
		item = fRootNode;
	}
	
	[item loadChildren];
	return [[item children] objectAtIndex:index];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
	if( item == nil )
	{
		item = fRootNode;
	}
	
	// we don't want to use [itemChildren count] > 0,
	// because that will instantiate itemChildren immediately.
	return [item isBranch];		
}

- (int)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
	if( item == nil )
	{
		item = fRootNode;
	}
	
	[item loadChildren];
	return [[item children] count];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
	if( item == nil )
	{
		item = fRootNode;
	}
	return [item displayName];		
}

- (BOOL)outlineView:(NSOutlineView *)outlineView writeItems:(NSArray *)items toPasteboard:(NSPasteboard *)pboard
{
	NSMutableArray	*	array = [NSMutableArray array];
	BOOL				success = NO;
	
	for( unsigned int index = 0; index < [items count]; index += 1 )
	{
		CXSVNRepoNode * node = [items objectAtIndex:index];
		
		[array addObject:[node URL]];
	}
	
	if( [array count] > 0 )
	{
		// NSURLPboardType can only carry one URL.
		[pboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
		[pboard setString:[array componentsJoinedByString:@"\n"] forType:NSStringPboardType];
		success = YES;
	}
	
	return success;
}

- (NSDragOperation)outlineView:(NSOutlineView *)outlineView validateDrop:(id <NSDraggingInfo>)info proposedItem:(id)item proposedChildIndex:(int)index
{
//	NSLog(@"%@ %d", item, index );
	
	NSDragOperation operationMask;

	if( item == nil )
	{
		item = fRootNode;
	}

	if(![item isBranch])
	{
		[outlineView setDropItem:[item parentNode] dropChildIndex:NSOutlineViewDropOnItemIndex];
	}
	else if(index != NSOutlineViewDropOnItemIndex)
	{
		[outlineView setDropItem:item dropChildIndex:NSOutlineViewDropOnItemIndex];
	}

	// Finder semantics: option to copy, no modifiers to move
	operationMask = [info draggingSourceOperationMask];
	
	// Move
	if (operationMask & NSDragOperationMove)
	{
		return NSDragOperationMove;
	}
	
	// Copy
	return NSDragOperationCopy;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView acceptDrop:(id <NSDraggingInfo>)info item:(id)item childIndex:(int)index
{
	NSPasteboard * pboard = [info draggingPasteboard];
	BOOL			accepted = NO;
	
	if ([pboard availableTypeFromArray:[NSArray arrayWithObject: NSStringPboardType]])
	{
		NSString *	string = [pboard stringForType: NSStringPboardType];
		NSArray *	URLsToCopy;
		SEL			action = @selector(copyURLAction:);

		URLsToCopy = [string componentsSeparatedByString:@"\n"];

		// get us out of the drag and drop loop
		
		if (([info draggingSourceOperationMask] & NSDragOperationMove) == NSDragOperationMove)
		{
			action = @selector(moveURLAction:);
		}

		[self performSelector:action
					withObject:[NSArray arrayWithObjects:[URLsToCopy objectAtIndex:0], [item URL], nil]
					afterDelay:0.0];
		accepted = YES;
	}


//	[outlineView reloadData];
//	[outlineView selectItems:item byExtendingSelection:NO];
	
	return accepted;
}

// Support renames
- (void)outlineView:(NSOutlineView *)outlineView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
	if( item == nil )
	{
		[NSException raise:@"Root item renamed" format:@"Shouldn't be able to set the value of the root item"];
	}
	
	[self askForCommitWithVerb:@"Rename:"
				prompt:@"Reason for the rename?"
				URLs:[NSArray arrayWithObjects:[item URL], [item URL], nil]
				action:@selector(moveURL:toURL:withDescription:)];
	
}

- (void) moveURLAction:(NSArray *)args
{
	NSString *				pathFrom		= [args objectAtIndex:0];
	NSString *				pathTo			= [args objectAtIndex:1];

	[self askForCommitWithVerb:@"Move:"
				prompt:@"Reason for the move?"
				URLs:[NSArray arrayWithObjects:pathFrom, pathTo, nil]
				action:@selector(moveURL:toURL:withDescription:)];
}

- (void) copyURLAction:(NSArray *)args
{
	NSString *				pathFrom		= [args objectAtIndex:0];
	NSString *				pathTo			= [args objectAtIndex:1];

	[self askForCommitWithVerb:@"Copy:"
				prompt:@"Reason for the copy?"
				URLs:[NSArray arrayWithObjects:pathFrom, pathTo, nil]
				action:@selector(copyURL:toURL:withDescription:)];
}



#if 0
#pragma mark -
#pragma mark SVN delegate
#endif

-(void) startSpinner
{
	[fGoButton setHidden:YES];
	[fSpinner setUsesThreadedAnimation:YES];
	[fSpinner setHidden:NO];
	[fSpinner startAnimation:self];
}

- (void) stopSpinner
{
	[fSpinner setHidden:YES];
	[fSpinner stopAnimation:self];	
	[fGoButton setHidden:NO];
}


- (void) reloadNode:(CXSVNRepoNode *)node
{
	if(node == fRootNode)
	{
		[fOutlineView reloadData];
	}
	else
	{
		[fOutlineView reloadItem:node reloadChildren:YES];
	}	
}

- (void) error:(NSString *)errorText usingSVNNode:(CXSVNRepoNode *)node
{
	// reload node when we're not busy
	[self performSelector:@selector(reloadNode:) withObject:node afterDelay:0.0];
//	[self reloadNode:node];
//	[self stopSpinner];
	NSRunAlertPanel(@"Problem accessing Subversion repository", errorText, @"OK", nil, nil);
}

- (void) willStartSVNNode:(CXSVNRepoNode *)node
{
	[self startSpinner];
}

- (void) statusLine:(NSString *)status forSVNNode:(CXSVNRepoNode *)node
{	
	// chomp(" \n\r")
	status = [status stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//	NSLog(@"%s %@", _cmd, status);

	[fStatusWindow showStatus:status onParent:[fOutlineView window]];
	
/*	[[[fOutlineView tableColumnWithIdentifier:@"1"] headerCell] setStringValue:status];
	[[fOutlineView headerView] setNeedsDisplay:YES];
*/}


- (void) didUpdateChildrenAtSVNNode:(CXSVNRepoNode *)node
{
	[self reloadNode:node];
}

- (void) didStopSVNNode:(CXSVNRepoNode *)node
{
	[self stopSpinner];
}


#if 0
#pragma mark -
#pragma mark Sheet Sheet
#endif

- (void) configureCommitSheetForOneURL
{
	// Verb may stretch out if there's no source URL

	NSSize					verbFieldSize = [fCommitVerbField frame].size;

	[fCommitURLSource setHidden:YES];
	
	[fCommitVerbField setFrameSize:NSMakeSize(verbFieldSize.width + [fCommitURLSource frame].size.width, verbFieldSize.height)];
	[fCommitVerbField setAlignment:NSLeftTextAlignment];
	
}

- (void) configureCommitSheetForTwoURLs
{
	[fCommitVerbField setFrameSize:NSMakeSize(71, [fCommitVerbField frame].size.height)];
	[fCommitVerbField setAlignment:NSRightTextAlignment];
	
	[fCommitURLSource setHidden:NO];
}

- (void) configureCommitSheetForMultipleURLs
{
	[NSException raise:@"NotImplemented" format:@"multiple URLs aren't supported yet"];
}

- (void) askForCommitWithVerb:(NSString *)verb prompt:(NSString *)prompt URLs:(NSArray *)URLs action:(SEL)selector 
{
	[self askForCommitWithVerb:verb prompt:prompt URLs:URLs action:selector options:kCXNone];
}


- (void) askForCommitWithVerb:(NSString *)verb prompt:(NSString *)prompt URLs:(NSArray *)URLs action:(SEL)selector options:(CXSVNCommitOptions)options
{
	NSMutableDictionary *	context  	= [[NSMutableDictionary alloc] init];
	NSValue *				value		= [NSValue value:&selector withObjCType:@encode(SEL)];
	unsigned int			URLCount	= [URLs count];
	
	[context setObject:value forKey:@"action"];
	[context setObject:URLs forKey:@"URLs"];
	[context setObject:[NSNumber numberWithUnsignedLong:(unsigned long)options] forKey:@"options"];
	
	[fCommitVerbField setStringValue:verb];
	[fCommitPromptField setStringValue:prompt];

	[fCommitURLSource setStringValue:[URLs objectAtIndex:0]];

	if( URLCount == 1 )
	{
		NSString *	suggestion = @"";
		
		if( (options & kCXAppendName) != 0 )
		{
			suggestion = @"Untitled Folder";
		}
		else if( (options & kCXReplaceName) != 0 )
		{
			// TODO get last component of URL
		}
		else
		{
			suggestion = [URLs objectAtIndex:0];
		}
		
		[fCommitURLDestination setStringValue:suggestion];
		[self configureCommitSheetForOneURL];
	}
	else if( URLCount == 2 )
	{	
		[fCommitURLDestination setStringValue:[URLs objectAtIndex:1]];
		[self configureCommitSheetForTwoURLs];
	}
	else
	{
		[self configureCommitSheetForMultipleURLs];
	}

	
	[NSApp	beginSheet:fCommitPromptWindow
			modalForWindow:[fOutlineView window]
			modalDelegate:self
			didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:)
			contextInfo:context];
}

- (void) performSelector:(SEL)selector withObject:(id)one withObject:(id)two withObject:(id)three
{
	(void)objc_msgSend(self, selector, one, two, three);
}

- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo
{
	NSDictionary *		contextDict = (NSDictionary *)contextInfo;
	
	if (returnCode == NSOKButton)
	{
		NSValue *			action		= [contextDict objectForKey:@"action"];
		NSArray *			URLs		= [contextDict objectForKey:@"URLs"];
		CXSVNCommitOptions	options		= [[contextDict objectForKey:@"options"] unsignedLongValue];
		SEL					selector;
		NSString *			description;
		unsigned int		countURLs;

		description = [fCommitAnswerField stringValue];
		
		[action getValue:&selector];
		
		countURLs = [URLs count];
		if( countURLs == 1 )
		{
			NSString *			firstURL = [URLs objectAtIndex:0];	// refresh the original URL
			CXSVNRepoNode *		firstNode;
			
			if( (options & kCXAppendName) == kCXAppendName )
			{
				[self performSelector:selector	withObject:[firstURL stringByAppendingString:[fCommitURLDestination stringValue]]
												withObject:description];
			}
			else
			{
				[self performSelector:selector	withObject:[fCommitURLDestination stringValue]
												withObject:description];
			}

			firstNode = [self visibleNodeForURL:firstURL];
			
			[firstNode invalidateChildren];
			[firstNode loadChildrenWithQueueKey:fRootNode];
		}
		else if( countURLs == 2 )
		{
			NSString *			firstURL	= [URLs objectAtIndex:0];
			NSString *			secondURL	= [fCommitURLDestination stringValue];
			CXSVNRepoNode *		firstNode;
			CXSVNRepoNode *		secondNode;
			
			[self performSelector:selector	withObject:firstURL
											withObject:secondURL
											withObject:description];
			
			// svn cp A B  -- copy A to B -- update B
			// svn mv A B  -- move A to B -- update [A parent] and B
			// svn rename A B -- rename A to B -- update [A parent] and [B parent], which should be the same object
			firstNode = [[self visibleNodeForURL:firstURL] parentNode];
			secondNode = [self visibleNodeForURL:secondURL];
			
			[firstNode invalidateChildren];
			[firstNode loadChildrenWithQueueKey:fRootNode];
			[secondNode invalidateChildren];
			[secondNode loadChildrenWithQueueKey:fRootNode];
		}
		else if( countURLs > 2 )
		{
			[self performSelector:selector	withObject:URLs
											withObject:description];
		}
	}
	else
	{
		// For debugging only. The user knows they canceled, we need not tell them.
//		[self statusLine:@"Canceled." forSVNNode:[contextDict objectForKey:@"node"]];
	}
	
	[contextDict release];
}

- (IBAction)sheetOK:(id)sender
{
	[NSApp endSheet:fCommitPromptWindow returnCode:NSOKButton];
	[fCommitPromptWindow orderOut:nil];
}

- (IBAction)sheetCancel:(id)sender
{
	[NSApp endSheet:fCommitPromptWindow returnCode:NSCancelButton];
	[fCommitPromptWindow orderOut:nil];
}



#if 0
#pragma mark Task core
#endif

// TODO: checkout, delete, export, add/import?

- (void) makeDirAtNode:(CXSVNRepoNode *)node
{
	[self askForCommitWithVerb:@"New Folder"
				prompt:@"Purpose of the new folder?"
				URLs:[NSArray arrayWithObject:[node URL]]
				action:@selector(makeDirAtURL:withDescription:)
				options:kCXAppendName];
}

- (void) copyURL:(NSString *)sourceURL toURL:(NSString *)destURL withDescription:(NSString *)desc
{
	// FIXME: copy more than one
	// FIXME: add description entry dialog
	NSArray *	arguments = [NSArray arrayWithObjects:@"copy", @"-m", desc, sourceURL, destURL, nil];

	[self willStartSVNNode:fRootNode];
	
	[CXSVNTask	launchWithArguments:arguments
				notifying:self
				outputAction:@selector(copyURLOutput:)
				queueKey:fRootNode];
}

- (void) makeDirAtURL:(NSString *)destURL withDescription:(NSString *)desc
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"mkdir", @"-m", desc, destURL, nil];

	[self willStartSVNNode:fRootNode];
	
	[CXSVNTask	launchWithArguments:arguments
				notifying:self
				outputAction:@selector(copyURLOutput:)
				queueKey:fRootNode];
}

- (void) moveURL:(NSString *)sourceURL toURL:(NSString *)destURL withDescription:(NSString *)desc
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"move", @"-m", desc, sourceURL, destURL, nil];

	[self willStartSVNNode:fRootNode];
	
	[CXSVNTask	launchWithArguments:arguments
				notifying:self
				outputAction:@selector(copyURLOutput:)
				queueKey:fRootNode];
}

- (void) error:(NSString *)string fromTask:(CXSVNTask *)task
{
	[self error:string usingSVNNode:nil];
}

- (void)copyURLOutput:(NSString *)output
{	
	if( output != nil )
	{
		NSLog( @"%@", output );
		
		[self statusLine:output forSVNNode:fRootNode];
	}
	else
	{
		[self didStopSVNNode:fRootNode];
	}
}

- (void)windowWillClose:(NSNotification *)notification
{
	[self release];
}

- (void) setDelegate:(id)delegate
{
	fDelegate = delegate;
}

- (id) delegate
{
	return fDelegate;
}

- (void) dealloc
{
	[fDelegate SVNRepoBrowserDidTerminate:self];
	
	[fStatusWindow release];
	[fRootNode release];
	[fRepoLocation release];
	
	[super dealloc];
}

@end

