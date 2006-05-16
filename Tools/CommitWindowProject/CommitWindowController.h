//
//  CommitWindowController.h
//
//  Created by Chris Thomas on 2/6/05.
//  Copyright 2005 Chris Thomas. All rights reserved.
//	MIT license.
//

#import <Cocoa/Cocoa.h>


@interface CommitWindowController : NSWindowController
{
//	NSMutableArray *	fFiles;		// {@"commit", @"path"}
	IBOutlet NSArrayController *	fFilesController;

	IBOutlet NSWindow *				fWindow;

	IBOutlet NSTextField *			fRequestText;
	IBOutlet NSTextView *			fCommitMessage;
	IBOutlet NSPopUpButton *		fPreviousSummaryPopUp;

	IBOutlet NSButton *				fCancelButton;
	IBOutlet NSButton *				fOKButton;

	IBOutlet NSTableView *			fTableView;
	IBOutlet NSTableColumn *		fCheckBoxColumn;
	IBOutlet NSTableColumn *		fStatusColumn;
	IBOutlet NSTableColumn *		fPathColumn;

	NSString *						fDiffCommand;
	
	NSArray *						fFileStatusStrings;
}

- (IBAction) commit:(id) sender;
- (IBAction) cancel:(id) sender;

@end
