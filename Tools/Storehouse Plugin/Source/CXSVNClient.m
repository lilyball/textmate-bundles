/*
   CXSVNClient.m
   Created by Chris Thomas on 2006-11-10.
   Copyright 2006 Chris Thomas. All rights reserved.
*/


#import "CXSVNClient.h"
#import "CXLineBufferedOutputTask.h"

@implementation CXSVNClient

const UInt32			kExecutablePathsCount = 5;
const NSString *		kExecutablePathNames[]	 = {	@"~/bin",			// version in user's $HOME
														@"/usr/local/bin",	// tarball default
														@"/opt/local/bin",	// DarwinPorts
														@"/sw/bin",			// Fink
														@"/usr/bin" };		// Xcode Tools install

- (NSString *) pathToSVN
{
	static NSString *	sPath = nil;
	
	if( sPath == nil )
	{
		// TM_SVN environment variable overrides path search.
		const char * tmSVN = getenv("TM_SVN");
		
		if( tmSVN != NULL )
		{
			sPath = [[NSString stringWithUTF8String:tmSVN] retain];
		}
		else
		{
			NSFileManager * fileManager = [NSFileManager defaultManager];

			for( unsigned int i = 0; i < kExecutablePathsCount; i += 1 )
			{
				NSString * possiblePath = [kExecutablePathNames[i] stringByAppendingString:@"/svn"];

				if([fileManager fileExistsAtPath:possiblePath])
				{
					sPath = [possiblePath retain];
					break;
				}
			}
		}
		NSLog(@"Subversion command:%@", sPath);
	}
	
	return sPath;
}


- (void) dealloc
{
	[fUserInfo release];
	[fObserver release];
	[super dealloc];
}

#if 0
#pragma mark -
#pragma mark Results Handling
#endif

- (id)observer
{
	return fObserver;
}

- (void)setObserver:(id)aValue
{
	id oldObserver = fObserver;
	fObserver = [aValue retain];
	[oldObserver release];
}

- (id)userInfo
{
	return fUserInfo;
}

- (void)setUserInfo:(id)aValue
{
	id oldUserInfo = fUserInfo;
	fUserInfo = [aValue retain];
	[oldUserInfo release];
}

// forward all of these

- (void) taskWillStart
{
	[fObserver startingTask];
}

- (void) taskExited:(CXTask *)task withStatus:(int)terminationStatus
{
	[fObserver exitedSVNWithStatus:terminationStatus userInfo:[task userInfo]];
}

- (void) readOutput:(NSString *)output fromTask:(CXTask *)task
{
	[fObserver readSVNOutput:output];
}

- (void) readError:(NSString *)error fromTask:(CXTask *)task
{
	[fObserver readSVNError:error];
}

- (void) contentsOfSVNURLDidChange:(NSString *)url
{
	[fObserver contentsOfSVNURLDidChange:url];
}


#if 0
#pragma mark -
#pragma mark Commands
#endif

- (void) launchWithArguments:(NSArray *)arguments
{
	[self taskWillStart];
	/*CXTask *	task =*/ [CXLineBufferedOutputTask launchCommand:[self pathToSVN]
													withArguments:arguments
													notifying:self
													outputAction:@selector(readOutput:fromTask:)
													errorAction:@selector(readError:fromTask:)
													queueKey:fObserver
													userInfo:fUserInfo];
}

- (void) exportURL:(NSString *)sourceURL toLocalPath:(NSString *)path
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"export", sourceURL, path, nil];

	[self launchWithArguments:arguments];
}

- (void) checkoutURL:(NSString *)sourceURL toLocalPath:(NSString *)path
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"checkout", sourceURL, path, nil];

	[self launchWithArguments:arguments];
}

- (void) removeURL:(NSString *)destURL withDescription:(NSString *)desc;
{
	[self removeURLs:[NSArray arrayWithObject:destURL] withDescription:desc];
}

- (void) removeURLs:(NSArray *)removeURLs withDescription:(NSString *)desc;
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"remove", @"-m", desc, nil];

	[self launchWithArguments:[arguments arrayByAddingObjectsFromArray:removeURLs]];
}

- (void) importLocalPath:(NSString *)sourcePath toURL:(NSString *)destURL withDescription:(NSString *)desc
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"import", @"-m", desc, sourcePath, [destURL stringByAppendingString:[sourcePath lastPathComponent]], nil];

NSLog(@"%s %@", _cmd, arguments);
	[self launchWithArguments:arguments];
}

- (void) copyURL:(NSString *)sourceURL toURL:(NSString *)destURL withDescription:(NSString *)desc
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"copy", @"-m", desc, sourceURL, destURL, nil];

	[self launchWithArguments:arguments];
}

- (void) makeDirAtURL:(NSString *)destURL withDescription:(NSString *)desc
{
	[self makeDirsAtURLs:[NSArray arrayWithObject:destURL] withDescription:desc];
}

- (void) makeDirsAtURLs:(NSArray *)addDirURLs withDescription:(NSString *)desc
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"mkdir", @"-m", desc, nil];

	[self launchWithArguments:[arguments arrayByAddingObjectsFromArray:addDirURLs]];
}

- (void) moveURL:(NSString *)sourceURL toURL:(NSString *)destURL withDescription:(NSString *)desc
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"move", @"-m", desc, sourceURL, destURL, nil];

	[self launchWithArguments:arguments];
}

#if 0
#pragma mark -
#pragma mark List
#endif

- (void) lsOutput:(NSString *)output fromTask:(CXTask *)task
{
	if(output != nil)
	{
		NSArray *			arrayOfNames	= [NSArray arrayWithObject:output];//[output componentsSeparatedByString:@"\n"];
		id 					target			= [task valueForKey:@"ls-target"];
		SEL					selector		= [[task valueForKey:@"ls-selector"] pointerValue];

		[target performSelector:selector withObject:arrayOfNames];
	}
}


// sel takes an array of names; additional items will be sent as they arrive, so expect multiple invocations of sel
- (void) listContentsOfURL:(NSString *)sourceURL toSelector:(SEL)sel ofObject:(id)target
{
	NSArray *				arguments = [NSArray arrayWithObjects:@"ls", sourceURL, nil];
	NSMutableDictionary *	userInfo = [NSMutableDictionary dictionary];
	
	[userInfo setObject:target forKey:@"ls-target"];
	[userInfo setObject:[NSValue valueWithPointer:sel] forKey:@"ls-selector"];
		
	[self taskWillStart];
	
	/*CXTask *	task =*/ [CXLineBufferedOutputTask launchCommand:[self pathToSVN]
													withArguments:arguments
													notifying:self
													outputAction:@selector(lsOutput:fromTask:)
													errorAction:@selector(readError:fromTask:)
													queueKey:fObserver
													userInfo:userInfo];
}

@end

