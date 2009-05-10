//
//  TMDNibController.h
//  Dialog2
//

@interface TMDNibController : NSObject
{
	NSMutableDictionary* parameters;
	NSMutableArray* clientFileHandles;

	NSArray* topLevelObjects;
	NSWindow* window;
}
- (id)initWithNibPath:(NSString*)aPath;
- (void)showWindowAndCenter:(BOOL)shouldCenter;

- (void)addClientFileHandle:(NSFileHandle*)aFileHandle;
- (void)updateParametersWith:(id)plist;
- (void)tearDown;

- (NSWindow*)window;
- (void)setWindow:(NSWindow*)aValue;
@end
