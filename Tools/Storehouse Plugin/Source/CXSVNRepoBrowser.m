/*
   CXSVNRepoBrowser.m
   Storehouse
   
	TODO: retrieve and display all data (revision numbers, etc) from the svn list operation
	TODO: automagically process multiple items
	TODO: show the new item in the browser before committing,
			so the user knows exactly what's going to happen.
			Especially for mkdir.
	TODO: localization -- use strings file
	TODO: export by dragging out.

	FIXME: stop using pathComponent methods for URL processing -- they sometimes munge the slashes at the front.

   Created by Chris Thomas on 2006-11-13.
   Copyright 2006 Chris Thomas. All rights reserved.
*/

#import "CXSVNRepoBrowser.h"
#import "CXSVNRepoNode.h"
#import "CXTask.h"
//#include "CXTransientStatusWindow.h"
#import <Foundation/NSDebug.h>
#import "ImageAndTextCell.h"
#import "CXSVNClient.h"
#import "NSArray+CXMRU.h"

#define kHistorySize 15

const UInt16 kLeftQuoteUnicode	= 0x201C;
const UInt16 kRightQuoteUnicode	= 0x201D;

@interface CXToolbarItemView : NSView
@end

@implementation CXToolbarItemView
- (id)initWithCoder:(NSCoder *)coder
{
     return [super initWithCoder: coder];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
     [super encodeWithCoder: coder];
}
@end


#if !TMPLUGIN

@interface CXTestShimHackForNibLoading : NSObject
{
	NSMutableDictionary * 					_parameters;
}
@end

@implementation CXTestShimHackForNibLoading

- (id) init
{
	_parameters = [[NSMutableDictionary alloc] init];
	return [super init];
}

- (void)dealloc
{
	[_parameters release];
	[super dealloc];
}
@end

#endif

@interface CXSVNRepoBrowser (Private)
- (void)checkoutNode:(CXSVNRepoNode *)node toLocation:(NSString *)destinationPath;
- (void)exportNode:(CXSVNRepoNode *)node toLocation:(NSString *)destinationPath;
@end

@implementation CXSVNRepoBrowser

- (CXSVNClient *) svnClient
{
	if(fSVNClient == nil)
	{
		fSVNClient = [[CXSVNClient alloc] init];
		[fSVNClient setObserver:self];
	}
	
	return fSVNClient;
}

- (void) loadCommitPromptIfNeeded
{
	static NSNib *		sCommitWindowNib = nil;

	if(sCommitWindowNib == nil)
	{
		sCommitWindowNib = [[NSNib alloc] initWithNibNamed:@"CommitPrompt" bundle:[NSBundle bundleForClass:[self class]]];
	}
	
	[sCommitWindowNib instantiateNibWithOwner:self topLevelObjects:&fCommitWindowTopLevelObjects];
	[fCommitWindowTopLevelObjects retain];
}

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
		sBrowserNib = [[NSNib alloc] initWithNibNamed:@"Browser" bundle:[NSBundle bundleForClass:[self class]]];
	}
	
#if !TMPLUGIN
// Hack in a "parameters" binding so we can use the test app (without tm_dialog).
	CXTestShimHackForNibLoading *	hack = [[CXTestShimHackForNibLoading alloc] init];
	[sBrowserNib instantiateNibWithOwner:hack topLevelObjects:&array];
#else
	[sBrowserNib instantiateNibWithOwner:self topLevelObjects:&array];
#endif
			
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
	
		if(outBrowser != nil)
		{
			outBrowser->fBrowserWindowTopLevelObjects = [array retain];
			[[outBrowser->fOutlineView window] makeKeyAndOrderFront:self];
		}
	
		// Load the requested URL
		if(URL != nil)
		{
			[outBrowser loadURL:URL];
		}
	}
	
	
	return outBrowser;//[outBrowser autorelease];
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

#if 0
#pragma mark -
#pragma mark Toolbar Setup
#endif

- (void)setupToolbar
{
	NSToolbar *	toolbar = [[NSToolbar alloc] initWithIdentifier:@"URLToolbar"];
	[toolbar setDelegate:self];
	[toolbar setAllowsUserCustomization:NO];
	[toolbar setAutosavesConfiguration:NO];
	[toolbar setDisplayMode:NSToolbarDisplayModeIconOnly];
	[toolbar setSizeMode:NSToolbarSizeModeSmall];
	
	[[fOutlineView window] setToolbar:toolbar];
	[toolbar release];	
	
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar
{
    return [NSArray arrayWithObjects:@"CXURLHeader", nil];
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar
{
    return [NSArray arrayWithObjects:@"CXURLHeader", nil];
}

- (NSToolbarItem *) toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdent
  willBeInsertedIntoToolbar:(BOOL)willBeInserted
{
   NSToolbarItem *toolbarItem = [[[NSToolbarItem alloc] initWithItemIdentifier: itemIdent] autorelease];

	if ([itemIdent isEqual:@"CXURLHeader"])
	{
		NSRect	viewFrame = [fURLHeaderView frame];

		[toolbarItem setView:fURLHeaderView];

		[toolbarItem setMinSize:NSMakeSize(200, viewFrame.size.height)];
		[toolbarItem setMaxSize:NSMakeSize(viewFrame.size.width + 1000, viewFrame.size.height)];

		[toolbarItem setLabel: @"URL"];
		[toolbarItem setPaletteLabel: @"URL"];
		
	}
	
	return toolbarItem;
}

#if 0
#pragma mark -
#pragma mark UI
#endif

- (void) awakeFromNib
{
	ImageAndTextCell *	cell = [[[ImageAndTextCell alloc] init] autorelease];
//	NSZombieEnabled = 1;

	[cell setEditable:YES];
	//
	// Programmatic bindings for custom classes
	//
	
	// Bind the history menu to the "history" saved preference
	[fHistoryMenuButton bind:@"contentValues" toObject:fUserDefaultsController withKeyPath:@"values.history" options:nil];
	
	// Set font
	[cell setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSSmallControlSize]]];
	[[fOutlineView tableColumnWithIdentifier:@"1"] setDataCell:cell];

	[[fOutlineView window] setHidesOnDeactivate:NO];
	
	// TODO: accept URLs
	[fOutlineView registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, NSStringPboardType, nil]];

	[fOutlineView setDraggingSourceOperationMask:NSDragOperationCopy|NSDragOperationMove forLocal:NO];
	[fOutlineView setDraggingSourceOperationMask:NSDragOperationCopy|NSDragOperationMove forLocal:YES];
	
	[self setupToolbar];
	
	// Populate content
	if( ! [[fURLField stringValue] isEqualToString:@""] )
	{
		[self getRootURLFromField:nil];
	}
}

- (IBAction) getRootURLFromField:(id)sender
{
	[self takeRootURLFrom:fURLField];
}

- (IBAction) takeRootURLFrom:(id)sender
{
	NSString *	URL;
	
	if ([sender respondsToSelector:@selector(representedObject)])
	{
		// Menu item
	    URL = [sender representedObject];
	}
	else
	{
		// Anything not a menu item
		URL = [sender stringValue];
	}
	
	[self loadURL:URL];
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
		fRootNode = [[CXSVNRepoNode rootNodeWithURL:fRepoLocation SVNClient:[self svnClient]] retain];

//		[fRootNode setDelegate:self];
		[fOutlineView reloadData];
		
		NSArray *	pathComponents	= [URL pathComponents];
		NSString *	windowTitle1	= [pathComponents objectAtIndex:1];
		NSString *	windowTitle2	= [pathComponents lastObject];
		
		[[fURLField window] setTitle:[NSString stringWithFormat:@"svn %@ %@", windowTitle1, windowTitle2]];
		
		// Append the URL to the global history
		{
			NSUserDefaults *  	defaults		= [fUserDefaultsController defaults];
			NSArray *			oldHistory		= [defaults arrayForKey:@"history"];
			NSArray *			newHistory;
			if( oldHistory )
			{
				newHistory = [oldHistory arrayByAddingMostRecentlyUsedObject:URL andLimitingCapacityTo:kHistorySize];
			}
			else
			{
				newHistory = [NSArray arrayWithObject:URL];
			}

			// Write the history
			[defaults setObject:newHistory forKey:@"history"];
			[defaults synchronize];

		}
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
		currentNode = [self nextNodeFromPath:mutablePath inChildren:[currentNode subnodes]];
		
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


// TODO: item validation

- (IBAction) contextExportFiles:(id)sender
{
	CXSVNRepoNode *	node;
	node = [fOutlineView itemAtRow:[fOutlineView selectedRow]];
	
	[self exportNode:node toLocation:nil];
}

- (IBAction) contextCheckoutFiles:(id)sender
{
	CXSVNRepoNode *	node;
	node = [fOutlineView itemAtRow:[fOutlineView selectedRow]];
	
	[self checkoutNode:node toLocation:nil];
}

- (IBAction) contextRemoveFile:(id)sender
{
	CXSVNRepoNode *	node;
	node = [fOutlineView itemAtRow:[fOutlineView selectedRow]];
	
	[self askForCommitWithVerb:@"Remove"
			prompt:[NSString stringWithFormat:@"Remove %C%@%C from %C%@%C",
													kLeftQuoteUnicode,
													[node displayName],
													kRightQuoteUnicode,
													kLeftQuoteUnicode,
													[[node parentNode] displayName],
													kRightQuoteUnicode]
				URLs:[NSArray arrayWithObject:[node URL]]
				action:@selector(removeURL:withDescription:)];
}

- (IBAction) contextRefresh:(id)sender
{
	CXSVNRepoNode *	node;
	node = [fOutlineView itemAtRow:[fOutlineView selectedRow]];
	
	[node invalidateSubnodes];
	[node loadSubnodes];
}

- (IBAction) contextMakeDir:(id)sender
{
	CXSVNRepoNode *	node;
	node = [fOutlineView itemAtRow:[fOutlineView selectedRow]];
	
	if(node != nil)
	{
		if( [node isBranch] )
		{
			[self makeDirAtNode:node];
		}
		else
		{
			[self makeDirAtNode:[node parentNode]];
		}
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
	// NSWorkspace cannot (for various reasons) return the same NSImage
	// object instance each time, and it turns out that creating an
	// IconRef-based NSImage is relatively expensive.
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
	
	[item loadSubnodes];
	return [[item subnodes] objectAtIndex:index];
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
	
	[item loadSubnodes];
	return [[item subnodes] count];
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

// Move or copy in the repository
- (BOOL) receiveURLDragFromPasteboard:(NSPasteboard *)pboard atNode:(CXSVNRepoNode *)atNode dragOperation:(NSDragOperation)dragOperationMask
{
	NSString *		string = [pboard stringForType: NSStringPboardType];
	NSArray *		URLsToCopy;
	SEL				action = @selector(copyURLAction:);

	URLsToCopy = [string componentsSeparatedByString:@"\n"];

	if((dragOperationMask & NSDragOperationMove) == NSDragOperationMove)
	{
		action = @selector(moveURLAction:);
	}


	// get us out of the drag and drop loop
	[self performSelector:action
				withObject:[NSArray arrayWithObjects:[URLsToCopy objectAtIndex:0], [atNode URL], nil]
				afterDelay:0.0];
	return YES;
}

// Import into the repository
- (BOOL) receiveFilenameDragFromPasteboard:(NSPasteboard *)pboard atNode:(CXSVNRepoNode *)atNode dragOperation:(NSDragOperation)dragOperationMask
{
	NSArray *		filePaths = [pboard propertyListForType:NSFilenamesPboardType];
	SEL				action = @selector(importFilesAction:);

	// get us out of the drag and drop loop
	[self performSelector:action
				withObject:[NSArray arrayWithObjects:[atNode URL], filePaths, nil]
				afterDelay:0.0];
	return YES;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView acceptDrop:(id <NSDraggingInfo>)info item:(id)item childIndex:(int)index
{
	NSPasteboard * pboard = [info draggingPasteboard];
	BOOL			accepted = NO;
	
	if(item == nil)
	{
		item = fRootNode;
	}
	
	if ([pboard availableTypeFromArray:[NSArray arrayWithObject:NSStringPboardType]])
	{
		accepted = [self receiveURLDragFromPasteboard:pboard atNode:item dragOperation:[info draggingSourceOperationMask]];
	}
	else if ([pboard availableTypeFromArray:[NSArray arrayWithObject:NSFilenamesPboardType]])
	{
		accepted = [self receiveFilenameDragFromPasteboard:pboard atNode:item dragOperation:[info draggingSourceOperationMask]];
	}

	return accepted;
}

// Support renames
- (void)outlineView:(NSOutlineView *)outlineView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
	NSLog(@"%s", _cmd);
	if( item == nil )
	{
		[NSException raise:@"Root item renamed" format:@"Shouldn't be able to set the value of the root item"];
	}
	
	// Process makedir
	if( [item isKindOfClass:[CXSVNRepoPreviewNode class]] )
	{
		CXSVNRepoNode *	parentNode = [item parentNode];
//		NSLog(@"%s %@ full:%@", _cmd, [parentNode URL],  [[parentNode URL] stringByAppendingPathComponent:object]);
//		[parentNode removePreviewNode:item]; -- if we remove the item being set, does NSOutlineView fail?
		[self askForCommitWithVerb:@"New Folder"
					prompt:[NSString stringWithFormat:@"Create new folder %C%@%C", kLeftQuoteUnicode, object, kLeftQuoteUnicode]
					URLs:[NSArray arrayWithObject:[[parentNode URL] stringByAppendingFormat:@"/%@", object]]
					action:@selector(makeDirAtURL:withDescription:)];
	}
	else
	{
		NSString *	newURL;
		NSString *	oldURL;

		oldURL = [(CXSVNRepoNode *)item URL];
		newURL = [oldURL stringByDeletingLastPathComponent];
		newURL = [newURL stringByAppendingPathComponent:object];

		[self askForCommitWithVerb:@"Rename"
					prompt:[NSString stringWithFormat:@"Rename %C%@%C to %C%@%C",
															kLeftQuoteUnicode,
															[item displayName],
															kRightQuoteUnicode,
															kLeftQuoteUnicode,
															object,
															kRightQuoteUnicode]
					URLs:[NSArray arrayWithObjects:oldURL, newURL, nil]
					action:@selector(moveURL:toURL:withDescription:)];
	}
}

- (void) importFilesAction:(NSArray *)args
{
	NSString *				destPath			= [args objectAtIndex:0];
	NSArray *				filesToImport		= [args objectAtIndex:1];

	[self askForCommitWithVerb:@"Import"
			prompt:[NSString stringWithFormat:@"Import %C%@%C to %C%@%C",
											kLeftQuoteUnicode,
											[[filesToImport objectAtIndex:0] lastPathComponent],
											kRightQuoteUnicode,
											kLeftQuoteUnicode,
											[destPath lastPathComponent],
											kRightQuoteUnicode]
				URLs:[NSArray arrayWithObjects:[filesToImport objectAtIndex:0], destPath, nil]
				action:@selector(importLocalPath:toURL:withDescription:)];
}


- (void) moveURLAction:(NSArray *)args
{
	NSString *				pathFrom		= [args objectAtIndex:0];
	NSString *				pathTo			= [args objectAtIndex:1];

	[self askForCommitWithVerb:@"Move"
				prompt:[NSString stringWithFormat:@"Move %C%@%C to %C%@%C",
																	kLeftQuoteUnicode,
																	[pathFrom lastPathComponent],
				 													kRightQuoteUnicode,
																	kLeftQuoteUnicode,
																	[pathTo lastPathComponent],
				 													kRightQuoteUnicode]
				URLs:[NSArray arrayWithObjects:pathFrom, pathTo, nil]
				action:@selector(moveURL:toURL:withDescription:)];
}

- (void) copyURLAction:(NSArray *)args
{
	NSString *				pathFrom		= [args objectAtIndex:0];
	NSString *				pathTo			= [args objectAtIndex:1];

	[self askForCommitWithVerb:@"Copy"
				prompt:[NSString stringWithFormat:@"Copy %C%@%C to %C%@%C",
														kLeftQuoteUnicode,
														[pathFrom lastPathComponent],
														kRightQuoteUnicode,
														kLeftQuoteUnicode,
														[pathTo lastPathComponent],
														kRightQuoteUnicode]
				URLs:[NSArray arrayWithObjects:pathFrom, pathTo, nil]
				action:@selector(copyURL:toURL:withDescription:)];
}

#if 0
#pragma mark -
#pragma mark Export/Checkout
#endif

- (void)askWhereToSaveNodeLocally:(CXSVNRepoNode *)node forSelector:(SEL)selector
{
	NSSavePanel *			savePanel = [NSSavePanel savePanel];
	NSMutableDictionary *	dictionary = [NSMutableDictionary dictionary];
	
	[dictionary setObject:NSStringFromSelector(selector) forKey:@"selector"];
	[dictionary setObject:node forKey:@"node"];
	[dictionary retain];
	
	[savePanel beginSheetForDirectory:nil file:[[node URL] lastPathComponent] modalForWindow:[fURLHeaderView window] modalDelegate:self didEndSelector:@selector(savePanelDidEnd:returnCode:withInfo:) contextInfo:dictionary];
}

- (void)savePanelDidEnd:(NSSavePanel *)savePanel returnCode:(int)returnCode withInfo:(NSDictionary *)info
{
	NSString *		selectorString	= [info objectForKey:@"selector"];
	CXSVNRepoNode *	node			= [info objectForKey:@"node"];
	
	// we retained the info dictionary in askWhereToSaveNodeLocally:forSelector:
	[info autorelease];
	
	if(returnCode == NSOKButton)
	{
		CXSVNClient *		svnClient	= [self svnClient];
		
		NSLog(@"%@", selectorString);
		if([selectorString isEqualToString:@"exportNode:toLocation:"])
		{
			[svnClient exportURL:[node URL] toLocalPath:[savePanel filename]];
		}
		else if([selectorString isEqualToString:@"checkoutNode:toLocation:"])
		{
			[svnClient checkoutURL:[node URL] toLocalPath:[savePanel filename]];
		}
	}
}

- (void)exportNode:(CXSVNRepoNode *)node toLocation:(NSString *)destinationPath
{
	CXSVNClient *		svnClient	= [self svnClient];
	
	// Ask for location
	if(destinationPath == nil)
	{
		[self askWhereToSaveNodeLocally:node forSelector:_cmd];
	}
	else
	{
		[svnClient exportURL:[node URL] toLocalPath:destinationPath];
	}
}

- (void)checkoutNode:(CXSVNRepoNode *)node toLocation:(NSString *)destinationPath
{
	CXSVNClient *		svnClient	= [self svnClient];
	
	// Ask for location
	if(destinationPath == nil)
	{
		[self askWhereToSaveNodeLocally:node forSelector:_cmd];
	}
	else
	{
		[svnClient checkoutURL:[node URL] toLocalPath:destinationPath];
	}
}


#if 0
#pragma mark -
#pragma mark SVN delegate
#endif

- (void) startSpinner
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
	NSRunAlertPanel(@"Problem accessing Subversion repository", @"%@", @"OK", nil, nil, errorText);
}

- (void) statusLine:(NSString *)status forSVNNode:(CXSVNRepoNode *)node
{	
	// chomp(" \n\r")
	status = [status stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//	NSLog(@"%s %@", _cmd, status);

// TODO: report status
	if(status != nil)
	{
		[[[fOutlineView tableColumnWithIdentifier:@"1"] headerCell] setStringValue:status];
		[[fOutlineView headerView] setNeedsDisplay:YES];
	}
}


#if 0
#pragma mark -
#pragma mark Sheet Sheet
#endif

- (void) configureCommitSheetForMultipleURLs
{
	[NSException raise:@"NotImplemented" format:@"multiple URLs aren't supported yet"];
}

- (void) askForCommitWithVerb:(NSString *)verb prompt:(NSString *)prompt URLs:(NSArray *)URLs action:(SEL)selector
{
	NSMutableDictionary *	context  	= [[NSMutableDictionary alloc] init];
	NSValue *				value		= [NSValue value:&selector withObjCType:@encode(SEL)];
	unsigned int			URLCount	= [URLs count];
	
	[self loadCommitPromptIfNeeded];
	
	[context setObject:value forKey:@"action"];
	[context setObject:URLs forKey:@"URLs"];
	
	[fCommitPromptField setStringValue:prompt];

	if( URLCount == 1 )
	{
//		[fCommitURLDestination setStringValue:suggestion];
//		[self configureCommitSheetForOneURL];
	}
	else if( URLCount == 2 )
	{	
//		[fCommitURLDestination setStringValue:[URLs objectAtIndex:1]];
//		[self configureCommitSheetForTwoURLs];
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
	NSMutableDictionary *		contextDict = (NSMutableDictionary *)contextInfo;
	
	if (returnCode == NSOKButton)
	{
		NSValue *			action		= [contextDict objectForKey:@"action"];
		NSArray *			URLs		= [contextDict objectForKey:@"URLs"];
		SEL					selector;
		NSString *			description;
		NSMutableArray *	nodes		= [NSMutableArray array];
		unsigned int		countURLs;
		CXSVNClient *		svnClient	= [self svnClient];

		description = [fCommitAnswerField stringValue];
		
		[action getValue:&selector];
		
		// Setup for refresh (nodes will be added below)
		[contextDict setObject:nodes forKey:@"refreshNodes"];
		[svnClient setUserInfo:contextInfo];
		
		countURLs = [URLs count];
		if( countURLs == 1 )
		{
			NSString *			firstURL = [URLs objectAtIndex:0];	// refresh the original URL
			CXSVNRepoNode *		firstNode;

			firstNode = [self visibleNodeForURL:firstURL];
			if(firstNode != nil)
			{
				[nodes addObject:firstNode];
			}
			[svnClient performSelector:selector	withObject:firstURL
													withObject:description];

		}
		else if( countURLs == 2 )
		{
			NSString *			firstURL	= [URLs objectAtIndex:0];
			NSString *			secondURL	= [URLs objectAtIndex:1];
			CXSVNRepoNode *		firstNode;
			CXSVNRepoNode *		secondNode;

			// svn cp A B  -- copy A to B -- update B
			// svn mv A B  -- move A to B -- update [A parent] and B
			// svn rename A B -- rename A to B -- update [A parent] and [B parent], which should be the same object
			firstNode = [[self visibleNodeForURL:firstURL] parentNode];
			secondNode = [self visibleNodeForURL:secondURL];

			if(firstNode != nil)
			{
				[nodes addObject:firstNode];
			}
			if(secondNode != nil)
			{
				[nodes addObject:secondNode];
			}
			
			objc_msgSend(svnClient, selector, firstURL, secondURL, description);
		}
		else if( countURLs > 2 )
		{
			[self performSelector:selector	withObject:URLs
											withObject:description];
			// TODO: which nodes to refresh?
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
#pragma mark -
#pragma mark Task core
#endif

- (void) makeDirAtNode:(CXSVNRepoNode *)node
{
	// Visualize the new node and let the user edit the name
	CXSVNRepoPreviewNode *	newDirNode = (CXSVNRepoPreviewNode *)[CXSVNRepoPreviewNode nodeWithName:@"untitled folder" parent:node];
	int						itemRow;
	
	[node addPreviewSubnode:newDirNode];
	[self reloadNode:node];
	
	itemRow = [fOutlineView rowForItem:newDirNode];
	[fOutlineView selectRow:itemRow byExtendingSelection:NO];
	[fOutlineView editColumn:0 row:itemRow withEvent:nil select:NO];
}

- (void) startingTask
{
	fRunningTaskCount += 1;
	if( fRunningTaskCount == 1 )
	{
		[self startSpinner];
	}
}

- (void) exitedSVNWithStatus:(int)terminationStatus userInfo:(id)userInfo
{
	fRunningTaskCount -= 1;
	if( fRunningTaskCount == 0 )
	{
		[self stopSpinner];
	}

	if( terminationStatus == 0 )
	{
		NSArray *	refreshNodes = [userInfo valueForKey:@"refreshNodes"];

		if(refreshNodes != nil)
		{
			unsigned int	nodeCount = [refreshNodes count];

			for(unsigned int index = 0; index < nodeCount; index += 1)
			{
				CXSVNRepoNode *	node = [refreshNodes objectAtIndex:index];

				[node invalidateSubnodes];
				[node loadSubnodes];
			}
		}
	}
}

- (void) readSVNOutput:(NSString *)output
{
	[self statusLine:output forSVNNode:fRootNode];
}

- (void) readSVNError:(NSString *)string
{
	[self error:string usingSVNNode:nil];
}

- (void) contentsOfSVNURLDidChange:(NSString *)url
{
	CXSVNRepoNode *	node = [self visibleNodeForURL:url];
	if(node != nil)
	{
		[self reloadNode:node];
	}
}

#if 0
#pragma mark -
#pragma mark Delegate accessor
#endif

- (void) setDelegate:(id)delegate
{
	fDelegate = delegate;
}

- (id) delegate
{
	return fDelegate;
}

#if 0
#pragma mark -
#pragma mark Destruction
#endif

- (void)windowWillClose:(NSNotification *)notification
{
	[self closeBrowser];
}

- (void) closeBrowser
{
	NSWindow *	window = [fOutlineView window];
	//
	// SVNRepoBrowserWillClose notification may release us, so keep us alive
	// long enough to safely order out the window.
	//
	[self retain];

	[fDelegate SVNRepoBrowserWillClose:self];

	[window orderOut:nil];

#if !TMPLUGIN
	// Release top-level objects
	[fCommitWindowTopLevelObjects makeObjectsPerformSelector:@selector(release)];
	[fCommitWindowTopLevelObjects release];
	[fBrowserWindowTopLevelObjects makeObjectsPerformSelector:@selector(release)];
	[fBrowserWindowTopLevelObjects release];
#endif

	[fSVNClient setObserver:nil];

	[self autorelease];
}

- (void) dealloc
{
	[fRootNode release];
	[fRepoLocation release];
	[fSVNClient release];
	
	[super dealloc];
}

@end

