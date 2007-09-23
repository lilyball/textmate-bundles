#import "TMDCommand.h"

static NSMutableDictionary* Commands = nil;

@implementation TMDCommand
+ (void)registerObject:(id)anObject forCommand:(NSString*)aCommand
{
	if(!Commands)
		Commands = [NSMutableDictionary new];
	[Commands setObject:anObject forKey:aCommand];
}

+ (id)objectForCommand:(NSString*)aCommand
{
	return [Commands objectForKey:aCommand];
}

+ (id)readPropertyList:(NSFileHandle*)aFileHandle
{
	NSData* data = [aFileHandle readDataToEndOfFile];
	if([data length] == 0)
		return nil;

	NSString* error = nil;
	id plist = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListMutableContainersAndLeaves format:nil errorDescription:&error];

	if(error || !plist)
	{
		fprintf(stderr, "%s\n", [error UTF8String] ?: "unknown error parsing property list");
		fwrite([data bytes], [data length], 1, stderr);
		fprintf(stderr, "\n");
	}

	return plist;
}

+ (void)writePropertyList:(id)aPlist toFileHandle:(NSFileHandle*)aFileHandle
{
	NSString* error = nil;
	if(NSData* data = [NSPropertyListSerialization dataFromPropertyList:aPlist format:NSPropertyListXMLFormat_v1_0 errorDescription:&error])
	{
		[aFileHandle writeData:data];
	}
	else
	{
		fprintf(stderr, "%s\n", [error UTF8String] ?: "unknown error serializing returned property list");
		fprintf(stderr, "%s\n", [[aPlist description] UTF8String]);
	}
}
@end
