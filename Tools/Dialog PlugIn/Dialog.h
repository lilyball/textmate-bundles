#import <Cocoa/Cocoa.h>

@protocol TMPlugInController
- (float)version;
@end

@protocol TextMateDialogServerProtocol
- (int)textMateDialogServerProtocolVersion;
- (id)showNib:(NSString*)aNibPath withParameters:(id)someParameters modal:(BOOL)flag;
@end
