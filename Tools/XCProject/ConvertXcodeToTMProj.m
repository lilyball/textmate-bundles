//
// File: ConvertXcodeToTMProj.m
//
// Copyright: 2005 Chris Thomas. All Rights Reserved.
//
// MIT license.
//

// cc -ObjC -lobjc -framework Foundation -std=c99 ConvertXcodeToTMProj.m XCProject.m -o testconvert

#include "XCProject.h"

@interface Converter : NSObject <XCVisitor>
{
	NSMutableDictionary *	fTMProj;
	NSMutableArray *		fTMOffspring;	// offspring of the current group
	NSMutableArray *		fGroupStack;	// stack of fTMOffsprings
}

- (void) writeProjectToPath:(NSString *)path;

@end

@implementation Converter

- (id) init
{
	[super init];
	
	fTMOffspring = [NSMutableArray array];
	fTMProj = [[NSMutableDictionary alloc] initWithObjectsAndKeys:	fTMOffspring,			@"documents",
																[NSNumber numberWithInt:200],	@"fileHierarchyDrawerWidth",
																[NSNumber numberWithBool:YES],	@"showFileHierarchyDrawer",
																@"{{142, 116}, {851, 661}}",	@"windowFrame",
																[NSMutableDictionary dictionary],	@"metaData",
																nil];

	fGroupStack = [[NSMutableArray alloc] init];

	return self;
}

- (void) visitGroup:(XCGroup *)group
{
	// Add our entry to the parent group
	NSMutableDictionary *	dictionary = [NSMutableDictionary dictionary];
	
	[fTMOffspring addObject:dictionary];
	
	// push previous group onto stack
	[fGroupStack addObject:fTMOffspring];
	
	// make us the parent group
	fTMOffspring = [NSMutableArray array];
	[dictionary setObject:fTMOffspring forKey:@"children"];
	
	fprintf( stdout, "Group: %s (%s)\n", [[group displayName] UTF8String], [[group valueForKey:@"path"] UTF8String] );
}

- (void) exitGroup:(XCGroup *)group
{
	//
	// pop previous group off stack and into fTMOffspring
	//
	if( [fGroupStack count] == 0 )
	{
		fprintf( stderr, "fGroupStack has no elements -- probably shouldn't be here!" );
	}
	else
	{
		fTMOffspring = [fGroupStack lastObject];
		
		[fGroupStack removeLastObject];
	}
}

- (void) visitFile:(XCFile *)file
{
	NSMutableDictionary	* dictionary = [NSMutableDictionary dictionary];
	
	[dictionary setObject:[file relativePath] forKey:@"filename"];
	[fTMOffspring addObject:dictionary];
	
//	fprintf( stdout, "%s -- %s\n", [[file displayName] UTF8String], [[file relativePath] UTF8String] );
}

- (void) writeProjectToPath:(NSString *)path
{
	[fTMProj writeToFile:path atomically:NO];
}

- (void) dealloc
{
	[fGroupStack release];
	[fTMProj release];
	[super dealloc];
}

@end

int main( int argc, char ** argv )
{
	NSAutoreleasePool *	pool = [[NSAutoreleasePool alloc] init];
	
	if( argc == 3 )
	{
		NSString *			sourcePath = [NSString stringWithCString:argv[1]];
		NSString *			targetPath = [NSString stringWithCString:argv[2]];
		
		NSDictionary *		dict = [NSDictionary dictionaryWithContentsOfFile:sourcePath];
		XCProject *			project;
		Converter *			converter;
		
		if(dict == nil)
		{
			fprintf(stderr, "Could not open project '%s'", argv[1]);
			exit(1);
		}
		converter = [[Converter alloc] init];
		
		project = [[XCProject alloc] initWithDictionary:dict];
		
		[project visitFileGroupsDepthFirstWithVisitor:converter];
		[converter writeProjectToPath:targetPath];

	}
	else
	{
		fprintf(stderr, "Need exactly 2 arguments, received %d arguments", argc - 1);
		fprintf(stderr, "usage: %s <file>.xcode file.tmproj", argv[0]);
		exit(1);
	}
	
	// don't bother deallocating the pool
	return 0;
}

