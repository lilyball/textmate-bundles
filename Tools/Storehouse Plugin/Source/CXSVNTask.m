#include "CXSVNTask.h"


@interface CXSVNTask(Private)
- (void) executeWithArguments:(NSArray *)arguments notifying:(id)target outputAction:(SEL)action;
- (void) execute;
- (void) launchNextTask;
@end


static NSString * UTF8FromData( NSData * data )
{
	NSString *		string;

	string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	return [string autorelease];
}

@implementation CXSVNTask

static NSMutableDictionary	* sTaskQueues = nil;

const UInt32			kExecutablePathsCount = 5;
const NSString *		kExecutablePathNames[]	 = {	@"~/bin",			// version in user's $HOME
														@"/usr/local/bin",	// tarball default
														@"/opt/local/bin",	// DarwinPorts
														@"/sw/bin",			// Fink
														@"/usr/bin" };		// Apple in the future?


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

- (void) nodeRefreshTerminated:(NSNotification *)notification
{	
//	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
//	[fOutHandle closeFile];
//	[fErrorHandle closeFile];
}


- (void) dealloc
{
	[fTask release];
	[fOutHandle release];
	[fErrorHandle release];
	
	[fArguments release];
	[fDelegate release];
	fDelegate	= nil;
	fTask		= nil;

	[[NSNotificationCenter defaultCenter] removeObserver:self
										name:NSFileHandleReadCompletionNotification
										object:fOutHandle];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self
										name:NSFileHandleReadCompletionNotification
										object:fErrorHandle];

	[fQueueKey release];
	[super dealloc];
}


- (void) launchNextTask
{
	NSMutableArray *	taskQueue = [sTaskQueues objectForKey:fQueueKey];
	
	if(taskQueue != nil)
	{
		CXSVNTask *	nextTask;
		
		[taskQueue removeObject:self];	// dealloc
		if( [taskQueue count] > 0 )
		{
			nextTask = [taskQueue objectAtIndex:0];
			[nextTask execute];
		}
	}
}

- (void) receivedErrorNotification:(NSNotification *)notification
{
	NSData *	data = [[notification userInfo] objectForKey:NSFileHandleNotificationDataItem];

//	NSLog(@"%s error:%@", _cmd, data);
	
	if( data != nil && [data length] > 0 )
	{
		// Notify delegate and stop refresh
		[fDelegate error:UTF8FromData(data) fromTask:self];
		data = nil;
	}
	else
	{
		fStreamCount -= 1;
		if(fStreamCount == 0)
		{
			[self launchNextTask];
		}
		[self release];
	}
	
}

- (void) receivedDataNotification:(NSNotification *)notification
{
	NSData *	data = [[notification userInfo] objectForKey:NSFileHandleNotificationDataItem];

//	NSLog(@"%s data", _cmd);
//	NSLog(@"data:%@", data);
		
	// Continue with incremental reading until there's no more data
	if( data && [data length] > 0 )
	{
		[fDelegate performSelector:fOutputAction withObject:UTF8FromData(data)];
		[fOutHandle readInBackgroundAndNotify];
	}
	else
	{
		[fDelegate performSelector:fOutputAction withObject:nil];
		
		// delete this! balances self-retain in executeWithArgs
		fStreamCount -= 1;
		if(fStreamCount == 0)
		{
			[self launchNextTask];
		}
		[self release];
	}
	
}

+ (CXSVNTask *) launchWithArguments:(NSArray *)arguments notifying:(id)target outputAction:(SEL)action
{
	CXSVNTask *	outTask = [[self alloc] init];
	
	[outTask executeWithArguments:arguments notifying:target outputAction:action];
	
	return [outTask autorelease];
}

// all tasks launched with the same queueKey are on the same queue
+ (CXSVNTask *) launchWithArguments:(NSArray *)arguments notifying:(id)target outputAction:(SEL)action queueKey:(id)key
{
	CXSVNTask *			outTask = [[[self alloc] init] autorelease];
	NSMutableArray *	queueArray;
	BOOL				dropTask = NO;
	
	if( sTaskQueues == nil )
	{
		sTaskQueues = [[NSMutableDictionary alloc] init];
		
	}
	
	outTask->fQueueKey				= [[NSValue valueWithPointer:key] retain];

	outTask->fArguments				= [arguments copy];
	outTask->fOutputAction	= action;
	outTask->fDelegate		= [target retain];
	
	queueArray = [sTaskQueues objectForKey:outTask->fQueueKey];
	if(queueArray == nil)
	{
		queueArray = [NSMutableArray array];
		[sTaskQueues setObject:queueArray forKey:outTask->fQueueKey];
	}
	
	//
	// Coalesce adjacent tasks
	//
	if( [queueArray count] > 0 )
	{
			
		CXSVNTask *	previous = [queueArray lastObject];
		if( [previous isEqual:outTask] )
		{
			NSLog(@"dropping duplicate task %@", arguments);
			outTask = previous;
			dropTask = YES;
		}
	}
	
	if( !dropTask )
	{
		[queueArray addObject:outTask];

		// Launch it if nothing else is executing right now
		if( [queueArray count] == 1 )
		{
			NSLog(@"launching %@", outTask);
			[outTask execute];
		}
	}
	
	return outTask;
}

- (void) executeWithArguments:(NSArray *)arguments notifying:(id)target outputAction:(SEL)action
{
	fOutputAction	= action;
	fArguments				= [arguments retain];
	fDelegate		= [target retain];
}

- (void) execute
{
	NSTask *				task				= [[NSTask alloc] init];
	NSPipe *				errorPipe			= [NSPipe pipe];
	NSPipe *				outPipe				= [NSPipe pipe];
	NSFileHandle *			outputHandle		= [outPipe fileHandleForReading];
	NSFileHandle *			errorHandle			= [errorPipe fileHandleForReading];
	NSNotificationCenter *	notificationCenter	= [NSNotificationCenter defaultCenter];
	
	// TODO: can probably remove these retains and the balancing releases with the new local stream refcount
	// once for output stream
	[self retain];
	
	// once for error stream
	[self retain];
	
	// local stream refcount
	fStreamCount = 2;
	
	[task setLaunchPath:[self pathToSVN]];
	[task setArguments:fArguments];
	[task setStandardOutput:outPipe];
	[task setStandardError:errorPipe];

	NSLog(@"exec svn %@", fArguments);

	[notificationCenter addObserver:self
						selector:@selector(receivedDataNotification:)
						name:NSFileHandleReadCompletionNotification
						object:outputHandle];

	[notificationCenter	addObserver:self
						selector:@selector(receivedErrorNotification:)
						name:NSFileHandleReadCompletionNotification
						object:errorHandle];

	/*[notificationCenter	addObserver:self
						selector:@selector(nodeRefreshTerminated:)
						name:NSTaskDidTerminateNotification
						object:task];
*/

	[fDelegate retain];
	fTask			= task;
	fOutHandle		= [outputHandle retain];
	fErrorHandle	= [errorHandle retain];
	[outputHandle readInBackgroundAndNotify];
	[errorHandle readInBackgroundAndNotify];

	[task launch];
	
//	NSLog(@"%@", task);
}

- (BOOL) isEqual:(CXSVNTask *)otherTask
{
	return ((fDelegate == otherTask->fDelegate)
			&& (fOutputAction == otherTask->fOutputAction));
}

@end

