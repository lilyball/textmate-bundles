//
//  CXTextWithButtonStripCell.m
//  NSCell supporting iTunes-store-ish action buttons
//
//  Created by Chris Thomas on 2006-10-11.
//  Copyright 2006 Chris Thomas. All rights reserved.
//

@interface CXTextWithButtonStripCell : NSTextFieldCell
{
	// buttons contains a set of button definitions to draw at the right (or left) side of the cell.
	//
	// Each item is a dictionary with the following entries:
	//	• either @"name" NSString -- localized name of button
	//	  OR @"icon" 	-- NSImage very small icon
	//	• @"menu"		-- NSMenu -- if present, indicates that this button is a menu button
	//	• @"invocation"	-- NSInvocation -- required if this is a push button, useless for menu buttons
	//
	//	TODO: none of these elements are actually used yet
	//
	NSMutableArray *	fButtons;
	UInt32				fButtonPressedIndex;
	float				fButtonStripWidth;
	BOOL				fRightToLeft;
	
}

- (NSArray *)buttonDefinitions;
- (void)setButtonDefinitions:(NSArray *)newButtonDefinitions;

@end
