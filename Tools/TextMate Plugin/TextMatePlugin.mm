//
//  ÇPROJECTNAMEÈ.mm
//  ÇPROJECTNAMEÈ
//
//  Created by ÇFULLUSERNAMEÈ on ÇDATEÈ.
//  Copyright ÇYEARÈ ÇORGANIZATIONNAMEÈ. All rights reserved.
//

#import "ÇPROJECTNAMEÈ.h"
#import "MethodSwizzle.h"

@implementation ÇPROJECTNAMEÈ

- (id)initWithPlugInController:(id <TMPlugInController>)aController
{
	self = [self init];
	NSApp = [NSApplication sharedApplication];

	return self;
}
@end
