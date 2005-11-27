//
//  Edit in TextMate.h
//
//  Created by Allan Odgaard on 2005-11-26.
//  Copyright (c) 2005 MacroMates. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EditInTextMate : NSObject
{
}
+ (void)externalEditString:(NSString*)aString forView:(NSView*)aView;
@end
