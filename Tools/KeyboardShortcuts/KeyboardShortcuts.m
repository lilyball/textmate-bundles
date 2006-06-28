// KeyboardShortcuts.m
// Kevin Ballard
//
// Copyright © 2005, Kevin Ballard

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

int main (int argc, const char * argv[]) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSMutableArray *sourcePaths = [NSMutableArray arrayWithObjects:
		@"/Library/Application Support/TextMate/Bundles",
		[@"~/Library/Application Support/TextMate/Bundles" stringByExpandingTildeInPath],
		nil];

	NSString *defaultBundles = [[[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:@"com.macromates.textmate"] stringByAppendingPathComponent:@"Contents/SharedSupport/Bundles"];
	if(defaultBundles)
		[sourcePaths insertObject:defaultBundles atIndex:0];

	NSArray *subPaths = [NSArray arrayWithObjects:@"Commands", @"Macros", @"Snippets", nil];
	NSFileManager *fm = [NSFileManager defaultManager];
	
	NSDictionary *textMateDefaults = [[NSUserDefaults standardUserDefaults]
											persistentDomainForName:@"com.macromates.textmate"];
	NSArray *disabledBundles = [textMateDefaults objectForKey:@"OakBundleManagerDisabledBundles"];
	
	NSMutableDictionary *bundles = [NSMutableDictionary dictionary];
	
	// First gather the bundle information we want
	NSEnumerator *sourceEnum = [sourcePaths objectEnumerator];
	NSString *sourcePath;
	while( sourcePath = [sourceEnum nextObject] ) {
		NSArray *bundlePaths = [[fm directoryContentsAtPath:sourcePath]
									pathsMatchingExtensions:[NSArray arrayWithObject:@"tmbundle"]];
		NSEnumerator *bundleEnum = [bundlePaths objectEnumerator];
		NSString *bundlePath;
		while( bundlePath = [bundleEnum nextObject] ) {
			NSMutableDictionary *bundle = [NSMutableDictionary dictionary];
			NSDictionary *infoPlist = [NSDictionary dictionaryWithContentsOfFile:
				[[sourcePath stringByAppendingPathComponent:bundlePath]
					stringByAppendingPathComponent:@"info.plist"]];
			if( ! infoPlist || ! [infoPlist objectForKey:@"name"] || ! [infoPlist objectForKey:@"uuid"] )
				continue;
			if( [disabledBundles containsObject:[infoPlist objectForKey:@"uuid"]] ) {
				// It's a disabled bundle
				// Skip it
				continue;
			}
			
			NSAutoreleasePool *innerPool = [[NSAutoreleasePool alloc] init];
			NSEnumerator *subEnum = [subPaths objectEnumerator];
			NSString *subPath;
			while( subPath = [subEnum nextObject] ) {
				NSMutableArray *items = [NSMutableArray array];
				NSString *plistPath = [[sourcePath stringByAppendingPathComponent:bundlePath]
											stringByAppendingPathComponent:subPath];
				NSArray *plists = [[fm directoryContentsAtPath:plistPath]
										pathsMatchingExtensions:[NSArray arrayWithObjects:@"plist", @"tmCommand", @"tmSnippet", @"tmMacro", nil]];
				NSEnumerator *plistEnum = [plists objectEnumerator];
				NSString *plist;
				while( plist = [plistEnum nextObject] ) {
					NSString *path = [plistPath stringByAppendingPathComponent:plist];
					NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
					NSMutableDictionary *item = [NSMutableDictionary dictionary];
					if ([[dict objectForKey:@"keyEquivalent"] length])
						[item setObject:[dict objectForKey:@"keyEquivalent"] forKey:@"keyEquivalent"];
					if ([[dict objectForKey:@"tabTrigger"] length])
						[item setObject:[dict objectForKey:@"tabTrigger"] forKey:@"tabTrigger"];
					if ([[dict objectForKey:@"trigger"] length])
						[item setObject:[dict objectForKey:@"trigger"] forKey:@"tabTrigger"];
					if ([[dict objectForKey:@"inputPattern"] length])
						[item setObject:[dict objectForKey:@"inputPattern"] forKey:@"inputPattern"];
					if( [item count] > 0 ) {
						[item setValue:[dict objectForKey:@"name"] forKey:@"name"];
						[items addObject:item];
					}
				}
				if( [items count] > 0 ) {
					[bundle setObject:items forKey:subPath];
				}
			}
			[innerPool release];
			
			if( [bundle count] > 0 ) {
				[bundle setObject:[infoPlist objectForKey:@"name"] forKey:@"name"];
				[bundle setObject:[infoPlist objectForKey:@"uuid"] forKey:@"uuid"];
				
				NSDictionary *oldBundle = [bundles objectForKey:[infoPlist objectForKey:@"uuid"]];
				if( oldBundle ) {
					NSMutableDictionary *newBundle = [oldBundle mutableCopy];
					[newBundle addEntriesFromDictionary:bundle];
					bundle = newBundle;
				}
				[bundles setObject:bundle forKey:[infoPlist objectForKey:@"uuid"]];
			}
		}
	}
	
	// Now output the bundles list as a property list
	NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"name"
																	ascending:YES] autorelease];
	NSArray *bundleArray = [[bundles allValues] sortedArrayUsingDescriptors:
														[NSArray arrayWithObject:sortDescriptor]];
	NSString *errorStr = nil;
	NSData *data = [NSPropertyListSerialization dataFromPropertyList:bundleArray
															  format:NSPropertyListXMLFormat_v1_0
													errorDescription:&errorStr];
	
	if( errorStr ) {
		NSFileHandle *errorHandle = [NSFileHandle fileHandleWithStandardError];
		[errorHandle writeData:[errorStr dataUsingEncoding:NSUTF8StringEncoding]];
		[pool release];
		return 1;
	}
	
	NSFileHandle *outputHandle = [NSFileHandle fileHandleWithStandardOutput];
	[outputHandle writeData:data];
	
	[pool release];
	return 0;
}
