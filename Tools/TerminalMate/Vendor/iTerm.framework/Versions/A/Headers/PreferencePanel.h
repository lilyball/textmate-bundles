/*
 **  PreferencePanel.h
 **
 **  Copyright (c) 2002, 2003
 **
 **  Author: Fabian, Ujwal S. Setlur
 **
 **  Project: iTerm
 **
 **  Description: Implements the model and controller for the preference panel.
 **
 **  This program is free software; you can redistribute it and/or modify
 **  it under the terms of the GNU General Public License as published by
 **  the Free Software Foundation; either version 2 of the License, or
 **  (at your option) any later version.
 **
 **  This program is distributed in the hope that it will be useful,
 **  but WITHOUT ANY WARRANTY; without even the implied warranty of
 **  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 **  GNU General Public License for more details.
 **
 **  You should have received a copy of the GNU General Public License
 **  along with this program; if not, write to the Free Software
 **  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#import <Cocoa/Cocoa.h>

#define OPT_NORMAL 0
#define OPT_META   1
#define OPT_ESC    2

@class iTermController;
@class TreeNode;

@interface PreferencePanel : NSWindowController
{
	IBOutlet NSPopUpButton *windowStyle;
	IBOutlet NSPopUpButton *tabPosition;
    IBOutlet NSButton *selectionCopiesText;
	IBOutlet NSButton *middleButtonPastesFromClipboard;
    IBOutlet id hideTab;
    IBOutlet id promptOnClose;
    IBOutlet NSButton *focusFollowsMouse;
	IBOutlet NSTextField *wordChars;
	IBOutlet NSWindow *profilesWindow;
	IBOutlet NSButton *enableBonjour;
    IBOutlet NSButton *enableGrowl;
    IBOutlet NSButton *cmdSelection;
	IBOutlet NSButton *maxVertically;
	IBOutlet NSButton *useCompactLabel;
    IBOutlet NSSlider *refreshRate;
	
	// Bookmark stuff
	IBOutlet NSOutlineView *bookmarksView;
	IBOutlet NSPanel *addBookmarkFolderPanel;
	IBOutlet NSPanel *deleteBookmarkPanel;
	IBOutlet NSPanel *editBookmarkPanel;
	IBOutlet NSButton *bookmarkDeleteButton;
	IBOutlet NSButton *bookmarkEditButton;
	IBOutlet NSTextField *bookmarkFolderName;
	IBOutlet NSTextField *bookmarkName;
	IBOutlet NSTextField *bookmarkCommand;
	IBOutlet NSTextField *bookmarkWorkingDirectory;
	IBOutlet NSPopUpButton *bookmarkTerminalProfile;
	IBOutlet NSPopUpButton *bookmarkKeyboardProfile;
	IBOutlet NSPopUpButton *bookmarkDisplayProfile;
	IBOutlet NSPopUpButton *bookmarkShortcut;
	NSArray	 		*draggedNodes;
	IBOutlet NSButton *defaultSessionButton;

    
    NSUserDefaults *prefs;

	
	int defaultWindowStyle;
    BOOL defaultCopySelection;
	BOOL defaultPasteFromClipboard;
    BOOL defaultHideTab;
    int defaultTabViewType;
    BOOL defaultPromptOnClose;
    BOOL defaultFocusFollowsMouse;
	BOOL defaultEnableBonjour;
	BOOL defaultEnableGrowl;
	BOOL defaultCmdSelection;
	BOOL defaultMaxVertically;
    BOOL defaultUseCompactLabel;
    int  defaultRefreshRate;
	NSString *defaultWordChars;
}


+ (PreferencePanel*)sharedInstance;
- (id)initWithWindowNibName: (NSString *) windowNibName;

- (void) readPreferences;
- (void) savePreferences;

- (IBAction)ok:(id)sender;
- (IBAction)cancel:(id)sender;

- (void)run;

// Bookmark actions
- (IBAction) addBookmarkFolder: (id) sender;
- (IBAction) addBookmarkFolderConfirm: (id) sender;
- (IBAction) addBookmarkFolderCancel: (id) sender;
- (IBAction) deleteBookmarkFolder: (id) sender;
- (IBAction) deleteBookmarkConfirm: (id) sender;
- (IBAction) deleteBookmarkCancel: (id) sender;
- (IBAction) addBookmark: (id) sender;
- (IBAction) addBookmarkConfirm: (id) sender;
- (IBAction) addBookmarkCancel: (id) sender;
- (IBAction) deleteBookmark: (id) sender;
- (IBAction) editBookmark: (id) sender;
- (IBAction) setDefaultSession: (id) sender;

- (BOOL) copySelection;
- (void) setCopySelection: (BOOL) flag;
- (BOOL) pasteFromClipboard;
- (void) setPasteFromClipboard: (BOOL) flag;
- (BOOL) hideTab;
- (NSTabViewType) tabViewType;
- (int) windowStyle;
- (void) setTabViewType: (NSTabViewType) type;
- (BOOL) promptOnClose;
- (BOOL) focusFollowsMouse;
- (BOOL) enableBonjour;
- (BOOL) enableGrowl;
- (BOOL) cmdSelection;
- (BOOL) maxVertically;
- (BOOL) useCompactLabel;
- (int)  refreshRate;
- (NSString *) wordChars;

// Hidden preferences
- (BOOL) useUnevenTabs;
- (int) minTabWidth;
- (int) minCompactTabWidth;
- (int) optimumTabWidth;
- (float) strokeWidth;
- (float) boldStrokeWidth;

@end

@interface PreferencePanel (Private)

- (void)_addBookmarkFolderSheetDidEnd:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo;
- (void)_deleteBookmarkSheetDidEnd:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo;
- (void)_editBookmarkSheetDidEnd:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo;
- (void) _loadProfiles;
- (NSArray*) _draggedNodes;
- (NSArray *) _selectedNodes;
- (void)_performDropOperation:(id <NSDraggingInfo>)info onNode:(TreeNode*)parentNode atIndex:(int)childIndex;

@end