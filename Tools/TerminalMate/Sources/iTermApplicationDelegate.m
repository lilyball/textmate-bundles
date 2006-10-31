// -*- mode:objc -*-
// $Id: iTermApplicationDelegate.m,v 1.33 2006/09/22 23:21:07 yfabian Exp $
/*
 **  iTermApplicationDelegate.m
 **
 **  Copyright (c) 2002, 2003
 **
 **  Author: Fabian, Ujwal S. Setlur
 **	     Initial code by Kiichi Kusama
 **
 **  Project: iTerm
 **
 **  Description: Implements the main application delegate and handles the addressbook functions.
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

#import "iTermApplicationDelegate.h"
#import <iTerm/iTermController.h>
#import <iTerm/ITAddressBookMgr.h>
#import <iTerm/PreferencePanel.h>
#import <iTerm/PseudoTerminal.h>
#import <iTerm/PTYSession.h>
#import <iTerm/VT100Terminal.h>
#import <iTerm/FindPanelWindowController.h>
#import <iTerm/PTYWindow.h>


static NSString *SCRIPT_DIRECTORY = @"~/Library/Application Support/iTerm/Scripts";
static NSString* AUTO_LAUNCH_SCRIPT = @"~/Library/Application Support/iTerm/AutoLaunch.scpt";

static BOOL usingAutoLaunchScript = NO;


@implementation iTermApplicationDelegate

// NSApplication delegate methods
- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
    // Check the system version for minimum requirements.
    SInt32 gSystemVersion;    
    Gestalt(gestaltSystemVersion, &gSystemVersion);
    if(gSystemVersion < 0x1020)
    {
	NSRunAlertPanel(NSLocalizedStringFromTableInBundle(@"Sorry",@"iTerm", [NSBundle bundleForClass: [iTermController class]], @"Sorry"),
		 NSLocalizedStringFromTableInBundle(@"Minimum_OS", @"iTerm", [NSBundle bundleForClass: [iTermController class]], @"OS Version"),
		NSLocalizedStringFromTableInBundle(@"Quit",@"iTerm", [NSBundle bundleForClass: [iTermController class]], @"Quit"),
		 nil, nil);
	[NSApp terminate: self];
    }

    // set the TERM_PROGRAM environment variable
    putenv("TERM_PROGRAM=iTerm.app");


    // add our script menu to the menu bar
    // get image
    NSImage *scriptIcon = [NSImage imageNamed: @"script"];
    [scriptIcon setScalesWhenResized: YES];
    [scriptIcon setSize: NSMakeSize(16, 16)];

    // create menu item with no title and set image
    NSMenuItem *scriptMenuItem = [[NSMenuItem alloc] initWithTitle: @"" action: nil keyEquivalent: @""];
    [scriptMenuItem setImage: scriptIcon];

    // create submenu
    NSMenu *scriptMenu = [[NSMenu alloc] initWithTitle: NSLocalizedStringFromTableInBundle(@"Script",@"iTerm", [NSBundle bundleForClass: [iTermController class]], @"Script")];
    [scriptMenuItem setSubmenu: scriptMenu];
    // populate the submenu with ascripts found in the script directory
    NSDirectoryEnumerator *directoryEnumerator = [[NSFileManager defaultManager] enumeratorAtPath: [SCRIPT_DIRECTORY stringByExpandingTildeInPath]];
    NSString *file;
    while ((file = [directoryEnumerator nextObject]))
    {
		NSMenuItem *scriptItem = [[NSMenuItem alloc] initWithTitle: file action: @selector(launchScript:) keyEquivalent: @""];
		[scriptItem setTarget: [iTermController sharedInstance]];
		[scriptMenu addItem: scriptItem];
		[scriptItem release];
    }
    [scriptMenu release];

    // add new menu item
    [[NSApp mainMenu] insertItem: scriptMenuItem atIndex: 4];
    [scriptMenuItem release];
    [scriptMenuItem setTitle: NSLocalizedStringFromTableInBundle(@"Script",@"iTerm", [NSBundle bundleForClass: [iTermController class]], @"Script")];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self buildAddressBookMenu:nil];
	
	// register for services
	[NSApp registerServicesMenuSendTypes: [NSArray arrayWithObjects: NSStringPboardType, nil]
							 returnTypes: [NSArray arrayWithObjects: NSFilenamesPboardType, NSStringPboardType, nil]];
	
}

- (BOOL) applicationShouldTerminate: (NSNotification *) theNotification
{
	NSArray *terminals;
	
	// Display prompt if we need to
	terminals = [[iTermController sharedInstance] terminals];
    if(([terminals count] > 0) && 
	   [[PreferencePanel sharedInstance] promptOnClose] && 
	   ![[terminals objectAtIndex: 0] showCloseWindow])
		return (NO);
    
	// save preferences
	[[PreferencePanel sharedInstance] savePreferences];
	
    return (YES);
}

- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename
{
	//NSLog(@"%s: %@", __PRETTY_FUNCTION__, filename);
	
	// open a new default session in the front terminal
	[self newSession: self];
	
	// launch the command
	NSData *data = nil;
    NSString *aString = nil;
	PseudoTerminal *theTerminal = [[iTermController sharedInstance] currentTerminal];
	PTYSession *theSession = [theTerminal currentSession];
	if(filename != nil)
    {
		aString = [NSString stringWithFormat:@"%@\n", filename];
		data = [aString dataUsingEncoding: [[theSession TERMINAL] encoding]];
		[theSession writeTask: data];
    }
	
	
	return (YES);
}

- (BOOL)applicationOpenUntitledFile:(NSApplication *)app
{
    // Check if we have an autolauch script to execute. Do it only once, i.e. at application launch.
    if(usingAutoLaunchScript == NO &&
       [[NSFileManager defaultManager] fileExistsAtPath: [AUTO_LAUNCH_SCRIPT stringByExpandingTildeInPath]] != nil)
    {
		usingAutoLaunchScript = YES;
		
		NSAppleScript *autoLaunchScript;
		NSDictionary *errorInfo = [NSDictionary dictionary];
		NSURL *aURL = [NSURL fileURLWithPath: [AUTO_LAUNCH_SCRIPT stringByExpandingTildeInPath]];
		
		// Make sure our script suite registry is loaded
		[NSScriptSuiteRegistry sharedScriptSuiteRegistry];
		
		autoLaunchScript = [[NSAppleScript alloc] initWithContentsOfURL: aURL error: &errorInfo];
		[autoLaunchScript executeAndReturnError: &errorInfo];
		[autoLaunchScript release];
		
		return (YES);
    }
	
	[self newWindow:nil];
    
    return YES;
}

// sent when application is made visible after a hide operation. Should not really need to implement this,
// but some users reported that keyboard input is blocked after a hide/unhide operation.
- (void)applicationDidUnhide:(NSNotification *)aNotification
{
	PseudoTerminal *frontTerminal = [[iTermController sharedInstance] currentTerminal];
    // Make sure that the first responder stuff is set up OK.
    [frontTerminal selectSessionAtIndex: [frontTerminal currentSessionIndex]];
}

// init
- (id)init
{
    self = [super init];

    // Add ourselves as an observer for notifications.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadMenus:)
                                                 name:@"iTermWindowBecameKey"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(buildAddressBookMenu:)
                                                 name: @"iTermReloadAddressBook"
                                               object: nil];

    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(buildSessionSubmenu:)
                                                 name: @"iTermNumberOfSessionsDidChange"
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(buildSessionSubmenu:)
                                                 name: @"iTermNameOfSessionDidChange"
                                               object: nil];

    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(reloadSessionMenus:)
                                                 name: @"iTermSessionDidBecomeActive"
                                               object: nil];    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(nonTerminalWindowBecameKey:)
                                                 name:@"nonTerminalWindowBecameKey"
                                               object:nil];    

    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [super dealloc];
}

// Action methods
- (IBAction)newWindow:(id)sender
{
    [[iTermController sharedInstance] newWindow:sender];
}

- (IBAction)newSession:(id)sender
{
    [[iTermController sharedInstance] newSession:sender];
}

// navigation
- (IBAction) previousTerminal: (id) sender
{
    [[iTermController sharedInstance] previousTerminal:sender];
}

- (IBAction) nextTerminal: (id) sender
{
    [[iTermController sharedInstance] nextTerminal:sender];
}

- (IBAction)showPrefWindow:(id)sender
{
    [[PreferencePanel sharedInstance] run];
}

- (NSMenu *)applicationDockMenu:(NSApplication *)sender
{
    NSMenu *aMenu, *abMenu;
    NSMenuItem *newTabMenuItem, *newWindowMenuItem;
	PseudoTerminal *frontTerminal;
    
    aMenu = [[NSMenu alloc] initWithTitle: @"Dock Menu"];
    newTabMenuItem = [[NSMenuItem alloc] initWithTitle: NSLocalizedStringFromTableInBundle(@"New Tab",@"iTerm", [NSBundle bundleForClass: [self class]], @"Context menu") action:nil keyEquivalent:@"" ]; 
    newWindowMenuItem = [[NSMenuItem alloc] initWithTitle: NSLocalizedStringFromTableInBundle(@"New Window",@"iTerm", [NSBundle bundleForClass: [self class]], @"Context menu") action:nil keyEquivalent:@"" ]; 
    [aMenu addItem: newTabMenuItem];
    [aMenu addItem: newWindowMenuItem];
    [newTabMenuItem release];
    [newWindowMenuItem release];
    
    // Create the addressbook submenus for new tabs and windows.
	frontTerminal = [[iTermController sharedInstance] currentTerminal];
    abMenu = [[iTermController sharedInstance] buildAddressBookMenuWithTarget: frontTerminal withShortcuts: NO]; // target the top terminal window.
    [newTabMenuItem setSubmenu: abMenu];
    
    abMenu = [[iTermController sharedInstance] buildAddressBookMenuWithTarget: nil withShortcuts: NO];
    [newWindowMenuItem setSubmenu: abMenu];
	
    return ([aMenu autorelease]);
}

// font control
- (IBAction) biggerFont: (id) sender
{
    [[[iTermController sharedInstance] currentTerminal] changeFontSize: YES];
}

- (IBAction) smallerFont: (id) sender
{
    [[[iTermController sharedInstance] currentTerminal] changeFontSize: NO];
}

// transparency
- (IBAction) useTransparency: (id) sender
{
  BOOL b = [[[[iTermController sharedInstance] currentTerminal] currentSession] useTransparency];
  [[[[iTermController sharedInstance] currentTerminal] currentSession] setUseTransparency: !b];
}


/// About window

- (IBAction)showAbout:(id)sender
{
    NSURL *author1URL, *author2URL, *webURL, *bugURL;
    NSAttributedString *author1, *author2, *webSite, *bugReport;
    NSMutableAttributedString *tmpAttrString;
    NSDictionary *linkAttributes;
//    [NSApp orderFrontStandardAboutPanel:nil];

    // First Author
    author1URL = [NSURL URLWithString: @"mailto:yfabian@gmail.com"];
    linkAttributes= [NSDictionary dictionaryWithObjectsAndKeys: author1URL, NSLinkAttributeName,
                        [NSNumber numberWithInt: NSSingleUnderlineStyle], NSUnderlineStyleAttributeName,
					    [NSColor blueColor], NSForegroundColorAttributeName,
					    NULL];
    author1 = [[NSAttributedString alloc] initWithString: NSLocalizedStringFromTableInBundle(@"fabian",@"iTerm", [NSBundle bundleForClass: [self class]], @"Author") attributes: linkAttributes];
    
    // Spacer...
    tmpAttrString = [[NSMutableAttributedString alloc] initWithString: @", "];
    
    // Second Author
    author2URL = [NSURL URLWithString: @"mailto:ujwal@setlurgroup.com"];
    linkAttributes= [NSDictionary dictionaryWithObjectsAndKeys: author2URL, NSLinkAttributeName,
                        [NSNumber numberWithInt: NSSingleUnderlineStyle], NSUnderlineStyleAttributeName,
					    [NSColor blueColor], NSForegroundColorAttributeName,
					    NULL];
    author2 = [[NSAttributedString alloc] initWithString: NSLocalizedStringFromTableInBundle(@"Ujwal S. Setlur",@"iTerm", [NSBundle bundleForClass: [self class]], @"Author") attributes: linkAttributes];
    
    // Web URL
    webURL = [NSURL URLWithString: @"http://iterm.sourceforge.net"];
    linkAttributes= [NSDictionary dictionaryWithObjectsAndKeys: webURL, NSLinkAttributeName,
                        [NSNumber numberWithInt: NSSingleUnderlineStyle], NSUnderlineStyleAttributeName,
					    [NSColor blueColor], NSForegroundColorAttributeName,
					    NULL];
    webSite = [[NSAttributedString alloc] initWithString: @"http://iterm.sourceforge.net" attributes: linkAttributes];

    // Bug report
    bugURL = [NSURL URLWithString: @"https://sourceforge.net/tracker/?func=add&group_id=67789&atid=518973"];
    linkAttributes= [NSDictionary dictionaryWithObjectsAndKeys: webURL, NSLinkAttributeName,
        [NSNumber numberWithInt: NSSingleUnderlineStyle], NSUnderlineStyleAttributeName,
        [NSColor blueColor], NSForegroundColorAttributeName,
        NULL];
    bugReport = [[NSAttributedString alloc] initWithString: NSLocalizedStringFromTableInBundle(@"Report A Bug", @"iTerm", [NSBundle bundleForClass: [self class]], @"About") attributes: linkAttributes];

    // version number and mode
    NSDictionary *myDict = [[NSBundle bundleForClass:[self class]] infoDictionary];
    NSMutableString *versionString = [[NSMutableString alloc] initWithString: (NSString *)[myDict objectForKey:@"CFBundleVersion"]];
    
    [[AUTHORS textStorage] deleteCharactersInRange: NSMakeRange(0, [[AUTHORS textStorage] length])];
    [tmpAttrString initWithString: versionString];
    [[AUTHORS textStorage] appendAttributedString: tmpAttrString];
    [tmpAttrString initWithString: @"\n\n"];
    [[AUTHORS textStorage] appendAttributedString: tmpAttrString];
    [[AUTHORS textStorage] appendAttributedString: author1];
    tmpAttrString = [[NSMutableAttributedString alloc] initWithString: @", "];
    [[AUTHORS textStorage] appendAttributedString: tmpAttrString];
    [[AUTHORS textStorage] appendAttributedString: author2];
    [tmpAttrString initWithString: @"\n"];
    [[AUTHORS textStorage] appendAttributedString: tmpAttrString];
    [[AUTHORS textStorage] appendAttributedString: webSite];
    [[AUTHORS textStorage] appendAttributedString: tmpAttrString];
    [[AUTHORS textStorage] appendAttributedString: bugReport];
    [AUTHORS setAlignment: NSCenterTextAlignment range: NSMakeRange(0, [[AUTHORS textStorage] length])];

    
    [NSApp runModalForWindow:ABOUT];
    [ABOUT close];
    [author1 release];
    [author2 release];
    [webSite release];
    [tmpAttrString release];
    [versionString release];
}

- (IBAction)aboutOK:(id)sender
{
    [NSApp stopModal];
}

// Notifications
- (void) reloadMenus: (NSNotification *) aNotification
{
    PseudoTerminal *frontTerminal = [[iTermController sharedInstance] currentTerminal];
	unsigned int drawerState;
    
    [previousTerminal setAction: (frontTerminal?@selector(previousTerminal:):nil)];
    [nextTerminal setAction: (frontTerminal?@selector(nextTerminal:):nil)];

    [self buildSessionSubmenu: aNotification];
    [self buildAddressBookMenu: aNotification];
    
    // reset the close tab/window shortcuts
    [closeTab setAction: @selector(closeCurrentSession:)];
    [closeTab setTarget: frontTerminal];
    [closeTab setKeyEquivalent: @"w"];
    [closeWindow setKeyEquivalent: @"W"];
    [closeWindow setKeyEquivalentModifierMask: NSCommandKeyMask];
    
    // set some menu item states
    if([frontTerminal sendInputToAllSessions] == YES)
	[sendInputToAllSessions setState: NSOnState];
    else
	[sendInputToAllSessions setState: NSOffState];

	if([frontTerminal fontSizeFollowWindowResize] == YES)
		[fontSizeFollowWindowResize setState: NSOnState];
    else
		[fontSizeFollowWindowResize setState: NSOffState];
	
	// reword some menu items
 	drawerState = [[(PTYWindow *)[frontTerminal window] drawer] state];
	if(drawerState == NSDrawerClosedState || drawerState == NSDrawerClosingState)
	{
		[toggleBookmarksView setTitle: 
			NSLocalizedStringFromTableInBundle(@"Show Bookmarks", @"iTerm", [NSBundle bundleForClass: [self class]], @"Bookmarks")];
	}
	else
	{
		[toggleBookmarksView setTitle: 
			NSLocalizedStringFromTableInBundle(@"Hide Bookmarks", @"iTerm", [NSBundle bundleForClass: [self class]], @"Bookmarks")];
	}
	
	
}

- (void) nonTerminalWindowBecameKey: (NSNotification *) aNotification
{
    [closeTab setAction: nil];
    [closeTab setKeyEquivalent: @""];
    [closeWindow setKeyEquivalent: @"w"];
    [closeWindow setKeyEquivalentModifierMask: NSCommandKeyMask];
}

- (void) buildSessionSubmenu: (NSNotification *) aNotification
{
    // build a submenu to select tabs
    NSMenu *aMenu = [[NSMenu alloc] initWithTitle: @"SessionMenu"];
    PTYTabView *aTabView = [[[iTermController sharedInstance] currentTerminal] tabView];
    PTYSession *aSession;
    int n = [aTabView numberOfTabViewItems];
    int i;

    // clear whatever menu we already have
    [selectTab setSubmenu: nil];

    for (i=0; i<n; i++)
    {
        aSession = [[aTabView tabViewItemAtIndex:i] identifier];
        NSMenuItem *aMenuItem;


        if(i < 10)
        {
            aMenuItem  = [[NSMenuItem alloc] initWithTitle: [aSession name] action: @selector(selectSessionAtIndexAction:) keyEquivalent: [NSString stringWithFormat: @"%d", i+1]];
            [aMenuItem setTag: i];

            [aMenu addItem: aMenuItem];
            [aMenuItem release];
        }

    }
    [selectTab setSubmenu: aMenu];

    [aMenu release];
}

- (void) buildAddressBookMenu : (NSNotification *) aNotification
{
    NSMenu *newMenu;
    PseudoTerminal *frontTerminal = [[iTermController sharedInstance] currentTerminal];

    // clear whatever menus we already have
    [newTab setSubmenu: nil];
    [newWindow setSubmenu: nil];

    // new window
    newMenu = [[iTermController sharedInstance] buildAddressBookMenuWithTarget: nil withShortcuts: YES];
    [newWindow setSubmenu: newMenu];
 
    // new tab
    newMenu = [[iTermController sharedInstance] buildAddressBookMenuWithTarget: frontTerminal withShortcuts: YES];
    [newTab setSubmenu: newMenu];
    
}

- (void) reloadSessionMenus: (NSNotification *) aNotification
{
    PTYSession *aSession = [aNotification object];

    if(aSession == nil)
	return;

    [logStart setEnabled: ![aSession logging]];
    [logStop setEnabled: [aSession logging]];
}

- (BOOL) validateMenuItem: (NSMenuItem *) menuItem
{
  if ([menuItem action] == @selector(useTransparency:)) 
  {
    BOOL b = [[[[iTermController sharedInstance] currentTerminal] currentSession] useTransparency];
    [menuItem setState: b == YES ? NSOnState : NSOffState];
  }
  return YES;
}

@end

// Scripting support
@implementation iTermApplicationDelegate (KeyValueCoding)

- (BOOL)application:(NSApplication *)sender delegateHandlesKey:(NSString *)key
{
    //NSLog(@"iTermApplicationDelegate: delegateHandlesKey: '%@'", key);
    return [[iTermController sharedInstance] application:sender delegateHandlesKey:key];
}

// accessors for to-one relationships:
- (PseudoTerminal *)currentTerminal
{
    //NSLog(@"iTermApplicationDelegate: currentTerminal");
    return [[iTermController sharedInstance] currentTerminal];
}

- (void) setCurrentTerminal: (PseudoTerminal *) aTerminal
{
    //NSLog(@"iTermApplicationDelegate: setCurrentTerminal '0x%x'", aTerminal);
    [[iTermController sharedInstance] setCurrentTerminal: aTerminal];
}


// accessors for to-many relationships:
- (NSArray*)terminals
{
    return [[iTermController sharedInstance] terminals];
}

-(void)setTerminals: (NSArray*)terminals
{
    // no-op
}

// accessors for to-many relationships:
// (See NSScriptKeyValueCoding.h)
-(id)valueInTerminalsAtIndex:(unsigned)idx
{
    return [[iTermController sharedInstance] valueInTerminalsAtIndex:idx];
}

-(void)replaceInTerminals:(PseudoTerminal *)object atIndex:(unsigned)idx
{
    [[iTermController sharedInstance] replaceInTerminals:object atIndex:idx];
}

- (void)addInTerminals:(PseudoTerminal *) object
{
    [[iTermController sharedInstance] addInTerminals:object];
}

- (void)insertInTerminals:(PseudoTerminal *) object
{
    [[iTermController sharedInstance] insertInTerminals:object];
}

-(void)insertInTerminals:(PseudoTerminal *)object atIndex:(unsigned)idx
{
    [[iTermController sharedInstance] insertInTerminals:object atIndex:idx];
}

-(void)removeFromTerminalsAtIndex:(unsigned)idx
{
    // NSLog(@"iTerm: removeFromTerminalsAtInde %d", idx);
    [[iTermController sharedInstance] removeFromTerminalsAtIndex: idx];
}

// a class method to provide the keys for KVC:
+(NSArray*)kvcKeys
{
    return [[iTermController sharedInstance] kvcKeys];
}

@end

@implementation iTermApplicationDelegate (Find_Actions)

- (IBAction) showFindPanel: (id) sender
{
    [[FindPanelWindowController sharedInstance] showWindow:self];
}

- (IBAction) findNext: (id) sender
{
    [[FindCommandHandler sharedInstance] findNext];
}

- (IBAction) findPrevious: (id) sender
{
    [[FindCommandHandler sharedInstance] findPrevious];
}

- (IBAction) findWithSelection: (id) sender
{
    [[FindCommandHandler sharedInstance] findWithSelection];
}

- (IBAction) jumpToSelection: (id) sender
{
    [[FindCommandHandler sharedInstance] jumpToSelection];
}

@end

@implementation iTermApplicationDelegate (MoreActions)

- (void) newSessionInTabAtIndex: (id) sender
{
    [[iTermController sharedInstance] newSessionInTabAtIndex:sender];
}

- (void)newSessionInWindowAtIndex: (id) sender
{
    [[iTermController sharedInstance] newSessionInWindowAtIndex:sender];
}

@end



