
#ifndef _CXSVNRepoNode_H_
#define _CXSVNRepoNode_H_

@class CXSVNTask;

@interface CXSVNRepoNode : NSObject
{
	NSString *			fDisplayName;	// should be the first part of the URL if the root node
	NSArray *			fChildren;
	NSString *			fPartialChild;
	
	id 					fDelegate;
	
	CXSVNRepoNode *		fParent;		// nil if root node
	BOOL				fIsBranch;
	
	UInt32				fBusyRefCount;
}

- (void) setDelegate:(id)delegate;
- (id) delegate;

+ (CXSVNRepoNode *) rootNodeWithURL:(NSString *)URL;
+ (CXSVNRepoNode *) nodeWithName:(NSString *)name parent:(CXSVNRepoNode *)parent;

- (NSString *) URL;

- (void) setIsBranch:(BOOL)branch;
- (BOOL) isBranch;

- (BOOL) isBusy;

// data access
- (CXSVNRepoNode *) parent;
- (NSString *) displayName;
- (NSString *) nameForURL;

// svn ls
- (void) loadChildren;
- (void) invalidateChildren;
- (NSArray *)children;


// svn cp
// Copy URLs from the array to this node.
- (void) copyURLs:(NSArray *)URLs withDescription:(NSString *)desc;
- (void) copyURL:(NSString *)sourceURL toURL:(NSString *)destURL withDescription:(NSString *)desc;

- (void) error:(NSString *)string fromTask:(CXSVNTask *)task;

@end

@interface NSObject(CXSVNNodeDelegate)

- (void) willStartSVNNode:(CXSVNRepoNode *)node;
- (void) didStopSVNNode:(CXSVNRepoNode *)node;

- (void) statusLine:(NSString *)status forSVNNode:(CXSVNRepoNode *)node;
- (void) error:(NSString *)errorText usingSVNNode:(CXSVNRepoNode *)node;

- (void) didUpdateChildrenAtSVNNode:(CXSVNRepoNode *)node;
@end

#endif /* _CXSVNRepoNode_H_ */



