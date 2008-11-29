//
//  ÇPROJECTNAMEÈ.h
//  ÇPROJECTNAMEÈ
//
//  Created by ÇFULLUSERNAMEÈ on ÇDATEÈ.
//  Copyright ÇYEARÈ ÇORGANIZATIONNAMEÈ. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol TMPlugInController
- (float)version;
@end

@interface ÇPROJECTNAMEÈ : NSObject
{
}
- (id)initWithPlugInController:(id <TMPlugInController>)aController;
@end