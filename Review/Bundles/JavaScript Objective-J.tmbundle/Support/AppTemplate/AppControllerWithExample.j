import <Foundation/CPObject.j>


@implementation AppController : CPObject
{
  CPWindow HUDWindow;
  CPWindow theWindow;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
  
  // Only an example
  theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
    contentView = [theWindow contentView];
  
  [contentView setBackgroundColor:[CPColor grayColor]];
  
  HUDWindow = [[CPWindow alloc] initWithContentRect:CGRectMake(10, 10, 300, 125)
      styleMask:CPHUDBackgroundWindowMask | CPClosableWindowMask | CPResizableWindowMask];

  [HUDWindow setTitle:"Hello"];
  [HUDWindow setShowsResizeIndicator:YES];
  [HUDWindow orderFront:self];
  [HUDWindow setMinSize:CPSizeMake(200,150)];
  
  var name = [[CPTextField alloc] initWithFrame:CPRectMake(5, 5, 280, 120)];
  [name setStringValue:@"#{author}"];
  [name setEditable:YES];
  [name setFont:[CPFont systemFontOfSize:12.0]];
  [name sizeToFit];
  [name setTextColor:[CPColor redColor]];

  [[HUDWindow contentView] addSubview:name];

  label = [[CPTextField alloc] initWithFrame:CGRectMake(0,0,300,80)];
  
  [label setStringValue:@"Please press me"];
  [label setFont:[CPFont systemFontOfSize:14.0]];
  [label setLineBreakMode:CPLineBreakByWordWrapping];
  
  [label sizeToFit];
  
  [label setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
  [label setFrameOrigin:CGPointMake((CGRectGetWidth([contentView bounds]) - CGRectGetWidth([label frame])) / 2.0, (CGRectGetHeight([contentView bounds]) - CGRectGetHeight([label frame])) / 2.0)];
  
  [contentView addSubview:label];

  var button = [[CPButton alloc] initWithFrame: CGRectMake(
                  CGRectGetWidth([contentView bounds])/2.0 - 40,
                  CGRectGetMaxY([label frame]) + 10,
                  80, 18
               )];

  [button setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | 
                              CPViewMinYMargin | CPViewMaxYMargin];
  [button setTitle:"open"];
  [button setTarget:self];
  [button setAction:@selector(openHUD:)];                

  [contentView addSubview:button];

  [theWindow orderFront:self];
  
  // Uncomment the following line to turn on the standard menu bar.
  // [CPMenu setMenuBarVisible:YES];
}

- (void)openHUD:(id)sender
{
  [HUDWindow orderFront:self];
}

@end