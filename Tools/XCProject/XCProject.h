//
// File: XCProject.m
//
// Copyright: 2005 Chris Thomas. All Rights Reserved.
//
// MIT license.
//

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
- (void) visitFileGroupsDepthFirstWithDelegate:(id)delegate;

// private
- (void) visitFile:(id)file withDelegate:(id)delegate;
- (id) unarchiveObjectForKey:(NSString *)objID;

@end
