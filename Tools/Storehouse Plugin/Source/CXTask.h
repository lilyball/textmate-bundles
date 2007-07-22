//
//  CXTask.h
//
//	Simplified tasking interface with support for independently queued tasks.
//
//  Created by Chris Thomas on 2006-01-21.
//  Copyright 2006 Chris Thomas. All rights reserved.
//

#ifndef _CXTASK_H_
#define _CXTASK_H_

@interface CXTask : NSObject
{
	NSString *				fDisplayName;	// name for user display (may be nil)
	UInt32					fStreamCount;	// number of open file handles
	id 						fQueueKey;		// key for queuing
	NSTask *				fTask;			// base task
	NSString *				fCommand;		// launch path
	NSArray *				fArguments;		// arguments
	NSFileHandle *			fOutHandle;		// output filehandle
	NSFileHandle *			fErrorHandle;	// error filehandle
	id 						fTarget;		// target of action selectors
	SEL						fOutputAction;	// normal text output SEL
	SEL						fErrorAction;	// error text output SEL
	NSMutableDictionary *	fUserInfo;		// user info dictionary
	BOOL					fForegroundTask;
}

//
// Tasks with identical queueKeys are serialized on the same queue.
//
+ (CXTask *) launchCommand:(NSString *)command
				withArguments:(NSArray *)arguments
				notifying:(id)target
				outputAction:(SEL)outputAction
				errorAction:(SEL)errorAction
				queueKey:(id)key	// may be nil to execute without queueing
				userInfo:(NSDictionary *)info;	// may be nil

// Two-step launch allows additional options to be set
+ (id) taskForCommand:(NSString *)command
				withArguments:(NSArray *)arguments
				notifying:(id)target
				outputAction:(SEL)outputAction
				errorAction:(SEL)errorAction
				queueKey:(id)key
				userInfo:(NSDictionary *)info;

- (void) launch;

- (void) setDisplayName:(NSString *)name;

- (BOOL)blockUntilExit;
- (void)setBlockUntilExit:(BOOL)newBlockUntilExit;

// user info dictionary
- (NSDictionary *)userInfo;
- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;


// Subclass use only
- (void) launchNextTask;

@end

@interface NSObject (CXTaskTarget)
- (void) taskExited:(CXTask *)task withStatus:(int)terminationStatus;
@end

#ifdef __cplusplus
extern "C" {
#endif

NSString * UTF8FromData( NSData * data );

#ifdef __cplusplus
}
#endif

#endif /* _CXTASK_H_ */


