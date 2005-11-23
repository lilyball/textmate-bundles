//
//  CXTransientStatusWindow
//
//  Transient window is for status that shouldn't interrupt workflow 
//	so no dialog or sheet), but contains advisory information the user
//	still needs to know.
//
//  Created by Chris Thomas on 2005-11-18.
//  Copyright 2005 Chris Thomas. All rights reserved.
//

@class CXTransparentView;

@interface CXTransientStatusWindow : NSObject
{
	NSWindow *			fWindow;
	CXTransparentView *	fView;
	
	NSViewAnimation *	fAnimation;
}

- (void) showStatus:(NSString *)statusText onParent:(NSWindow *)parentWindow;

@end
