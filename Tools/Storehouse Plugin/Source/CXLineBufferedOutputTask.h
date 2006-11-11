//
//  CXLineBufferedOutputTask.mm
//
//  Created by Chris Thomas on 2006-04-27.
//  Copyright 2006 Chris Thomas. All rights reserved.
//

#import "CXTask.h"

@interface CXLineBufferedOutputTask : CXTask
{
	NSMutableData *	fDataBuffer;
}
@end
