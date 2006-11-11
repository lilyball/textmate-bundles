
#include "CXSVNRepoDelegate.h"
#include "CXSVNRepoBrowser.h"

@protocol TMPlugInController
- (float)version;
@end

@implementation CXSVNRepoAppDelegate
static NSMutableArray *			sBrowsers = nil;

#if TMPLUGIN

- (id)initWithPlugInController:(id <TMPlugInController>)aController
{
	NSApp = [NSApplication sharedApplication];
	
	return [super init];
}

- (void)dealloc
{
	[sBrowsers release];
	[super dealloc];
}
#else

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self newBrowser:self];
}
#endif

- (void) SVNRepoBrowserWillClose:(CXSVNRepoBrowser *)browser
{
	[sBrowsers removeObject:browser];
}

- (IBAction) newBrowser:(id)sender
{
	[self newBrowserAtURL:nil];
}

- (CXSVNRepoBrowser *) firstEmptyBrowser
{
	CXSVNRepoBrowser *	outBrowser = nil;
	
	if( sBrowsers != nil )
	{
		for( unsigned int index = 0; index < [sBrowsers count]; index += 1 )
		{
			CXSVNRepoBrowser *	browser = [sBrowsers objectAtIndex:index];
		
			if([[browser URL] isEqualToString:@""])
			{
				outBrowser = browser;
				break;
			}
		}
	}
	
	return outBrowser;
}

- (void) newBrowserAtURL:(NSString *)URL
{
	CXSVNRepoBrowser *	newBrowser;
	
	newBrowser = [self firstEmptyBrowser];
	
	// Keep a list of browsers
	if(newBrowser == nil)
	{
		if( sBrowsers == nil )
		{
			sBrowsers = [[NSMutableArray alloc] init];
		}

		newBrowser = [CXSVNRepoBrowser browserAtURL:URL];
		
		if(newBrowser != nil)
		{
			if( [sBrowsers count] > 0 )
			{
				[[sBrowsers lastObject] syncNextBrowserWindowFrame:newBrowser];
			}
			
			[sBrowsers addObject:newBrowser];
		}
		
		[newBrowser setDelegate:self];
	}
	else
	{
		[newBrowser loadURL:URL];
	}
}

@end
