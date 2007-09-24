@interface TMDCommand : NSObject
+ (void)registerObject:(id)anObject forCommand:(NSString*)aCommand;
+ (id)objectForCommand:(NSString*)aCommand;

+ (id)readPropertyList:(NSFileHandle*)aFileHandle;
+ (void)writePropertyList:(id)aPlist toFileHandle:(NSFileHandle*)aFileHandle;
@end
