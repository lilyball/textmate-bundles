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

@implementation EditInTextMate
+ (void)willProcessFirstEventNotification:(id)aNotification
{
	NSAppleEventManager* eventManager = [NSAppleEventManager sharedAppleEventManager];
	[eventManager setEventHandler:self andSelector:@selector(handleModifiedFileEvent:withReplyEvent:) forEventClass:kODBEditorSuite andEventID:kAEModifiedFile];
	[eventManager setEventHandler:self andSelector:@selector(handleClosedFileEvent:withReplyEvent:) forEventClass:kODBEditorSuite andEventID:kAEClosedFile];
}

+ (void)asyncEditStringWithOptions:(NSDictionary*)someOptions
{
	NSAutoreleasePool* pool = [NSAutoreleasePool new];

	BOOL success = [[NSWorkspace sharedWorkspace] launchAppWithBundleIdentifier:@"com.macromates.textmate" options:0L additionalEventParamDescriptor:nil launchIdentifier:nil];
	if(!success)
		return;

	/* =========== */

	NSData* targetBundleID = [@"com.macromates.textmate" dataUsingEncoding:NSUTF8StringEncoding];
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
			return;
	}

	[pool release];
}

+ (void)externalEditString:(NSString*)aString forView:(NSView*)aView
{
	NSString* appName = [[[[NSWorkspace sharedWorkspace] activeApplication] objectForKey:@"NSApplicationName"] lowercaseString];
	NSString* windowTitle = [[aView window] title] ?: @"untitled";
	windowTitle = [[windowTitle componentsSeparatedByString:@"/"] componentsJoinedByString:@"-"];

	NSString* fileName = [NSString stringWithFormat:@"%@/%@.%@", NSTemporaryDirectory(), windowTitle, appName];
	[[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileName atomically:NO];
	fileName = [fileName stringByStandardizingPath];

	NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:
		aString,    @"string",
		aView,      @"view",
		fileName,   @"fileName",
		nil];

	[OpenFiles setObject:options forKey:fileName];
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
	[OpenFiles removeObjectForKey:fileName];
	[[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
}

+ (void)load
{
	OpenFiles = [NSMutableDictionary new];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willProcessFirstEventNotification:) name:NSAppleEventManagerWillProcessFirstEventNotification object:nil];
}
@end
