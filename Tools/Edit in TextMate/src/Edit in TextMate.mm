//
//  Edit in TextMate.mm
//
//  Created by Allan Odgaard on 2005-11-26.
//  Copyright (c) 2005 MacroMates. All rights reserved.
//

#import <Carbon/Carbon.h>
#import "Edit in TextMate.h"

// from ODBEditorSuite.h
#define keyFileSender   'FSnd'
#define kODBEditorSuite 'R*ch'
#define kAEModifiedFile 'FMod'
#define kAEClosedFile   'FCls'

static NSMutableDictionary* OpenFiles;
static NSString* TextMateBundleIdentifier = @"com.macromates.textmate";

@implementation EditInTextMate
+ (void)setODBEventHandlers
{
	NSAppleEventManager* eventManager = [NSAppleEventManager sharedAppleEventManager];
	[eventManager setEventHandler:self andSelector:@selector(handleModifiedFileEvent:withReplyEvent:) forEventClass:kODBEditorSuite andEventID:kAEModifiedFile];
	[eventManager setEventHandler:self andSelector:@selector(handleClosedFileEvent:withReplyEvent:) forEventClass:kODBEditorSuite andEventID:kAEClosedFile];
}

+ (void)removeODBEventHandlers
{
	NSAppleEventManager* eventManager = [NSAppleEventManager sharedAppleEventManager];
	[eventManager removeEventHandlerForEventClass:kODBEditorSuite andEventID:kAEModifiedFile];
	[eventManager removeEventHandlerForEventClass:kODBEditorSuite andEventID:kAEClosedFile];
}

+ (BOOL)launchTextMate
{
	NSArray* array = [[NSWorkspace sharedWorkspace] launchedApplications];
	for(unsigned i = [array count]; --i; )
	{
		if([[[array objectAtIndex:i] objectForKey:@"NSApplicationBundleIdentifier"] isEqualToString:TextMateBundleIdentifier])
			return YES;
	}
	return [[NSWorkspace sharedWorkspace] launchAppWithBundleIdentifier:TextMateBundleIdentifier options:0L additionalEventParamDescriptor:nil launchIdentifier:nil];
}

+ (void)asyncEditStringWithOptions:(NSDictionary*)someOptions
{
	NSAutoreleasePool* pool = [NSAutoreleasePool new];

	if(![self launchTextMate])
		return;

	/* =========== */

	NSData* targetBundleID = [TextMateBundleIdentifier dataUsingEncoding:NSUTF8StringEncoding];
	NSAppleEventDescriptor* targetDescriptor = [NSAppleEventDescriptor descriptorWithDescriptorType:typeApplicationBundleID data:targetBundleID];
	NSAppleEventDescriptor* appleEvent = [NSAppleEventDescriptor appleEventWithEventClass:kCoreEventClass eventID:kAEOpenDocuments targetDescriptor:targetDescriptor returnID:kAutoGenerateReturnID transactionID:kAnyTransactionID];
	NSAppleEventDescriptor* replyDescriptor = nil;
	NSAppleEventDescriptor* errorDescriptor = nil;
	AEDesc reply = { typeNull, NULL };														

	NSString* fileName = [someOptions objectForKey:@"fileName"];
	[appleEvent setParamDescriptor:[NSAppleEventDescriptor descriptorWithDescriptorType:typeFileURL data:[[[NSURL fileURLWithPath:fileName] absoluteString] dataUsingEncoding:NSUTF8StringEncoding]] forKeyword:keyDirectObject];

	UInt32 packageType = 0, packageCreator = 0;
	CFBundleGetPackageInfo(CFBundleGetMainBundle(), &packageType, &packageCreator);
	[appleEvent setParamDescriptor:[NSAppleEventDescriptor descriptorWithTypeCode:packageCreator] forKeyword:keyFileSender];

	OSStatus status = AESend([appleEvent aeDesc], &reply, kAEWaitReply, kAENormalPriority, kAEDefaultTimeout, NULL, NULL);
	if(status == noErr)
	{
		replyDescriptor = [[[NSAppleEventDescriptor alloc] initWithAEDescNoCopy:&reply] autorelease];
		errorDescriptor = [replyDescriptor paramDescriptorForKeyword:keyErrorNumber];
		if(errorDescriptor != nil)
			status = [errorDescriptor int32Value];
		
		if(status != noErr)
			NSLog(@"%s error %d", _cmd, status), NSBeep();
	}

	[pool release];
}

+ (void)externalEditString:(NSString*)aString forView:(NSView*)aView
{
	NSString* appName = [[[[NSWorkspace sharedWorkspace] activeApplication] objectForKey:@"NSApplicationName"] lowercaseString];
	NSString* windowTitle = [[aView window] title] ?: @"untitled";
	windowTitle = [[windowTitle componentsSeparatedByString:@"/"] componentsJoinedByString:@"-"];

	NSString* fileName = [NSString stringWithFormat:@"%@/%@.%@", NSTemporaryDirectory(), windowTitle, appName];
	for(unsigned i = 2; [[NSFileManager defaultManager] fileExistsAtPath:fileName]; i++)
		fileName = [NSString stringWithFormat:@"%@/%@ %u.%@", NSTemporaryDirectory(), windowTitle, i, appName];

	[[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileName atomically:NO];
	fileName = [fileName stringByStandardizingPath];

	NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:
		aString,    @"string",
		aView,      @"view",
		fileName,   @"fileName",
		nil];

	[OpenFiles setObject:options forKey:fileName];
	if([OpenFiles count] == 1)
		[self setODBEventHandlers];
	[NSThread detachNewThreadSelector:@selector(asyncEditStringWithOptions:) toTarget:self withObject:options];
}

+ (void)handleModifiedFileEvent:(NSAppleEventDescriptor*)event withReplyEvent:(NSAppleEventDescriptor*)replyEvent
{
	NSAppleEventDescriptor* fileURL = [[event paramDescriptorForKeyword:keyDirectObject] coerceToDescriptorType:typeFileURL];
	NSString* urlString = [[[NSString alloc] initWithData:[fileURL data] encoding:NSUTF8StringEncoding] autorelease];
	NSString* fileName = [[[NSURL URLWithString:urlString] path] stringByStandardizingPath];

	NSView* view = [[OpenFiles objectForKey:fileName] objectForKey:@"view"];
	if([view window] && [view respondsToSelector:@selector(didModifyString:)])
	{
		[view performSelector:@selector(didModifyString:) withObject:[NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil]];
	}
	else
	{
		NSLog(@"%s view %p, %@, window %@", _cmd, view, view, [view window]);
		NSLog(@"%s file name %@, options %@", _cmd, fileName, [[OpenFiles objectForKey:fileName] description]);
		NSLog(@"%s all %@", _cmd, [OpenFiles description]);
		NSBeep();
	}
}

+ (void)handleClosedFileEvent:(NSAppleEventDescriptor*)event withReplyEvent:(NSAppleEventDescriptor*)replyEvent
{
	NSAppleEventDescriptor* fileURL = [[event paramDescriptorForKeyword:keyDirectObject] coerceToDescriptorType:typeFileURL];
	NSString* urlString = [[[NSString alloc] initWithData:[fileURL data] encoding:NSUTF8StringEncoding] autorelease];
	NSString* fileName = [[[NSURL URLWithString:urlString] path] stringByStandardizingPath];
	[[NSFileManager defaultManager] removeFileAtPath:fileName handler:nil];
	[[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
	[OpenFiles removeObjectForKey:fileName];
	if([OpenFiles count] == 0)
		[self removeODBEventHandlers];
}

+ (NSMenu*)findEditMenu
{
	NSMenu* mainMenu = [NSApp mainMenu];
	for(int i = 0; i != [mainMenu numberOfItems]; i++)
	{
		NSMenu* candidate = [[mainMenu itemAtIndex:i] submenu];
		static SEL const actions[] = { @selector(undo:), @selector(redo:), @selector(cut:), @selector(copy:), @selector(paste:), @selector(delete:), @selector(selectAll:) };
		for(int j = 0; j != sizeof(actions)/sizeof(actions[0]); j++)
		{
			if(-1 != [candidate indexOfItemWithTarget:nil andAction:actions[j]])
				return candidate;
		}
	}
	return nil;
}

+ (void)installMenuItem:(id)sender
{
	if(NSMenu* editMenu = [self findEditMenu])
	{
		[editMenu addItem:[NSMenuItem separatorItem]];
		id <NSMenuItem> menuItem = [editMenu addItemWithTitle:[NSString stringWithUTF8String:"Edit in TextMate…"] action:@selector(editInTextMate:) keyEquivalent:@"e"];
		[menuItem setKeyEquivalentModifierMask:NSControlKeyMask | NSCommandKeyMask];
	}
}

+ (void)load
{
	OpenFiles = [NSMutableDictionary new];
//	NSString* bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
	if([[NSUserDefaults standardUserDefaults] boolForKey:@"DisableEditInTextMateMenuItem"] == NO)
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(installMenuItem:) name:NSApplicationDidFinishLaunchingNotification object:[NSApplication sharedApplication]];
}
@end
