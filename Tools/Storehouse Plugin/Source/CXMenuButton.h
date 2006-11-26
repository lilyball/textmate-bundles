//
//  CXMenuButton.h
//
//  Created by Chris Thomas on 2006-10-09.
//  Copyright 2006 Chris Thomas. All rights reserved.
//
//	Available bindings:
//		contentValues (read only)
//

@interface CXMenuButton : NSButton
{
	IBOutlet	NSMenu *				menu;

	// Binding support
				id 						observedObjectForArray;
				NSString *				observedKeyPathForArray;
}

- (NSMenu *)menu;
- (void)setMenu:(NSMenu *)aValue;

@end
