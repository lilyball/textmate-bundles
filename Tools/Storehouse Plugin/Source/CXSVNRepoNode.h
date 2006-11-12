
#ifndef _CXSVNRepoNode_H_
#define _CXSVNRepoNode_H_

@class CXSVNClient;

@interface CXSVNRepoNode : NSObject
{
	NSString *			fDisplayName;	// should be the first part of the URL if the root node
	NSArray *			fSubnodes;
	
	CXSVNRepoNode *		fParent;		// nil if root node
	BOOL				fIsBranch;
	CXSVNClient *		fSVNClient;
}

+ (CXSVNRepoNode *) rootNodeWithURL:(NSString *)URL SVNClient:(CXSVNClient *)client;
+ (CXSVNRepoNode *) nodeWithName:(NSString *)name parent:(CXSVNRepoNode *)parent;

- (NSString *) URL;
- (CXSVNRepoNode *) visibleNodeForURL:(NSString *)URL;

- (void) setIsBranch:(BOOL)branch;
- (BOOL) isBranch;

// data access
- (CXSVNRepoNode *) parentNode;
- (NSString *) displayName;
- (NSString *) nameForURL;

// svn ls
- (void) loadSubnodes;
- (void) invalidateSubnodes;
- (NSArray *)subnodes;

@end

#endif /* _CXSVNRepoNode_H_ */
