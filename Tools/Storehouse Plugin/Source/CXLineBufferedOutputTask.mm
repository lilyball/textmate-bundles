//
//  CXLineBufferedOutputTask.mm
//
//  Created by Chris Thomas on 2006-04-27.
//  Copyright 2006 Chris Thomas. All rights reserved.
//

#import "CXLineBufferedOutputTask.h"

@implementation CXLineBufferedOutputTask

- (void)dealloc
{
	[fDataBuffer release];
	[super dealloc];
}

- (void) receivedData:(NSData *)data
{

//	NSLog(@"%s data", _cmd);
//	NSLog(@"data:%@", data);
		
	// Continue with incremental reading until there's no more data
	if( data && [data length] > 0 )
	{
		NSCharacterSet *	newlines = [NSCharacterSet characterSetWithCharactersInString:@"\r\n"];
		NSString *			string;
		NSRange				currentLineRange = NSMakeRange(0,0);

		if( fDataBuffer == nil )
		{
			fDataBuffer = [[NSMutableData alloc] init];
		}
		[fDataBuffer appendData:data];
		
		string = UTF8FromData(fDataBuffer);
		
		// Feed every line ending in newline to the output data.
		while( true )
		{
			UInt32	previousLineEnd = NSMaxRange(currentLineRange);
			
			// Find end of line
			currentLineRange = [string lineRangeForRange:currentLineRange];
			
//			NSLog(@"range:%@ max:%lu length:%lu", NSStringFromRange(currentLineRange), NSMaxRange(currentLineRange), [string length]);
			
			// No newline found: we have only a partial line. Exit.
			if( NSMaxRange(currentLineRange) == [string length]
				&&  !( [string hasSuffix:@"\r"] || [string hasSuffix:@"\n"] ) )
			{
				// Remove lines we previously sent
				if(previousLineEnd != 0)
				{
					[fDataBuffer autorelease];
					fDataBuffer = [[[string substringFromIndex:previousLineEnd] dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
					[fDataBuffer retain];
				}
				
				// Exit
				break;
			}
			// End of buffer. Exit.
			else if( currentLineRange.location == [string length] )
			{
				[fDataBuffer autorelease];
				fDataBuffer = nil;
				break;
			}
			
			// We got a line: ship it.
			NSString *	lineText = [[string substringWithRange:currentLineRange] stringByTrimmingCharactersInSet:newlines];
			
			if( ![lineText isEqualToString:@""] )
			{
				@try
				{
					[fTarget performSelector:fOutputAction withObject:lineText withObject:self];
				}
				@catch(NSException * exception)
				{
					NSLog(@"%s %@", _cmd, exception);
				}
			}
			
			// Next up
			currentLineRange.location	= NSMaxRange(currentLineRange);
			currentLineRange.length		= 0;
		}
		
		// Next data read
		[fOutHandle readInBackgroundAndNotify];
	}
	else
	{
		// Feed any remaining buffered data. Should only be a partial line, if any.
		if([fDataBuffer length] > 0)
		{
			@try
			{
				[fTarget performSelector:fOutputAction withObject:UTF8FromData(fDataBuffer) withObject:self];
			}
			@catch(NSException * exception)
			{
				NSLog(@"%s %@", _cmd, exception);
			}
			[fDataBuffer release];
			fDataBuffer = nil;
		}
		
		// nil to signal end of data
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

@end
