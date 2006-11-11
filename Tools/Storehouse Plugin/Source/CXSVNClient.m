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
		NSFileManager * fileManager = [NSFileManager defaultManager];

		// TODO: should probably check version number for the highest version of all installed versions
		
		for( unsigned int i = 0; i < kExecutablePathsCount; i += 1 )
		{
			NSString * possiblePath = [kExecutablePathNames[i] stringByAppendingString:@"/svn"];
		
//			NSLog(possiblePath);
			if([fileManager fileExistsAtPath:possiblePath])
			{
				sPath = [possiblePath retain];
				break;
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


#if 0
#pragma mark -
#pragma mark Commands
#endif

- (void) launchWithArguments:(NSArray *)arguments
{
	CXTask *	task = [CXLineBufferedOutputTask launchCommand:[self pathToSVN]
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

- (void) importLocalPath:(NSString *)sourcePath toURL:(NSString *)destURL withDescription:(NSString *)desc
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"import", @"-m", desc, sourcePath, destURL, nil];

	[self launchWithArguments:arguments];
}

- (void) copyURL:(NSString *)sourceURL toURL:(NSString *)destURL withDescription:(NSString *)desc
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"copy", @"-m", desc, sourceURL, destURL, nil];

	[self launchWithArguments:arguments];
}

- (void) makeDirAtURL:(NSString *)destURL withDescription:(NSString *)desc
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"mkdir", @"-m", desc, destURL, nil];

	[self launchWithArguments:arguments];
}

- (void) moveURL:(NSString *)sourceURL toURL:(NSString *)destURL withDescription:(NSString *)desc
{
	NSArray *	arguments = [NSArray arrayWithObjects:@"move", @"-m", desc, sourceURL, destURL, nil];

	[self launchWithArguments:arguments];
}

@end

