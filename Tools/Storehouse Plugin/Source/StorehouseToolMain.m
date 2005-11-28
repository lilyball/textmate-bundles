//
//	StorehouseToolMain.m
//	Storehouse
//
//	Created by Chris Thomas on 11/22/05.
//	Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

int main (int argc, char const* argv[])
{
	NSAutoreleasePool *		pool = [[NSAutoreleasePool alloc] init];	
	id  					proxy;
	
	if(argc != 2)
	{
		fprintf(stderr, "%s: usage:\n", argv[0]);
		fprintf(stderr, "%s:   %s <URL>\n", argv[0], argv[0]);
		exit(1);
	}
	
//	fprintf(stderr, "%s: looking for proxy...\n", argv[0]);
	
	proxy = [[NSConnection rootProxyForConnectionWithRegisteredName:@"CXSVNRepoBrowser" host:nil] retain];

	if(proxy == nil)
	{
		fprintf(stderr, "%s: cannot find Storehouse app:\n", argv[0]);
		exit(1);
	}
	
//	fprintf(stderr, "%s: found proxy\n", argv[0]);
	
	[proxy newBrowserAtURL:[NSString stringWithUTF8String:argv[1]]];
	
//	[pool release]; // don't bother if we're going to exit anyway
	return 0;
}
