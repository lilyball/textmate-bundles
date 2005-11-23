
@interface CXSVNTask : NSObject
{
	UInt32			fStreamCount;
	id 				fQueueKey;
	NSTask *		fTask;
	NSArray *		fArguments;
	NSFileHandle *	fOutHandle;
	NSFileHandle *	fErrorHandle;
	id 				fDelegate;
	SEL				fOutputAction;
}

+ (CXSVNTask *) launchWithArguments:(NSArray *)arguments notifying:(id)target outputAction:(SEL)action queueKey:(id)key;

@end

@interface NSObject(CXSVNTaskDelegate)
- (void) error:(NSString *)string fromTask:(CXSVNTask *)task;
@end