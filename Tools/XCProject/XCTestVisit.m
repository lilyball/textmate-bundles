//
// File: XCProject.m
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

- (void) visitGroup:(NSString *)group;
- (void) visitFile:(NSString *)name path:(NSString *)name;

@end

@implementation TestDelegate

- (void) visitGroup:(NSString *)group
{
	fprintf( stdout, "Group: %s\n", [group UTF8String] );
}
- (void) visitFile:(NSString *)name path:(NSString *)path
{
	fprintf( stdout, "File: %s path:%s\n", [name UTF8String], [path UTF8String] );
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

