import <Foundation/CPObject.j>


@implementation AppController : CPObject
{

}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{

  theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
    contentView = [theWindow contentView];



  [theWindow orderFront:self];

  // Uncomment the following line to turn on the standard menu bar.
  // [CPMenu setMenuBarVisible:YES];


}


@end