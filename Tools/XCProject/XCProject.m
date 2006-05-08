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

#import "XCProject.h"
#import "XCodeArchiveTypes.h"

// if 1, log each object to the console once it's fully unarchived
#define LOG_UNARCHIVED_OBJECTS 0

@implementation XCBuildConfiguration
@end
@implementation PBXBuildSettingsParent
@end
@implementation XCConfigurationList
@end
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
@implementation PBXVariantGroup
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
//@implementation PBXShellScriptBuildPhase		-- commented out for testing “fault-tolerance”
//@end
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
@implementation PBXObject
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
	NSLog(@"Tried to set undefined key '%@' of class '%@' to '%@'", key, [[self class] className], value);
}
@end



@interface XCProject(Private)

// private
- (void) visitFile:(id)file withDelegate:(id)delegate;
- (id) unarchiveObjectForKey:(NSString *)objID;

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
		if(theClass == nil)
		{
			NSLog(@"unknown class:%@", localisa);
		}
		else
		{
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
							if( subObject != nil )
							{
								[array addObject:subObject];
							}
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
- (void) visitFile:(id)file ofGroup:(PBXGroup *)group withDelegate:(id)delegate
{
	[file setParent:group];

	if( [file isKindOfClass:[PBXGroup class]] )
	{
		NSArray *	children;
		
		[delegate visitGroup:(XCGroup *)file];
		children = [file valueForKey:@"children"];
		
		for( unsigned int index = 0; index < [children count]; index += 1 )
		{
			id	object = [children objectAtIndex:index];
			[self visitFile:object ofGroup:file withDelegate:delegate];
		}
		
		[delegate exitGroup:(XCGroup *)file];
	}
	else
	{
		[delegate visitFile:file];
	}
}

- (void) visitFileGroupsDepthFirstWithVisitor:(id<XCVisitor>)delegate
{
	[self visitFile:[[self root] valueForKey:@"mainGroup"] ofGroup:nil withDelegate:delegate];
}

@end

@implementation XCFile(Accessors)

- (NSString *) displayName
{
	// name = @"name"
	// name ||= @"path"
	NSString *	displayName = [self valueForKey:@"name"];

	if(displayName == nil)
	{
		displayName = [self valueForKey:@"path"];
		
//		if(displayName == nil)
//		{
//			displayName = @"<root>";
//		}
	}
	
	return displayName;
}

// path is group relative?
-(BOOL) isGroupRelative
{
	return [[self valueForKey:@"sourceTree"] isEqualToString:@"<group>"];
}

//
// Return the path of this file ref.
// If the file's path is not group-relative, the parent group is ignored.
//
// Xcode path reconstruction for group-relative paths concatenates the "path" ivars of
// all the parent nodes. Stop when we get to the first non-group-relative parent node.
//
-(NSString *) relativePath
{
	NSString *	selfPath	= [self valueForKey:@"path"];
	XCGroup *	current		= [self parent];

	// paranoia
	if(selfPath == nil)
	{
		selfPath = @"<nil>";
	}
	
	if( [self isGroupRelative] )
	{
		NSString *	segment;
		
		while( current != nil && [current isGroupRelative] )	
		{
			segment = [current valueForKey:@"path"];
			if( segment != nil )
			{
				selfPath = [segment stringByAppendingFormat:@"/%@", selfPath];
			}
			
			current = [current parent];
		}
		
		//
		// The highest parent node that is not group relative will
		// be the first element of the group-relative path.
		//
		segment = [current valueForKey:@"path"];
		if( segment != nil )
		{
			selfPath = [segment stringByAppendingFormat:@"/%@", selfPath];
		}
		
	}
	
	return selfPath;
}

- (XCGroup *) parent
{
	return XCParentGroup;
}

- (void) setParent:(XCGroup *) parent
{
	XCParentGroup = parent;
}

@end
