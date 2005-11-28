#ifndef _CXSVNRepoBrowser_H_
#define _CXSVNRepoBrowser_H_

@class CXSVNRepoNode;
@class CXTransientStatusWindow;

// TODO: wrap in NSWindowController

typedef enum
{
	kCXNone			= 0,
	kCXAppendName	= (1UL << 0),
	kCXReplaceName	= (1UL << 1)
} CXSVNCommitOptions;


@interface CXSVNRepoBrowser : NSObject
{
				NSString *				fRepoLocation;
				CXSVNRepoNode *			fRootNode;
				id 						fDelegate;

	IBOutlet	NSOutlineView *			fOutlineView;
	IBOutlet	NSProgressIndicator *	fSpinner;
	IBOutlet	NSTextField *			fURLField;
	IBOutlet	NSButton *				fGoButton;
		
	IBOutlet	NSTextField *			fCommitVerbField;
	IBOutlet	NSTextField *			fCommitPromptField;
	IBOutlet	NSTextField *			fCommitAnswerField;
	IBOutlet	NSPanel *				fCommitPromptWindow;
	IBOutlet	NSTextField *			fCommitURLDestination;
	IBOutlet	NSTextField *			fCommitURLSource;
	
	CXTransientStatusWindow *			fStatusWindow;
	
}

+ (CXSVNRepoBrowser *) browser;
+ (CXSVNRepoBrowser *) browserAtURL:(NSString *)URL;	// may be nil

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
- (void) askForCommitWithVerb:(NSString *)verb prompt:(NSString *)prompt URLs:(NSArray *)URLs action:(SEL)selector options:(CXSVNCommitOptions)options;


- (IBAction) contextRefresh:(id)sender;
- (IBAction) contextMakeDir:(id)sender;

- (void) makeDirAtNode:(CXSVNRepoNode *)node;
- (void) makeDirAtURL:(NSString *)destURL withDescription:(NSString *)desc;

- (void) syncNextBrowserWindowFrame:(CXSVNRepoBrowser *)browser;

@end

@interface NSObject(CXSVNRepoBrowserDelegate)
- (void) SVNRepoBrowserDidTerminate:(CXSVNRepoBrowser *)browser;
@end

#endif /* _CXSVNRepoBrowser_H_ */
