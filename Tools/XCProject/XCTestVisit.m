//
// File: XCTestVisit.m
//
// Copyright: 2005 Chris Thomas. All Rights Reserved.
//
// MIT license.
//
// Test.
//

// cc -ObjC -lobjc -framework Foundation -std=c99 XCTestVisit.m XCProject.m -o testprint

#include "XCProject.h"


@interface TestDelegate : NSObject <XCVisitor>
@end

@implementation TestDelegate

- (void) visitGroup:(XCGroup *)group
{
	fprintf( stdout, "Group: %s (%s)\n", [[group displayName] UTF8String], [[group valueForKey:@"path"] UTF8String] );
}
- (void) visitFile:(XCFile *)file
{
	fprintf( stdout, "%s -- %s\n", [[file displayName] UTF8String], [[file relativePath] UTF8String] );
}

@end

int main( int argc, char ** argv )
{
	NSAutoreleasePool *	pool = [[NSAutoreleasePool alloc] init];
	XCProject *			project = [XCProject alloc];
	TestDelegate *		test = [[TestDelegate alloc] init];
	
	
	if( argc > 1 )
	{
		NSDictionary *		dict = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithCString:argv[1]]];

		[project initWithDictionary:dict];
//		NSLog( @"Dude: %@", project );
		
		[project visitFileGroupsDepthFirstWithVisitor:test];
		
	}
	
	// don't bother deallocating the pool
	return 0;
}

