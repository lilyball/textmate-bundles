//
// File: XCProject.m
//
// Copyright: 2005 Chris Thomas. All Rights Reserved.
//
// MIT license.
//
// FIX ME: need to review the code for memory leaks
// TO DO: Archiving. To reverse the unarchive, we need to store the object ID in each class.
//
// cc -ObjC -lobjc -framework Foundation -std=c99 XcodeToTMProj.m
//


#import <Foundation/Foundation.h>
#import "XCodeArchiveTypes.h"
#import "XCProject.h"

// if 1, log each object to the console once it's fully unarchived
#define LOG_UNARCHIVED_OBJECTS 0

@implementation PBXBuildFile
@end
@implementation PBXBuildRule
@end
@implementation PBXBuildStyle
@end
@implementation PBXContainerItemProxy
@end
@implementation PBXFileReference
@end
@implementation PBXGroup
@end
@implementation PBXProject
@end
@implementation PBXTarget
@end
@implementation PBXNativeTarget
@end
@implementation PBXAggregateTarget
@end
@implementation PBXBuildPhase
@end
@implementation PBXShellScriptBuildPhase
@end
@implementation PBXSourcesBuildPhase
@end
@implementation PBXHeadersBuildPhase
@end
@implementation PBXFrameworksBuildPhase
@end
@implementation PBXResourcesBuildPhase
@end
@implementation PBXRezBuildPhase
@end
@implementation PBXTargetDependency
@end



@implementation XCProject

// Xcode projects seem to have an array of "objects" dictionaries keyed by UUID strings, and a "rootObject" UUID string.
- (id) initWithDictionary:(NSDictionary *)dict
{
	
	fArchivedObjects	= [[dict objectForKey:@"objects"] retain];
	fRootID				= [[dict objectForKey:@"rootObject"] retain];
	
	NSParameterAssert( fArchivedObjects != nil );
	NSParameterAssert( fRootID != nil );
	
	fUnarchivedObjects = [[NSMutableDictionary alloc ] init];

	fRootObject = [self unarchiveObjectForKey:fRootID];
		
	return self;
}
- (void) dealloc
{
	[fUnarchivedObjects release];
	[fArchivedObjects release];
	[fRootID release];
	
	[super dealloc];
}

- (id) root
{
	return fRootObject;
}


// Depth-first recursive unarchive
- (id) unarchiveObjectForKey:(NSString *)objID
{
	id				object = nil;
	NSDictionary *	dict;
	NSString *		localisa;
	NSArray *		keys;
	Class			theClass;
	unsigned int	i;
	
	dict = [fArchivedObjects objectForKey:objID];
	NSParameterAssert(dict);
	
	localisa = [dict objectForKey:@"isa"];
	NSParameterAssert(localisa);
		
	object = [fUnarchivedObjects objectForKey:objID];
	
	if( object == nil )
	{
		keys = [dict allKeys];

		theClass = NSClassFromString(localisa);
		NSParameterAssert(theClass);

		object = [[theClass alloc] init];
		NSParameterAssert(object);
		
		// Add the new object to the dictionary immediately, so that subsequent recursive references are filled in with the current object
		[fUnarchivedObjects setObject:object forKey:objID];

		for( i = 0; i < [keys count]; i += 1 )
		{
			NSString *		ivarName		= [keys objectAtIndex:i];
			
			if( ! [ivarName isEqualToString:@"isa"] )
			{
				id				value	= [dict objectForKey:ivarName];
				
				//
				// Recursion time.
				// If the value is an object ID or a container, unarchive it.
				// FIX ME: right now we only handle array containers. Not sure if Xcode uses dictionaries.
				//
				if( [fArchivedObjects objectForKey:value] != nil )
				{
					value = [self unarchiveObjectForKey:value];
				}
				else if( [value isKindOfClass:[NSArray class]] )
				{
					NSMutableArray *	array = [[NSMutableArray alloc] init];
					
					for( unsigned int arrayIndex = 0; arrayIndex < [value count]; arrayIndex += 1 )
					{
						id	subObjID	= [value objectAtIndex:arrayIndex];
						id	subObject;
						
						if( [fArchivedObjects objectForKey:subObjID] != nil )
						{
							subObject = [self unarchiveObjectForKey:subObjID];
						}
						else
						{
							subObject = subObjID;
						}
						[array addObject:subObject];
					}
					
					value = array;
				}
				
				// Use key-value coding to set the ivar
				[object setValue:value forKey:ivarName];
			}
		}
		
		if(LOG_UNARCHIVED_OBJECTS)
		{
			fprintf( stdout, "%s: %s\n", [[objID description] UTF8String], [[object description] UTF8String] );
		}
	}
	else
	{
		if(LOG_UNARCHIVED_OBJECTS)
		{
			fprintf( stdout, "%s: (%s)\n", [[objID description] UTF8String], [[object description] UTF8String] );
		}
	}
	
	return object;
}

// recursive file visitor
- (void) visitFile:(id)file withDelegate:(id)delegate
{
	// name = @"name"
	// name ||= @"path"
	NSString *	name = [file valueForKey:@"name"];

	if(name == nil)
	{
		name = [file valueForKey:@"path"];
	}

	if( [file isKindOfClass:[PBXGroup class]] )
	{
		NSArray *	children;
		
		[delegate visitGroup:name];
		children = [file valueForKey:@"children"];
		for( unsigned int index = 0; index < [children count]; index += 1 )
		{
			id	object = [children objectAtIndex:index];
			[self visitFile:object withDelegate:delegate];
		}
	}
	else
	{
		[delegate visitFile:name path:[file valueForKey:@"path"]];
	}
}

- (void) visitFileGroupsDepthFirstWithDelegate:(id)delegate
{
	[self visitFile:[[self root] valueForKey:@"mainGroup"] withDelegate:delegate];
}

@end


@interface TestDelegate : NSObject

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
		
		[project visitFileGroupsDepthFirstWithDelegate:test];
		
	}
	
	// don't bother deallocating the pool
	return 0;
}

