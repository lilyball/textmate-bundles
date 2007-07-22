/*
   CXSVNRepoNode.m
   Storehouse Plugin
   
   Created by Chris Thomas on 2006-11-11.
   Copyright 2006 Chris Thomas. All rights reserved.
*/

#import "CXSVNRepoNode.h"
#import "CXSVNClient.h"

@interface CXSVNRepoNode (Private)
- (void) appendSubnodes:(NSArray *)arrayOfSubnodes;
@end

@implementation CXSVNRepoNode

- (NSString *) nameForURL
{
	NSString * outName;
	
	outName = [[self displayName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	if(fIsBranch)
	{
		outName = [outName stringByAppendingString:@"/"];
	}
	
	return outName;
}

- (NSString *) URL
{
	CXSVNRepoNode *		node = self;
	NSString *			nodeName = @"";

	while( node != nil )
	{
		nodeName = [[node nameForURL] stringByAppendingString:nodeName];
		node = node->fParent;
	}
	
	return nodeName;
}

- (CXSVNRepoNode *) visibleNodeForURL:(NSString *)URL
{
	NSRange 		range;
	CXSVNRepoNode *	outNode	= nil;
	
//	NSLog(@"node:%@ match:%@", [self nameForURL], URL);
	
	if ( [URL isEqualToString:[self nameForURL]] )
	{
		outNode = self;
	}
	else
	{
		range = [URL rangeOfString:[self nameForURL]];
		if(range.location != NSNotFound)
		{
			NSString *	subURL = [URL substringFromIndex:NSMaxRange(range)];

			// now find the rest of the string in child

			for( unsigned int index = 0; index < [fSubnodes count]; index += 1 )
			{
				CXSVNRepoNode *	child = [fSubnodes objectAtIndex:index];
				CXSVNRepoNode *	node;

				node = [child visibleNodeForURL:subURL];
				if(node != nil)
				{
					outNode = node;
					break;
				}
			}
		}
	}
	
	return outNode;
}


+ (id) rootNodeWithURL:(NSString *)URL SVNClient:(CXSVNClient *)client
{
	CXSVNRepoNode * node = [[self alloc] init];
	
	if(node != nil)
	{
//		NSLog(@"%s %@", _cmd, node );
		node->fDisplayName			= [URL stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		node->fIsBranch				= YES;
		node->fSVNClient			= client;
	}
	
	return [node autorelease];
}


+ (id) nodeWithName:(NSString *)name parent:(CXSVNRepoNode *)parent
{
	CXSVNRepoNode * node = [[self alloc] init];
	
	if(node != nil)
	{
//		NSLog(@"%s %@", _cmd, node );
		node->fDisplayName	= [name copy];
		node->fParent		= parent;
		node->fSVNClient	= parent->fSVNClient;
	}
	
	return [node autorelease];
}

- (void) dealloc
{
	NSLog(@"%s %@", _cmd, self);
	[fSubnodes release];
	
	[super dealloc];
}

- (CXSVNRepoNode *) parentNode
{
	return fParent;
}

- (NSString *) displayName
{
	return fDisplayName;
}

- (void) setIsBranch:(BOOL)branch
{
	fIsBranch = branch;
}

- (BOOL) isBranch
{
	return fIsBranch;
}

- (void) invalidateSubnodes
{
	[fSubnodes release];
	fSubnodes = nil;
}

- (void) loadSubnodes
{	
	if( fSubnodes == nil )
	{
		fSubnodes = [[NSMutableArray alloc] init];
		
		[fSVNClient listContentsOfURL:[self URL] toSelector:@selector(receivePartialListOfSubnodeNames:) ofObject:self];
	}
}

- (NSArray *)subnodes
{
	NSArray *	outArray;
	
	outArray = fSubnodes;
	
	if(outArray == nil)
	{
		outArray = [NSArray array];
	}
	
	return outArray;
}

- (void) addPreviewSubnode:(CXSVNRepoPreviewNode *)subnode
{
	[self appendSubnodes:[NSArray arrayWithObject:subnode]];
}

- (void) removePreviewSubnode:(CXSVNRepoPreviewNode *)subnode
{
	NSArray *			oldSubnodes = fSubnodes;
	NSMutableArray *	mutableSubnodes = [fSubnodes mutableCopy];

	[mutableSubnodes removeObject:subnode];
	fSubnodes = mutableSubnodes;
	[fSubnodes retain];
	
	[oldSubnodes release];
}

#if 0
#pragma mark Command processing
#endif

- (void) appendSubnodes:(NSArray *)arrayOfSubnodes
{
	if(fSubnodes == nil)
	{
		fSubnodes = [arrayOfSubnodes copy];
	}
	else
	{
		NSArray *	oldChildren = fSubnodes;
		
		fSubnodes = [fSubnodes arrayByAddingObjectsFromArray:arrayOfSubnodes];
		[fSubnodes retain];
		
		[oldChildren release];
	}
}

- (NSArray *) subnodesFromArrayOfNames:(NSArray *)arrayOfNames
{
	NSMutableArray *	arrayOfNodes	= [NSMutableArray array];
	UInt32				nameCount		= [arrayOfNames count];

	for( unsigned int index = 0; index < nameCount; index += 1 )
	{
		NSString *		string = [arrayOfNames objectAtIndex:index];
		CXSVNRepoNode *	node;
		BOOL			isBranch;
		
		// chomp any "/", but remember it's a directory
		if([string hasSuffix:@"/"])
		{
			isBranch = YES;
			string = [string substringToIndex:[string length] - 1];
		}
		else
		{
			isBranch = NO;
		}
	
		if( ![string length] == 0 )
		{
			node = [[self class] nodeWithName:string parent:self];
			[node setIsBranch:isBranch];

			[arrayOfNodes addObject:node];
		}
		
	}
	
	return arrayOfNodes;
}

- (void) receivePartialListOfSubnodeNames:(NSArray *)arrayOfNames
{
	NSArray *	arrayOfNodes = [self subnodesFromArrayOfNames:arrayOfNames];

	[self appendSubnodes:arrayOfNodes];
	
	[fSVNClient contentsOfSVNURLDidChange:[self URL]];
}

@end


@implementation CXSVNRepoPreviewNode
- (void) loadSubnodes
{
	// Stub out.
}
@end
