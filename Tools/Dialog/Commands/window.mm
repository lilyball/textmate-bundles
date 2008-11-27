#import <vector>
#import <string>
#import <sys/stat.h>
#import "../Dialog2.h"
#import "../TMDCommand.h"
#import "../OptionParser.h"
#import "Utilities/TMDChameleon.h"
#import "Utilities/TMDNibController.h"

// ==========
// = Window =
// ==========

@interface TMDWindowCommand : TMDCommand
{
}
@end

// ===================
// = Command handler =
// ===================

std::string find_nib (std::string nibName, std::string currentDirectory, NSDictionary* env)
{
	std::vector<std::string> candidates;

	if(nibName.find(".nib") == std::string::npos)
		nibName += ".nib";

	if(nibName.size() && nibName[0] != '/') // relative path
	{
		candidates.push_back(currentDirectory + "/" + nibName);

		if(char const* bundleSupport = [[env objectForKey:@"TM_BUNDLE_SUPPORT"] UTF8String])
			candidates.push_back(bundleSupport + std::string("/nibs/") + nibName);

		if(char const* supportPath = [[env objectForKey:@"TM_SUPPORT_PATH"] UTF8String])
			candidates.push_back(supportPath + std::string("/nibs/") + nibName);
	}
	else
	{
		candidates.push_back(nibName);
	}

	iterate(it, candidates)
	{
		struct stat sb;
		if(stat(it->c_str(), &sb) == 0)
			return *it;
	}

	fprintf(stderr, "nib could not be loaded: %s (does not exist)\n", nibName.c_str());
	return "";
}

static NSMutableDictionary* Nibs = [NSMutableDictionary new];
static int NibTokenCount = 0;

@implementation TMDWindowCommand
+ (void)load
{
	[super registerObject:[self new] forCommand:@"window"];
}

/*
env|egrep 'DIALOG|TM_SUPPORT'|grep -v DIALOG_1|perl -pe 's/(.*?)=(.*)/export $1="$2"/'|pbcopy

"$DIALOG" window --open "$TM_SUPPORT_PATH/../Bundles/Latex.tmbundle/Support/nibs/tex_prefs.nib" --defaults '{ latexEngineOptions = "bar"; }'

"$DIALOG" window --open RequestString --center --model '{title = "Name?"; prompt = "Please enter your name:"; }'
"$DIALOG" window --update 1 --model '{title = "updated title"; prompt = "updated prompt"; }'
"$DIALOG" window --close 1
"$DIALOG" window --list

"$DIALOG" window --open "$TM_SUPPORT_PATH/../Bundles/SQL.tmbundle/Support/nibs/connections.nib" --defaults "{'SQL Connections' = ( { title = untitled; serverType = MySQL; hostName = localhost; userName = '$LOGNAME'; } ); }" --prototypes "{ SQL_New_Connection = { title = untitled; serverType = MySQL; hostName = localhost; userName = '$LOGNAME'; }; }"

"$DIALOG" help window
*/

- (void)handleCommand:(CLIProxy*)proxy
{
	NSDictionary* args = [proxy parameters];

	NSDictionary* model = [args objectForKey:@"model"];
	BOOL shouldCenter   = [args objectForKey:@"center"] ? YES : NO;

	// FIXME this is needed only because we presently can’t express argument constraints (CLIProxy would otherwise correctly validate/convert CLI arguments)
	if([model isKindOfClass:[NSString class]])
		model = [NSPropertyListSerialization propertyListFromData:[(NSString*)model dataUsingEncoding:NSUTF8StringEncoding] mutabilityOption:NSPropertyListImmutable format:nil errorDescription:NULL];

	if(NSString* updateToken = [args objectForKey:@"update"])
	{
		if(TMDNibController* nibController = [Nibs objectForKey:updateToken])
				[nibController updateParametersWith:model];
		else	[proxy writeStringToOutput:@"There is no window with that token"];
	}

	if(NSString* waitToken = [args objectForKey:@"wait"])
	{
		if(TMDNibController* nibController = [Nibs objectForKey:waitToken])
				[nibController addClientFileHandle:[proxy outputHandle]];
		else	[proxy writeStringToError:@"There is no window with that token"];
	}

	if(NSString* closeToken = [args objectForKey:@"close"])
	{
		if(TMDNibController* nibController = [Nibs objectForKey:closeToken])
		{
			[nibController tearDown];
			[Nibs removeObjectForKey:closeToken];
		}
		else
		{
			[proxy writeStringToError:@"There is no window with that token"];
		}
	}

	if([args objectForKey:@"list"])
	{
		[proxy writeStringToOutput:@"Loaded nibs:\n"];

		enumerate([Nibs allKeys], NSString* token)
		{
			TMDNibController* nibController = [Nibs objectForKey:token];
			[proxy writeStringToOutput:[NSString stringWithFormat:@"%@ (%@)\n", token, [[nibController window] title]]];
		}
	}

	if(NSDictionary* prototypes = [args objectForKey:@"prototypes"])
	{
		// FIXME this is needed only because we presently can’t express argument constraints (CLIProxy would otherwise correctly validate/convert CLI arguments)
		if([prototypes isKindOfClass:[NSString class]])
			prototypes = [NSPropertyListSerialization propertyListFromData:[(NSString*)prototypes dataUsingEncoding:NSUTF8StringEncoding] mutabilityOption:NSPropertyListImmutable format:nil errorDescription:NULL];

		enumerate([prototypes allKeys], id key)
			[TMDChameleon createSubclassNamed:key withValues:[prototypes objectForKey:key]];
	}

	if(NSString* nibName = [args objectForKey:@"open"])
	{
		// TODO we should let an option type be ‘filename’ and have CLIProxy resolve these (and error when file does not exist)
		NSString* nib = [NSString stringWithUTF8String:find_nib([nibName UTF8String], [[proxy workingDirectory] UTF8String] ?: "", [proxy environment]).c_str()];
		if(nib == nil || [nib length] == 0)
			ErrorAndReturn(@"nib not found. The nib name must be the first argument given");

		if(TMDNibController* nibController = [[[TMDNibController alloc] initWithNibPath:nib] autorelease])
		{
			NSString* token = [NSString stringWithFormat:@"%d", ++NibTokenCount];
			[Nibs setObject:nibController forKey:token];

			[nibController updateParametersWith:model];
			[nibController showWindowAndCenter:shouldCenter];

			[proxy writeStringToOutput:token];
		}
	}
}

- (NSString *)commandDescription
{
	return @"Displays custom dialogs from NIBs.";
}

- (NSString *)usageForInvocation:(NSString *)invocation;
{
	return [NSString stringWithFormat:
		@"%1$@ --load «nib» [«options»]\n"
		@"%1$@ --update «token» [«options»]\n"
		@"%1$@ --wait «token»\n"
		@"%1$@ --close «token»\n"
		@"%1$@ --list\n"
		@"\nOptions:\n"
		@"\t--center\n"
		@"\t--model «plist»\n"
		@"\t--prototypes «plist»\n",
		invocation];
}
@end
