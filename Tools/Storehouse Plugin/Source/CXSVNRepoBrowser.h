#ifndef _CXSVNRepoBrowser_H_
#define _CXSVNRepoBrowser_H_

@class CXSVNRepoNode;
@class CXSVNClient;
@class CXMenuButton;

// TODO: wrap in NSWindowController

typedef enum
{
	kCXNone			= 0,
	kCXAppendName	= (1UL << 0),
	kCXReplaceName	= (1UL << 1)
} CXSVNCommitOptions;


@interface CXSVNRepoBrowser : NSObject
{
				NSArray *				fCommitWindowTopLevelObjects;
				NSArray *				fBrowserWindowTopLevelObjects;
				NSString *				fRepoLocation;
				CXSVNRepoNode *			fRootNode;
				CXSVNClient *			fSVNClient;
				id 						fDelegate;
				int						fRunningTaskCount;

	IBOutlet	NSOutlineView *			fOutlineView;
	IBOutlet	NSView *				fURLHeaderView;
	IBOutlet	NSProgressIndicator *	fSpinner;
	IBOutlet	NSTextField *			fURLField;
	IBOutlet	NSButton *				fGoButton;
	IBOutlet 	CXMenuButton *			fHistoryMenuButton;
	
//				NSTableHeaderCell *		fTableHeaderCell;
	IBOutlet	NSTextField *			fCommitPromptField;
	IBOutlet	NSTextField *			fCommitAnswerField;
	IBOutlet	NSPanel *				fCommitPromptWindow;

	IBOutlet	NSUserDefaultsController *	fUserDefaultsController;
	
	// bindings
				NSArray *				history;
}

+ (CXSVNRepoBrowser *) browser;
+ (CXSVNRepoBrowser *) browserAtURL:(NSString *)URL;	// may be nil

- (void) closeBrowser;


- (void) setDelegate:(id)delegate;
- (id) delegate;

- (NSString *)URL;

- (void)loadURL:(NSString *)URL;

- (CXSVNRepoNode *) nodeFromPath:(NSArray *)path;

- (IBAction) takeRootURLFrom:(id)sender;
- (IBAction) getRootURLFromField:(id)sender;

- (IBAction)sheetCancel:(id)sender;
- (IBAction)sheetOK:(id)sender;

- (void) askForCommitWithVerb:(NSString *)verb prompt:(NSString *)prompt URLs:(NSArray *)URLs action:(SEL)selector;

- (IBAction) contextRemoveFile:(id)sender;
- (IBAction) contextExportFiles:(id)sender;
- (IBAction) contextCheckoutFiles:(id)sender;
- (IBAction) contextRefresh:(id)sender;
- (IBAction) contextMakeDir:(id)sender;

- (void) makeDirAtNode:(CXSVNRepoNode *)node;

- (void) syncNextBrowserWindowFrame:(CXSVNRepoBrowser *)browser;

@end

@interface NSObject(CXSVNRepoBrowserDelegate)
- (void) SVNRepoBrowserWillClose:(CXSVNRepoBrowser *)browser;
@end

#endif /* _CXSVNRepoBrowser_H_ */
