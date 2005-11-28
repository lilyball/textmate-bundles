
#include "CXSVNRepoNode.h"
#include "CXSVNTask.h"


@interface CXSVNRepoNode(Private)

- (void) startActivity;
- (void) stopActivity;

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
	
	NSLog(@"node:%@ match:%@", [self nameForURL], URL);
	
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

			for( unsigned int index = 0; index < [fChildren count]; index += 1 )
			{
				CXSVNRepoNode *	child = [fChildren objectAtIndex:index];
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


+ (CXSVNRepoNode *) rootNodeWithURL:(NSString *)URL
{
	CXSVNRepoNode * node = [[CXSVNRepoNode alloc] init];
	
	if(node != nil)
	{
//		NSLog(@"%s %@", _cmd, node );
		node->fDisplayName			= [URL copy];
		node->fIsBranch				= YES;
	}
	
	return [node autorelease];
}


+ (CXSVNRepoNode *) nodeWithName:(NSString *)name parent:(CXSVNRepoNode *)parent
{
	CXSVNRepoNode * node = [[CXSVNRepoNode alloc] init];
	
	if(node != nil)
	{
//		NSLog(@"%s %@", _cmd, node );
		node->fDisplayName	= [name copy];
		node->fParent		= parent;
		node->fDelegate		= parent->fDelegate;
	}
	
	return [node autorelease];
}

- (void) dealloc
{
	[fChildren release];
	
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

- (BOOL) isBusy
{
	return (fBusyRefCount > 0);
}

- (void) invalidateChildren
{
	[fChildren release];
	fChildren = nil;
}

- (void) loadChildren
{	
	[self loadChildrenWithQueueKey:self];
}

- (void) loadChildrenWithQueueKey:(id)key
{
	if( fChildren == nil )
	{
		NSArray *	arguments = [NSArray arrayWithObjects:@"ls", [self URL], nil];

		// prevent redundant requests!
		fChildren = [[NSMutableArray alloc] init];
		
		[self startActivity];
		
		[CXSVNTask	launchWithArguments:arguments
				notifying:self
				outputAction:@selector(listOutput:)
				queueKey:key];
	}
}

- (NSArray *)children
{
	NSArray *	outArray;
	
	outArray = fChildren;
	
	if(outArray == nil)
	{
		outArray = [NSArray array];
	}
	
	return outArray;
}

- (NSArray *) nodesFromSimpleFileListing:(NSString *)data
{
	NSArray *			arrayOfNames	= [data componentsSeparatedByString:@"\n"];
	NSMutableArray *	arrayOfNodes	= [NSMutableArray array];
	UInt32				nameCount		= [arrayOfNames count];

	for( unsigned int index = 0; index < nameCount; index += 1 )
	{
		NSString *		string = [arrayOfNames objectAtIndex:index];
		CXSVNRepoNode *	node;
		BOOL			isBranch;
		
		// First item? is there a previous partial line waiting?
		if( index == 0 )
		{
			if(fPartialChild != nil)
			{
//				NSLog(@"complete partial data read:%@", string);
				string = [fPartialChild stringByAppendingString:string];
				[fPartialChild release];
				fPartialChild = nil;
			}
		}
		
		// Last item? Do we need to save it for next time?
		if( index == (nameCount - 1)
		 	&& ![data hasSuffix:@"\n"])	// partial line read
		{
//			NSLog(@"partial data read:%@", string);
			[fPartialChild release];
			fPartialChild = [string copy];
		}
		else
		{
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
	}
	
	return arrayOfNodes;
}

#if 0
#pragma mark Activity Monitoring
#endif

- (void) startActivity
{
	fBusyRefCount += 1;
	if(fBusyRefCount == 1)
	{
		[fDelegate willStartSVNNode:self];
	}
}

- (void) stopActivity
{
	fBusyRefCount -= 1;
	if(fBusyRefCount == 0)
	{
		[fDelegate didStopSVNNode:self];
	}
}


#if 0
#pragma mark Commands
#endif
- (void)listOutput:(NSString *)output
{
	if( output == nil )
	{	
		[fPartialChild release];
		fPartialChild = nil;
		[self stopActivity];
	}
	else
	{
		NSArray *	oldChildren = fChildren;
		NSArray *	newChildren;
		newChildren = [self nodesFromSimpleFileListing:output];

		if(fChildren == nil)
		{
			fChildren = [newChildren retain];
			
			[fDelegate didUpdateChildrenAtSVNNode:self];
		}
		else
		{
			fChildren = [fChildren arrayByAddingObjectsFromArray:newChildren];
			[fChildren retain];
			[oldChildren release];
			
			[fDelegate didUpdateChildrenAtSVNNode:self];
		}
	}
}

/*- (void) copyURLs:(NSArray *)URLs withDescription:(NSString *)desc
{
	// FIXME: copy more than one
	// FIXME: add description entry dialog
	NSArray *	arguments = [NSArray arrayWithObjects:@"copy", @"-m", desc, [URLs objectAtIndex:0], [self URL], nil];

//	NSLog(@"arguments:%@", arguments);

	[self startActivity];
	
	[CXSVNTask	launchWithArguments:arguments
				notifying:self
				outputAction:@selector(copyOutput:)
				queueKey:self];
}

// FIXME: this simply uses the node as a convenience; the URL could be anywhere
- (void) copyURL:(NSString *)sourceURL toURL:(NSString *)destURL withDescription:(NSString *)desc
{
	// FIXME: copy more than one
	// FIXME: add description entry dialog
	NSArray *	arguments = [NSArray arrayWithObjects:@"copy", @"-m", desc, sourceURL, destURL, nil];

//	NSLog(@"arguments:%@", arguments);

	[self startActivity];
	
	[CXSVNTask	launchWithArguments:arguments
				notifying:self
				outputAction:@selector(copyOutput:)
				queueKey:self];
}

- (void)copyOutput:(NSString *)output
{	
	if( output != nil )
	{
		NSLog( @"%@", output );
		
		[fDelegate statusLine:output forSVNNode:self];
	}
	else
	{
		[self invalidateChildren];
		[self loadChildren];
		[self stopActivity];
	}
}
*/
- (void) error:(NSString *)string fromTask:(CXSVNTask *)task
{
	[fDelegate error:string usingSVNNode:self];
}

- (void) setDelegate:(id)delegate
{
	fDelegate = delegate;
}

- (id) delegate
{
	return fDelegate;
}

@end
