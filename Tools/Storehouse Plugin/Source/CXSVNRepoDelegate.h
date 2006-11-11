
@interface CXSVNRepoAppDelegate : NSObject
{
	NSMutableDictionary * parameters;
}
- (IBAction) newBrowser:(id)sender;
- (void) newBrowserAtURL:(NSString *)URL;
@end
