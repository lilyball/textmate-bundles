//
// File: ConvertXcodeToTMProj.m
//
// Copyright: 2005 Chris Thomas. All Rights Reserved.
//
// MIT license.
//

#if 0
pushd "$HOME/Library/Application Support/TextMate/Tools/XCProject";
cc -arch i386 -arch ppc -ObjC -lobjc -Os -framework Foundation -std=c99 ConvertXcodeToTMProj.m XCProject.m -o xcode_to_tmproj
cp xcode_to_tmproj ../../Bundles/Source.tmbundle/bin/
date
popd
#endif

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
	NSString *	displayName = [group displayName];
	// Add our entry to the parent group
	
	// the topmost node might not have a name -- but we don't need to distinguish between it and the top level anyway
	if( displayName != nil )
	{
		NSMutableDictionary *	dictionary = [NSMutableDictionary dictionary];

		[fTMOffspring addObject:dictionary];

		// push previous group onto stack
		[fGroupStack addObject:fTMOffspring];

		// make us the parent group
		fTMOffspring = [NSMutableArray array];
		[dictionary setObject:fTMOffspring forKey:@"children"];

		// fill in some default values
		[dictionary setObject:displayName forKey:@"name"];
		
		// these should be command-line settings; if they're included at all, the value is assumed to be YES, otherwise NO.
//		[dictionary setObject:[NSNumber numberWithBool:NO] forKey:@"expanded"];
//		[dictionary setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];

		fprintf( stdout, "Group: %s (%s)\n", [[group displayName] UTF8String], [[group valueForKey:@"path"] UTF8String] );
	}
}

- (void) exitGroup:(XCGroup *)group
{
	//
	// pop previous group off stack and into fTMOffspring
	//
	if( [fGroupStack count] == 0 )
	{
		fprintf( stderr, "fGroupStack has no elements -- probably shouldn't be here!\n" );
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
	// unfold last (and only) child (if it exists)
	[[[fTMProj objectForKey:@"documents"] lastObject] setObject:[NSNumber numberWithBool:YES] forKey:@"expanded"];
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
			fprintf(stderr, "Could not open project '%s'\n", argv[1]);
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
		fprintf(stderr, "usage: %s <file>.xcode file.tmproj\n", argv[0]);
		exit(1);
	}
	
	// don't bother deallocating the pool
	return 0;
}

