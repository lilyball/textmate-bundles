#ifndef _CXSVNRepoBrowser_H_
#define _CXSVNRepoBrowser_H_

@class CXSVNRepoNode;
@class CXTransientStatusWindow;

// TODO: wrap in NSWindowController

@interface CXSVNRepoBrowser : NSObject
{
				NSString *				fRepoLocation;
	IBOutlet	NSOutlineView *			fOutlineView;
	IBOutlet	NSProgressIndicator *	fSpinner;
	IBOutlet	NSTextField *			fURLField;
	IBOutlet	NSButton *				fGoButton;
				CXSVNRepoNode *			fRootNode;
		
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

- (NSString *)URL;

- (void)loadURL:(NSString *)URL;

- (CXSVNRepoNode *) nodeFromPath:(NSArray *)path;

- (IBAction) takeRootURLFrom:(id)sender;
- (IBAction) getRootURLFromField:(id)sender;

- (IBAction)close:(id)sender;

- (IBAction)sheetCancel:(id)sender;
- (IBAction)sheetOK:(id)sender;

- (void) askForCommitWithVerb:(NSString *)verb prompt:(NSString *)prompt source:(NSString *)sourceURL destination:(NSString *)destURL action:(SEL)selector context:(NSDictionary *)dictionary;

- (IBAction) contextRefresh:(id)sender;
- (IBAction) contextMakeDir:(id)sender;

- (void) makeDirAtNode:(CXSVNRepoNode *)node;
- (void) makeDirAtURL:(NSString *)destURL withDescription:(NSString *)desc;

- (void) syncNextBrowserWindowFrame:(CXSVNRepoBrowser *)browser;

@end

#endif /* _CXSVNRepoBrowser_H_ */
