#import <Carbon/Carbon.h>
#import <string>
#import "Dialog.h"

NSLock* Lock = [NSLock new];

// Apple ought to document this <rdar://4821265>
@interface NSMethodSignature (Undocumented)
+(NSMethodSignature*)signatureWithObjCTypes:(const char*)types;
@end

@interface Dialog : NSObject <TextMateDialogServerProtocol>
{
}
- (id)initWithPlugInController:(id <TMPlugInController>)aController;
@end

@interface NibLoader : NSObject
{
	NSMutableDictionary* parameters;
	NSMutableArray* topLevelObjects;
	NSWindow* window;
	BOOL isModal;
	BOOL center;
	BOOL didLock;
}
- (NSDictionary*)instantiateNib:(NSNib*)aNib;
@end

@implementation NibLoader
- (id)initWithParameters:(NSMutableDictionary*)someParameters modal:(BOOL)flag center:(BOOL)shouldCenter
{
	if(self = [super init])
	{
		parameters = [someParameters retain];
		[parameters setObject:self forKey:@"controller"];
		isModal = flag;
		center = shouldCenter;
	}
	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	enumerate(topLevelObjects, id object)
		[object release];
	[topLevelObjects release];
	[parameters release];

	[super dealloc];
}

- (void)lock
{
	[Lock lock];
	didLock = YES;
}

- (void)unlock
{
	if(didLock)
		[Lock unlock];
	didLock = NO;
}

- (void)setWindow:(NSWindow*)aWindow
{
	if(window != aWindow)
	{
		[window setDelegate:nil];
		[window release];
		window = [aWindow retain];
		[window setDelegate:self];
	}
}

- (void)cleanupAndRelease
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[parameters removeObjectForKey:@"controller"];

	enumerate(topLevelObjects, id object)
	{
		if([object isKindOfClass:[NSObjectController class]])
		{
			[object commitEditing];

			// if we do not manually unbind, the object in the nib will keep us retained, and thus we will never reach dealloc
			[object unbind:@"contentObject"];
		}
	}
	[self setWindow:nil];

	if(isModal)
		[NSApp stopModal];

	[self unlock];
	[self autorelease];
}

- (void)windowWillClose:(NSNotification*)aNotification
{
	[self cleanupAndRelease];
}

- (void)performButtonClick:(id)sender
{
	if([sender respondsToSelector:@selector(title)])
		[parameters setObject:[sender title] forKey:@"returnButton"];
	if([sender respondsToSelector:@selector(tag)])
		[parameters setObject:[NSNumber numberWithInt:[sender tag]] forKey:@"returnCode"];

	[window orderOut:self];
	[self cleanupAndRelease];
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector
{
	NSString* str = NSStringFromSelector(aSelector);
	if([str hasPrefix:@"returnArgument:"])
	{
		std::string types;
		types += @encode(void);
		types += @encode(id);
		types += @encode(SEL);
	
		unsigned numberOfArgs = [[str componentsSeparatedByString:@":"] count];
		while(numberOfArgs-- > 1)
			types += @encode(id);
	
		return [NSMethodSignature signatureWithObjCTypes:types.c_str()];
	}
	return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation*)invocation
{
	NSString* str = NSStringFromSelector([invocation selector]);
	if([str hasPrefix:@"returnArgument:"])
	{
		NSArray* argNames = [str componentsSeparatedByString:@":"];

		NSMutableDictionary* dict = [NSMutableDictionary dictionary];
		for(size_t i = 2; i < [[invocation methodSignature] numberOfArguments]; ++i)
		{
			id arg = nil;
			[invocation getArgument:&arg atIndex:i];
			[dict setObject:arg forKey:[argNames objectAtIndex:i - 2]];
		}
		[parameters setObject:dict forKey:@"result"];

		[window orderOut:self];
		[self cleanupAndRelease];
	}
	else
	{
		[super forwardInvocation:invocation];
	}
}

- (void)connectionDidDie:(NSNotification*)aNotification
{
	[window orderOut:self];
	[self cleanupAndRelease];

	// post dummy event, since the system has a tendency to stall the next event, after replying to a DO message where the receiver has disappeared, posting this dummy event seems to solve it
	[NSApp postEvent:[NSEvent otherEventWithType:NSApplicationDefined location:NSZeroPoint modifierFlags:0 timestamp:0.0f windowNumber:0 context:nil subtype:0 data1:0 data2:0] atStart:NO];
}

- (NSDictionary*)instantiateNib:(NSNib*)aNib
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionDidDie:) name:NSPortDidBecomeInvalidNotification object:nil];

	BOOL didInstantiate = NO;
	@try {
	 	didInstantiate = [aNib instantiateNibWithOwner:self topLevelObjects:&topLevelObjects];
	}
	@catch(NSException* e) {
		// our retain count is too high if we reach this branch (<rdar://4803521>) so no RAII idioms for Cocoa, which is why we have the didLock variable, etc.
		NSLog(@"%s failed to instantiate nib (%@)", _cmd, [e reason]);
	}

	[topLevelObjects retain];
	enumerate(topLevelObjects, id object)
	{
		if([object isKindOfClass:[NSWindow class]])
			[self setWindow:object];
	}
	
	if(window)
	{
		[self lock];

		if(center)
		{
			if(NSWindow* keyWindow = [NSApp keyWindow])
			{
				NSRect frame = [window frame], parentFrame = [keyWindow frame];
				[window setFrame:NSMakeRect(NSMidX(parentFrame) - 0.5 * NSWidth(frame), NSMidY(parentFrame) - 0.5 * NSHeight(frame), NSWidth(frame), NSHeight(frame)) display:NO];
			}
			else
			{
				[window center];
			}
		}

		[window makeKeyAndOrderFront:self];
		if(isModal && window)
			[NSApp runModalForWindow:window];
	}
	else
	{
		NSLog(@"%s didn't find a window in nib", _cmd);
		[self cleanupAndRelease];
	}

	return parameters;
}
@end

@interface NSObject (OakTextView)
- (NSPoint)positionForWindowUnderCaret;
@end

@implementation Dialog
- (id)initWithPlugInController:(id <TMPlugInController>)aController
{
	NSApp = [NSApplication sharedApplication];
	if(self = [super init])
		[NSThread detachNewThreadSelector:@selector(vendObject:) toTarget:self withObject:nil];
	return self;
}

- (int)textMateDialogServerProtocolVersion
{
	return TextMateDialogServerProtocolVersion;
}

- (id)showNib:(NSString*)aNibPath withParameters:(id)someParameters modal:(BOOL)flag center:(BOOL)shouldCenter
{
	if(![[NSFileManager defaultManager] fileExistsAtPath:aNibPath])
	{
		NSLog(@"%s nib file not found: %@", _cmd, aNibPath);
		return nil;
	}

	NSNib* nib = [[[NSNib alloc] initWithContentsOfURL:[NSURL fileURLWithPath:aNibPath]] autorelease];
	if(!nib)
	{
		NSLog(@"%s failed loading nib: %@", _cmd, aNibPath);
		return nil;
	}

	NibLoader* nibOwner = [[NibLoader alloc] initWithParameters:someParameters modal:flag center:shouldCenter];
	if(!nibOwner)
		NSLog(@"%s couldn't create nib loader", _cmd);
	[nibOwner performSelectorOnMainThread:@selector(instantiateNib:) withObject:nib waitUntilDone:YES];
	[Lock lock];
	[Lock unlock];

	return someParameters;
}

- (id)showMenuWithOptions:(NSDictionary*)someOptions
{
	NSMutableDictionary* res = [[someOptions mutableCopy] autorelease];
	[self performSelectorOnMainThread:@selector(showMenuWithOptionsHelper:) withObject:res waitUntilDone:YES];
	return res;
}

- (void)showMenuWithOptionsHelper:(NSMutableDictionary*)someOptions
{
	MenuRef menu_ref;
	CreateNewMenu(0 /* menu id */, kMenuAttrDoNotCacheImage, &menu_ref);
	SetMenuFont(menu_ref, 0, [[NSUserDefaults standardUserDefaults] integerForKey:@"OakBundleManagerDisambiguateMenuFontSize"] ?: 12);

	int item_id = 0, item_index = 0;
	NSArray* menuItems = [[[someOptions objectForKey:@"menuItems"] retain] autorelease];
	enumerate(menuItems, NSDictionary* menuItem)
	{
		if([[menuItem objectForKey:@"separator"] intValue])
		{
			AppendMenuItemTextWithCFString(menu_ref, CFSTR(""), kMenuItemAttrSeparator, item_index++, NULL);
		}
		else
		{
			MenuItemIndex index;
			AppendMenuItemTextWithCFString(menu_ref, (CFStringRef)[menuItem objectForKey:@"title"], 0, item_index++, &index);
			if(++item_id <= 10)
			{
				SetMenuItemCommandKey(menu_ref, index, NO, item_id == 10 ? '0' : '1' + (item_id-1));
				SetMenuItemModifiers(menu_ref, index, kMenuNoCommandModifier);
			}
			// SetMenuItemIndent(menu_ref, index, 1);
		}
		// AppendMenuItemTextWithCFString(menu_ref, NULL, kMenuItemAttrSectionHeader, 0, NULL);
	}

	NSPoint pos = NSZeroPoint;
	if(id textView = [NSApp targetForAction:@selector(positionForWindowUnderCaret)])
		pos = [textView positionForWindowUnderCaret];

	NSRect mainScreen = [[NSScreen mainScreen] frame];
	enumerate([NSScreen screens], NSScreen* candidate)
	{
		if(NSMinX([candidate frame]) == 0.0f && NSMinY([candidate frame]) == 0.0f)
			mainScreen = [candidate frame];
	}

	short top = lroundf(NSMaxY(mainScreen) - pos.y);
	short left = lroundf(pos.x - NSMinX(mainScreen));
	long res = PopUpMenuSelect(menu_ref, top, left, 0 /* pop-up item */);

	[someOptions removeAllObjects];
	if(res != 0)
	{
		MenuCommand cmd = 0;
		GetMenuItemCommandID(menu_ref, res, &cmd);
		[someOptions setObject:[NSNumber numberWithUnsignedInt:(unsigned)cmd] forKey:@"selectedIndex"];
		[someOptions setObject:[menuItems objectAtIndex:(unsigned)cmd] forKey:@"selectedMenuItem"];
	}

	DisposeMenu(menu_ref);
}

- (void)vendObject:(id)arguments
{
	NSAutoreleasePool* pool = [NSAutoreleasePool new];
	
	NSConnection* connection = [NSConnection defaultConnection];
	[connection setRootObject:self];
	if([connection registerName:@"TextMate dialog server"] == NO)
		NSLog(@"couldn't setup TextMate dialog server."), NSBeep();

	[[NSRunLoop currentRunLoop] run];

	[pool release];
}
@end
