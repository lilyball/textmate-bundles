//
//  CLIProxy.h
//  Dialog2
//
//  Created by Ciaran Walsh on 16/02/2008.
//

#import <Cocoa/Cocoa.h>
#import "OptionParser.h"

@interface CLIProxy : NSObject
{
	NSDictionary* 	environment;
	NSString* 		workingDirectory;

	NSFileHandle* inputHandle;
	NSFileHandle* outputHandle;
	NSFileHandle* errorHandle;

	option_t const*	optionTemplate;
	size_t				optionCount;
	NSArray* 			arguments;
	NSDictionary*		parsedOptions;

	NSDictionary*		parameters;
}
+ (id)proxyWithOptions:(NSDictionary*)options;
- (id)initWithOptions:(NSDictionary*)options;

- (void)writeStringToOutput:(NSString*)text;
- (void)writeStringToError:(NSString*)text;
- (id)readPropertyListFromInput;

- (NSDictionary*)parameters;

- (NSFileHandle*)inputHandle;
- (NSFileHandle*)outputHandle;
- (NSFileHandle*)errorHandle;

- (NSDictionary*)environment;

- (NSString*)workingDirectory;

- (NSString*)argumentAtIndex:(int)index;
- (int)numberOfArguments;

- (id)valueForOption:(NSString*)option;
- (void)setOptionTemplate:(option_t const*)options count:(size_t)count;
@end

template <size_t optionCount> void SetOptionTemplate(CLIProxy* proxy, option_t const (&options)[optionCount])
{
	[proxy setOptionTemplate:options count:optionCount];
}