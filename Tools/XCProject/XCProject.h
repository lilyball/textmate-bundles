//
// File: XCProject.m
//
// Copyright: 2005 Chris Thomas. All Rights Reserved.
//
// MIT license.
//
#import <Foundation/Foundation.h>

@protocol XCVisitor
- (void) visitGroup:(NSString *)group;
- (void) visitFile:(NSString *)name path:(NSString *)name;
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
