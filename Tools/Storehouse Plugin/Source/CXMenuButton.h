//
//  CXMenuButton.h
//
//  Created by Chris Thomas on 2006-10-09.
//  Copyright 2006 Chris Thomas. All rights reserved.
//  MIT license.
//

@interface CXMenuButton : NSButton
{
	IBOutlet	NSMenu *				menu;
//				NSMutableArray *		array;
				id 						observedObjectForArray;
				NSString *				observedKeyPathForArray;
}

- (NSMenu *)menu;
- (void)setMenu:(NSMenu *)aValue;

- (NSMutableArray *)array;
- (void)setArray:(NSMutableArray *)newArray;

@end
