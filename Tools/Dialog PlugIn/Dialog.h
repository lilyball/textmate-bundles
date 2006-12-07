#import <Cocoa/Cocoa.h>

#ifndef enumerate
#define enumerate(container,var) for(NSEnumerator* _enumerator = [container objectEnumerator]; var = [_enumerator nextObject]; )
#endif

@protocol TMPlugInController
- (float)version;
@end

#define TextMateDialogServerProtocolVersion 6

@protocol TextMateDialogServerProtocol
- (int)textMateDialogServerProtocolVersion;
- (id)showNib:(NSString*)aNibPath withParameters:(id)someParameters andInitialValues:(NSDictionary*)initialValues modal:(BOOL)flag center:(BOOL)shouldCenter async:(BOOL)async;

// Async window support
- (id)listNibTokens;

- (id)updateNib:(id)token withParameters:(id)someParameters;
- (id)closeNib:(id)token;
- (id)retrieveNibResults:(id)token;

// Menu
- (id)showMenuWithOptions:(NSDictionary*)someOptions;
@end
