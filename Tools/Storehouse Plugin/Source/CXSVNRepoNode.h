
#ifndef _CXSVNRepoNode_H_
#define _CXSVNRepoNode_H_

@class CXSVNClient;
@class CXSVNRepoPreviewNode;

@interface CXSVNRepoNode : NSObject
{
	NSString *			fDisplayName;	// should be the first part of the URL if the root node
	NSArray *			fSubnodes;
	
	CXSVNRepoNode *		fParent;		// nil if root node
	BOOL				fIsBranch;
	CXSVNClient *		fSVNClient;
}

+ (id) rootNodeWithURL:(NSString *)URL SVNClient:(CXSVNClient *)client;
+ (id) nodeWithName:(NSString *)name parent:(CXSVNRepoNode *)parent;

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

// 'preview' subnodes for visualizing changes before they are committed
- (void) removePreviewSubnode:(CXSVNRepoPreviewNode *)subnode;
- (void) addPreviewSubnode:(CXSVNRepoPreviewNode *)subnode;

@end

@interface CXSVNRepoPreviewNode : CXSVNRepoNode
@end

#endif /* _CXSVNRepoNode_H_ */
