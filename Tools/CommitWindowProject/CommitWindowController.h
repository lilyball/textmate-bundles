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
	IBOutlet NSTextField *			fRequestText;
	IBOutlet NSTextView *			fCommitMessage;
	IBOutlet NSWindow *				fWindow;
	IBOutlet NSButton *				fCancelButton;
	IBOutlet NSButton *				fOKButton;
}

- (IBAction) commit:(id) sender;
- (IBAction) cancel:(id) sender;

@end
