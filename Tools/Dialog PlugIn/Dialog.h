#import <Cocoa/Cocoa.h>

@protocol TMPlugInController
- (float)version;
@end

#define TextMateDialogServerProtocolVersion 3

@protocol TextMateDialogServerProtocol
- (int)textMateDialogServerProtocolVersion;
- (id)showNib:(NSString*)aNibPath withParameters:(id)someParameters modal:(BOOL)flag center:(BOOL)shouldCenter;
@end
