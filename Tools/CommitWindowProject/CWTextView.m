//
//  CWTextView.m
//  CommitWindow
//
//  Created by Chris Thomas on 3/7/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "CWTextView.h"

@implementation CWTextView

- (void)keyDown:(NSEvent *)event
{
	// don't let the textview eat the enter key
	if( [[event characters] isEqualToString:@"\x03"] )
	{
		[[self nextResponder] keyDown:event];
	}
	else
	{
		[super keyDown:event];
	}
}

@end
