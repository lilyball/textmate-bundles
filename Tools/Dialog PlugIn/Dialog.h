#import <Cocoa/Cocoa.h>

#ifndef enumerate
#define enumerate(container,var) for(NSEnumerator* _enumerator = [container objectEnumerator]; var = [_enumerator nextObject]; )
#endif

@protocol TMPlugInController
- (float)version;
@end

#define TextMateDialogServerProtocolVersion 5

@protocol TextMateDialogServerProtocol
- (int)textMateDialogServerProtocolVersion;
- (id)showNib:(NSString*)aNibPath withParameters:(id)someParameters andInitialValues:(NSDictionary*)initialValues modal:(BOOL)flag center:(BOOL)shouldCenter;
- (id)showMenuWithOptions:(NSDictionary*)someOptions;
@end
