//
//  CommitWindowController.m
//
//  Created by Chris Thomas on 2/6/05.
//  Copyright 2005 Chris Thomas. All rights reserved.
//	MIT license.
//

#import "CommitWindowController.h"

//FIX ME HIServices/Processes.h doesn't work -- is this a Tiger-specific problem?
#import </System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/HIServices.framework/Versions/A/Headers/HIServices.h>

@implementation CommitWindowController

- (void) awakeFromNib
{
	NSProcessInfo * processInfo = [NSProcessInfo processInfo];
	NSArray *		args;
	int				i;
	int				argc;
	
	args = [processInfo arguments];
	argc = [args count];

	if( args == nil || argc < 2 )
	{
		fprintf(stderr, "commit window: Arguments required\n");
		[self cancel:nil];
	}
	
	//
	// Program name is the first argument -- get rid of it
	//
	argc -= 1;
	args = [args subarrayWithRange:NSMakeRange(1, argc)];
	
	//
	// Populate our NSArrayController with the command line arguments
	//
	[fFilesController objectDidBeginEditing:nil];
	for( i = 0; i < argc; i += 1 )
	{
		NSString *				argument	= [args objectAtIndex:i];
		
		if( [argument isEqualToString:@"--ask"] )
		{
			//
			// Next argument should be the query text.
			//
			if( i >= (argc - 1) )
			{
				fprintf(stderr, "commit window: missing text: --ask \"some text\"\n");
				[self cancel:nil];
			}
			
			i += 1;
			argument	= [args objectAtIndex:i];
			[fRequestText setStringValue:argument];
		}
		else
		{
			
			NSMutableDictionary *	dictionary	= [fFilesController newObject];

			[dictionary setObject:argument forKey:@"path"];
	//		[dictionary setObject:[NSNumber numberWithBool:YES] forKey:@"commit"]; not needed; the binding defaults to YES
			[fFilesController addObject:dictionary];
		}
	}
	[fFilesController objectDidEndEditing:nil];
	
	//
	// Bring the window to absolute front.
	// -[NSWindow orderFrontRegardless] doesn't work (maybe because we're an LSUIElement).
	//
	[self setWindow:fWindow];
	[fWindow setLevel:NSModalPanelWindowLevel];
	[fWindow makeKeyAndOrderFront:self];
	
	// Process Manager works, though!
	{
		ProcessSerialNumber process;
	
		GetCurrentProcess(&process);
		SetFrontProcess(&process);
	}
}

- (IBAction) commit:(id) sender
{
	NSArray *			objects = [fFilesController arrangedObjects];
	int					i;
	int					pathsToCommitCount = 0;
	NSMutableString *	commitString;
	
	//
	// Quote any single-quotes in the commit message
	//
	commitString = [[[fCommitMessage string] mutableCopy] autorelease];
	[commitString replaceOccurrencesOfString:@"'" withString:@"\\'" options:0 range:NSMakeRange(0, [commitString length])];
	
	fprintf(stdout, "-m '%s' ", [commitString UTF8String] );
	
	//
	// Return only the files we care about
	//
	for( i = 0; i < [objects count]; i += 1 )
	{
		NSMutableDictionary *	dictionary;
		NSNumber *				commit;
		
		dictionary	= [objects objectAtIndex:i];
		commit		= [dictionary objectForKey:@"commit"];
		
		if( commit == nil || [commit boolValue] )	// missing commit key defaults to true
		{
			NSMutableString *		path;
			
			//
			// Quote any single-quotes in the path
			//
			path = [dictionary objectForKey:@"path"];
			path = [[[path stringByStandardizingPath] mutableCopy] autorelease];
			[path replaceOccurrencesOfString:@"'" withString:@"\\'" options:0 range:NSMakeRange(0, [path length])];

			fprintf( stdout, "'%s' ", [path UTF8String] );
			pathsToCommitCount += 1;
		}
	}
	
	fprintf( stdout, "\n" );
	
	//
	// SVN will commit the current directory, recursively, if we don't specify files.
	// So, to prevent surprises, if the user's unchecked all the boxes, let's be on the safe side and cancel.
	//
	if( pathsToCommitCount == 0 )
	{
		[self cancel:nil];
	}
	
	[NSApp terminate:self];
}

- (IBAction) cancel:(id) sender
{
	fprintf(stdout, "commit window: cancel\n");
	exit(-128);
}

@end
