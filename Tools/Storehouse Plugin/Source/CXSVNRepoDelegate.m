
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
	
	if(self = [super init])
	{
		[self vend];
	}
	
	return self;
}

- (void)dealloc
{
	[sBrowsers release];
	[super dealloc];
}
#else
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self vend];
	[self newBrowser:self];
}

#endif

- (void) SVNRepoBrowserDidTerminate:(CXSVNRepoBrowser *)browser
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

- (void) vend
{
	NSPort *		newPort			= [NSPort port];
	NSConnection *	connection		= [NSConnection connectionWithReceivePort:newPort sendPort:newPort];

	[connection setRootObject:self];
	if ([connection registerName:@"CXSVNRepoBrowser"] == NO)
	{
		NSRunAlertPanel(@"Can't vend Storehouse browser object.", @"I can't vend the browser object. I can't tell you why, either, because AppKit won't tell me. (In plain English, this means that the Browse Subversion Repository command won't work.)", @"OK", nil, nil);
	}
	[connection retain];
}

@end
