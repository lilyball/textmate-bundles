//
//  AppDelegate.h
//  Created by Allan Odgaard on 2007-09-22.
//

#import <Cocoa/Cocoa.h>

@protocol DialogServerProtocol
- (void)hello:(id)anArgument;
@end

@interface AppDelegate : NSObject<DialogServerProtocol>
{
}
@end
