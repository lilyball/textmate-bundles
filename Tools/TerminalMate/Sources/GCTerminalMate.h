#import <Cocoa/Cocoa.h>
#include <ruby.h>

@protocol TMPlugInController
- (float)version;
@end

@interface GCTerminalMate : NSObject
{
    id windowMenu;
}
- (id)initWithPlugInController:(id <TMPlugInController>)aController;
- (void)dealloc;
@end
