//
//  CXTask.m
//
//	Simplified tasking interface with support for independently queued tasks.
//
//  Created by Chris Thomas on 2006-01-21.
//  Copyright 2006 Chris Thomas. All rights reserved.
//

#import "CXTask.h"

@interface CXTask(Private)
- (void) execute;
- (void) receivedData:(NSData *)data;
@end

NSString * UTF8FromData( NSData * data )
{
	NSString *		string;

	string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
//	NSLog(@"utf8fromdata: %@\n=========", string );
	
	return [string autorelease];
}

@implementation CXTask

static NSMutableDictionary	* sTaskQueues = nil;

- (NSString *) description
{
	NSString *	description = [super description];
	
	return [NSString stringWithFormat:@"%@ cmd:%@ args:%@", description, fCommand, fArguments];
}

- (void) dealloc
{
	[fUserInfo release];
	[fTask release];
	[fOutHandle release];
	[fErrorHandle release];
	
	[fArguments release];
	[fTarget release];
	fTarget	= nil;
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
	
	[fTask waitUntilExit];
	
	@try
	{
		[fTarget taskExited:self withStatus:[fTask terminationStatus]];
	}
	@catch(NSException * exception)
	{
		NSLog(@"%s %@", _cmd, exception);
	}
		
	if(taskQueue != nil)
	{
		CXTask *	nextTask;
		
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

	if( data != nil && [data length] > 0 )
	{
		// Notify Target and stop refresh
		@try
		{
			[fTarget performSelector:fErrorAction  withObject:UTF8FromData(data) withObject:self];
		}
		@catch(NSException * exception)
		{
			NSLog(@"%s %@", _cmd, exception);
		}
		[fErrorHandle readInBackgroundAndNotify];
	}
	else
	{
		fStreamCount -= 1;
		if(fStreamCount == 0)
		{
			[self launchNextTask];
			[self release];
		}
	}
	
}

- (void) receivedDataNotification:(NSNotification *)notification
{
	NSData *	data = [[notification userInfo] objectForKey:NSFileHandleNotificationDataItem];	
	
	[self receivedData:data];
}


- (void) receivedData:(NSData *)data
{		
	// Continue with incremental reading until there's no more data
	if( data && [data length] > 0 )
	{
		@try
		{
			[fTarget performSelector:fOutputAction withObject:UTF8FromData(data) withObject:self];
		}
		@catch(NSException * exception)
		{
			NSLog(@"%s %@", _cmd, exception);
		}
		
		[fOutHandle readInBackgroundAndNotify];
	}
	else
	{
		@try
		{
			[fTarget performSelector:fOutputAction withObject:nil withObject:self];
		}
		@catch(NSException * exception)
		{
			NSLog(@"%s %@", _cmd, exception);
		}
				
		// delete this! balances self-retain in executeWithArgs
		fStreamCount -= 1;
		if(fStreamCount == 0)
		{
			[self launchNextTask];
			[self release];
		}
	}
	
}


+ (id) taskForCommand:(NSString *)command
				withArguments:(NSArray *)arguments
				notifying:(id)target
				outputAction:(SEL)outputAction
				errorAction:(SEL)errorAction
				queueKey:(id)key
				userInfo:(NSDictionary *)info
{

	CXTask *			outTask = [[[self alloc] init] autorelease];

	outTask->fCommand			= [command copy];
	outTask->fArguments			= [arguments copy];
	outTask->fOutputAction		= outputAction;
	outTask->fErrorAction		= errorAction;
	outTask->fTarget			= [target retain];
	
	if(key != nil)
	{
		outTask->fQueueKey			= [[NSValue valueWithPointer:key] retain];
	}
	
	if(info != nil)
	{
		if( [info isKindOfClass:[NSMutableDictionary class]] )
		{
			outTask->fUserInfo = (NSMutableDictionary *)info;
			[outTask->fUserInfo retain];
		}
		else
		{
			outTask->fUserInfo = [info mutableCopy];
		}
	}
	
	return outTask;
}

- (void) launch
{
	NSMutableArray *	queueArray;
	BOOL				dropTask = NO;

	if( fQueueKey == nil )
	{
		[self execute];
	}
	else
	{
		if( sTaskQueues == nil )
		{
			sTaskQueues = [[NSMutableDictionary alloc] init];
		}

		queueArray = [sTaskQueues objectForKey:fQueueKey];
		if(queueArray == nil)
		{
			queueArray = [NSMutableArray array];
			[sTaskQueues setObject:queueArray forKey:fQueueKey];
		}

		//
		// Coalesce adjacent tasks
		// FIXME: make coalescing optional
		//
//		NSLog(@"%s%@", _cmd, queueArray);

		if( [queueArray count] > 0 )
		{
			CXTask *	previous = [queueArray lastObject];
			if( [previous isEqual:self] )
			{
				NSLog(@"dropping duplicate task %@", fArguments);
				dropTask = YES;
			}
		}

		if( !dropTask )
		{
			[queueArray addObject:self];

			// Launch it if nothing else is executing right now
			if( [queueArray count] == 1 )
			{
//				NSLog(@"launching %@", self);
				[self execute];
			}
		}
	}
}

- (void) waitUntilExit
{
	[fTask waitUntilExit];
}

// all tasks launched with the same queueKey are on the same queue
+ (CXTask *) launchCommand:(NSString *)command
				withArguments:(NSArray *)arguments
				notifying:(id)target
				outputAction:(SEL)outputAction
				errorAction:(SEL)errorAction
				queueKey:(id)key
				userInfo:(NSDictionary *)info
{
	CXTask *			outTask = [self taskForCommand:command withArguments:arguments
										notifying:target
										outputAction:outputAction
										errorAction:errorAction
										queueKey:key
										userInfo:info];
	[outTask launch];
	return outTask;
}

- (void) execute
{
	NSTask *				task				= [[NSTask alloc] init];
	NSPipe *				errorPipe			= [NSPipe pipe];
	NSPipe *				outPipe				= [NSPipe pipe];
	NSFileHandle *			outputHandle		= [outPipe fileHandleForReading];
	NSFileHandle *			errorHandle			= [errorPipe fileHandleForReading];
	NSNotificationCenter *	notificationCenter	= [NSNotificationCenter defaultCenter];

	[self retain];
		
	// local stream refcount
	fStreamCount = 2;
	
	[task setLaunchPath:fCommand];
	[task setArguments:fArguments];
	[task setStandardOutput:outPipe];
	[task setStandardError:errorPipe];

//	NSLog(@"exec %@", fArguments);


	[fTarget retain];
	fTask			= task;
	fOutHandle		= [outputHandle retain];
	fErrorHandle	= [errorHandle retain];

	if( fForegroundTask )
	{
		NSData *	data;
		
		[task launch];
		do
		{
			data = [outputHandle availableData];
			if( [data length] > 0 )
			{
				[self receivedData:data];
			}
		} while ([data length] > 0);
		
		do
		{
			data = [errorHandle availableData];
			if( [data length] > 0 )
			{
				@try
				{
					[fTarget performSelector:fErrorAction withObject:UTF8FromData(data) withObject:self];
				}
				@catch(NSException * exception)
				{
					NSLog(@"%s %@", _cmd, exception);
				}

			}
		} while ([data length] > 0);
	}
	else
	{
		[notificationCenter addObserver:self
							selector:@selector(receivedDataNotification:)
							name:NSFileHandleReadCompletionNotification
							object:outputHandle];

		[notificationCenter	addObserver:self
							selector:@selector(receivedErrorNotification:)
							name:NSFileHandleReadCompletionNotification
							object:errorHandle];
		
		[outputHandle readInBackgroundAndNotify];
		[errorHandle readInBackgroundAndNotify];
		[task launch];
	}

	
}

- (BOOL)blockUntilExit
{
	return fForegroundTask;
}

- (void)setBlockUntilExit:(BOOL)newBlockUntilExit
{
	fForegroundTask = newBlockUntilExit;
}


- (BOOL) isEqual:(CXTask *)otherTask
{
	return ((fTarget == otherTask->fTarget)
			&& (fOutputAction == otherTask->fOutputAction)
			&& [fArguments isEqual:otherTask->fArguments]);
}


#if 0
#pragma mark -
#pragma mark Process Control Protocol
#endif

- (BOOL) isIndeterminate
{
	return YES;
}

- (void) setDisplayName:(NSString *)name
{
	NSString * oldName = fDisplayName;
	fDisplayName = [name copy];
	[oldName release];
}

- (NSString *)displayName
{
	NSString *	name = fDisplayName;
	
	if( name == nil )
	{
	 	name = [NSString stringWithFormat:@"%@ %@", fCommand, [fArguments componentsJoinedByString:@" "]];
	}

	return name;
}

- (BOOL) isRunning
{
	return [fTask isRunning];
}

- (void) terminate
{
	[fTask terminate];
}

#if 0
#pragma mark -
#pragma mark User Info
#endif

- (NSDictionary *)userInfo
{
	return fUserInfo;
}

- (id)valueForKey:(NSString *)key
{
	return [fUserInfo objectForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
	if(fUserInfo == nil)
	{
		fUserInfo = [[NSMutableDictionary alloc] init];
	}
	[fUserInfo setObject:value forKey:key];
}

@end

