//
//  CommitWindowCommandLine.m
//  CommitWindow
//
//  Created by Chris Thomas on 6/24/06.
//  Copyright 2006 Chris Thomas. All rights reserved.
//

#import "CommitWindowCommandLine.h"

#import "NSTask+CXAdditions.h"

@implementation CommitWindowController(CommandLine)

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
	// Parse the command line.
	//
	
	// Program name is the first argument -- get rid of it. (COW semantics should make this cheaper than it looks.)
	argc -= 1;
	args = [args subarrayWithRange:NSMakeRange(1, argc)];

	// Populate our NSArrayController with the command line arguments
	for( i = 0; i < argc; i += 1 )
	{
		NSString *				argument	= [args objectAtIndex:i];
		
		if( [argument isEqualToString:@"--ask"] )
		{
			// Next argument should be the query text.
			if( i >= (argc - 1) )
			{
				fprintf(stderr, "commit window: missing text: --ask \"some text\"\n");
				[self cancel:nil];
			}
			
			i += 1;
			argument	= [args objectAtIndex:i];
			[fRequestText setStringValue:argument];
		}
		else if( [argument isEqualToString:@"--status"] )
		{
			// Next argument should be a colon-seperated list of status strings, one for each path
			if( i >= (argc - 1) )
			{
				fprintf(stderr, "commit window: missing text: --status \"A:D:M:M:M\"\n");
				[self cancel:nil];
			}
			
			i += 1;
			argument	= [args objectAtIndex:i];
			fFileStatusStrings = [[argument componentsSeparatedByString:@":"] retain];
		}
		else if( [argument isEqualToString:@"--diff-cmd"] )
		{
			// Next argument should be a comma-seperated list of command arguments to use to execute the diff
			if( i >= (argc - 1) )
			{
				fprintf(stderr, "commit window: missing text: --diff-cmd \"/usr/bin/svn,diff\"\n");
				[self cancel:nil];
			}
			
			i += 1;
			argument	= [args objectAtIndex:i];
			fDiffCommand = [argument retain];
		}
		else
		{
			NSMutableDictionary *	dictionary	= [fFilesController newObject];

			[dictionary setObject:[argument stringByAbbreviatingWithTildeInPath] forKey:@"path"];
			[fFilesController addObject:dictionary];
		}
	}
	
	//
	// Done processing arguments, now add status to each item
	// 								and choose default commit state
	//
	[self setupUserInterface];
	
}


#if 0
#pragma mark -
#pragma mark Actions
#endif



- (IBAction) commit:(id) sender
{
	NSArray *			objects = [fFilesController arrangedObjects];
	int					i;
	int					pathsToCommitCount = 0;
	NSMutableString *	commitString;
	
	[self saveSummary];
	
	//
	// Quote any single-quotes in the commit message
	// \' doesn't work with bash. We must use string concatenation.
	// This sort of thing is why the Unix Hater's Handbook exists.
	//
	commitString = [[[fCommitMessage string] mutableCopy] autorelease];
	[commitString replaceOccurrencesOfString:@"'" withString:@"'\"'\"'" options:0 range:NSMakeRange(0, [commitString length])];
	
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
			[path replaceOccurrencesOfString:@"'" withString:@"'\"'\"'" options:0 range:NSMakeRange(0, [path length])];

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
	[self saveSummary];
		
	fprintf(stdout, "commit window: cancel\n");
	exit(-128);
}


- (void) checkExitStatus:(int)exitStatus forCommand:(NSArray *)arguments errorText:(NSString *)errorText
{
	if( exitStatus != 0 )
	{
		// This error dialog text sucks for an isolated end user, but allows us to diagnose the problem accurately.
		NSRunAlertPanel(errorText, @"Exit status (%d) while executing %@", @"OK", nil, nil, exitStatus, arguments);
		[NSException raise:@"ProcessFailed" format:@"Subprocess %@ unsuccessful.", arguments];
	}	
}

- (IBAction) doubleClickRowInTable:(id)sender
{
	if( fDiffCommand != nil )
	{
		static NSString *	sCommandAbsolutePath = nil;

		NSMutableArray *	arguments	= [[fDiffCommand componentsSeparatedByString:@","] mutableCopy];
		NSString *			filePath	= [[[fFilesController arrangedObjects] objectAtIndex:[sender selectedRow]] objectForKey:@"path"];
		NSData *			diffData;
		NSString *			errorText;
		int					exitStatus;
		
		// Resolve the command to an absolute path (only do this once per launch)
		if(sCommandAbsolutePath == nil)
		{
			exitStatus = [NSTask executeTaskWithArguments:[NSArray arrayWithObjects:@"/usr/bin/which", [arguments objectAtIndex:0], nil]
				    					input:nil
				                        outputString:&sCommandAbsolutePath
				                        errorString:&errorText];

			// Trim whitespace
			sCommandAbsolutePath = [[sCommandAbsolutePath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] retain];
			[self checkExitStatus:exitStatus forCommand:arguments errorText:errorText];
		}
		[arguments replaceObjectAtIndex:0 withObject:sCommandAbsolutePath];

		// Run the diff
		[arguments addObject:filePath];
		exitStatus = [NSTask executeTaskWithArguments:arguments
			    					input:nil
			                        outputData:&diffData
			                        errorString:&errorText];
		[self checkExitStatus:exitStatus forCommand:arguments errorText:errorText];

		// Success, send the diff to TextMate
		arguments = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%s/bin/mate", getenv("TM_SUPPORT_PATH")], @"-a", nil];
		
		exitStatus = [NSTask executeTaskWithArguments:arguments
			    					input:diffData
			                        outputData:nil
			                        errorString:&errorText];
		[self checkExitStatus:exitStatus forCommand:arguments errorText:errorText];
	}
}


@end
