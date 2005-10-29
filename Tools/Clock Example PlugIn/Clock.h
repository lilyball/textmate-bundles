//
//  Clock.h
//  Clock
//
//  Created by Allan Odgaard on 2005-10-29.
//  Copyright 2005 MacroMates. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol TMPlugInController
- (float)version;
@end

@interface Clock : NSObject
{
	NSWindowController* clockWindowController;
	NSMenu* windowMenu;
	id <NSMenuItem> showClockMenuItem;
}
- (id)initWithPlugInController:(id <TMPlugInController>)aController;
- (void)dealloc;

- (void)installMenuItem;
- (void)uninstallMenuItem;

- (void)showClock:(id)sender;
- (void)disposeClock;
@end
