#import <Cocoa/Cocoa.h>

#ifndef enumerate
#define enumerate(container,var) for(NSEnumerator* _enumerator = [container objectEnumerator]; var = [_enumerator nextObject]; )
#endif

@protocol TMPlugInController
- (float)version;
@end

#define TextMateDialogServerProtocolVersion 9

@protocol TextMateDialogServerProtocol
- (int)textMateDialogServerProtocolVersion;
- (id)showNib:(NSString*)aNibPath withParameters:(id)someParameters andInitialValues:(NSDictionary*)initialValues dynamicClasses:(NSDictionary*)dynamicClasses modal:(BOOL)flag center:(BOOL)shouldCenter async:(BOOL)async;

// Async window support
- (id)listNibTokens;

- (id)updateNib:(id)token withParameters:(id)someParameters;
- (id)closeNib:(id)token;
- (id)retrieveNibResults:(id)token;

// Alert
- (id)showAlertForPath:(NSString*)filePath withParameters:(NSDictionary *)parameters modal:(BOOL)modal;

// Menu
- (id)showMenuWithOptions:(NSDictionary*)someOptions;
@end
