//
// File: XCProject.m
//
// Copyright: 2005 Chris Thomas. All Rights Reserved.
//
// MIT license.
//
#import <Foundation/Foundation.h>
#import "XCodeArchiveTypes.h"

@class PBXFileReference;
@class PBXGroup;

#define XCFile PBXFileReference
#define XCGroup PBXGroup

@interface XCFile(Accessors)

- (NSString *) displayName;

// path is group relative?
-(BOOL) isGroupRelative;

// Return the path of this file ref.
// If the file's path is not group-relative, the parent group is ignored.
-(NSString *) relativePath;

- (XCGroup *) parent;
- (void) setParent:(XCGroup *) parent;
@end

@protocol XCVisitor
- (void) visitGroup:(XCGroup *)group;
- (void) exitGroup:(XCGroup *)group;
- (void) visitFile:(XCFile *)file;
@end

@interface XCProject : NSObject
{
	NSDictionary *			fArchivedObjects;
	NSString *				fRootID;
	id						fRootObject;
	
	NSMutableDictionary *	fUnarchivedObjects;	// unarchived objects indexed by id	
}

- (id) initWithDictionary:(NSDictionary *)dict;

- (id) root;
- (void) visitFileGroupsDepthFirstWithVisitor:(id<XCVisitor>)delegate;

@end
