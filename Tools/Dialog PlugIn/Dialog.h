#import <Cocoa/Cocoa.h>

@protocol TMPlugInController
- (float)version;
@end

@protocol TextMateDialogServerProtocol
- (int)textMateDialogServerProtocolVersion;
- (void)showNib:(NSString*)aNib withArguments:(id)someArguments;
@end

@interface Dialog : NSObject
{
}
- (id)initWithPlugInController:(id <TMPlugInController>)aController;
- (void)dealloc;
@end
