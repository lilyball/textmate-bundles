#import "GCTerminalMate.h"
#import "iTermApplicationDelegate.h"
#import <pthread.h>

#define GCLog(s, args...) NSLog([NSString stringWithFormat:@"TerminalMate: %@", s], ##args)

#ifndef enumerate
#   define enumerate(container,var) for(NSEnumerator* _enumerator = [container objectEnumerator]; var = [_enumerator nextObject];)
#endif

static iTermApplicationDelegate *iTerm;
static VALUE terminalMateServer;
static NSMutableDictionary *terminalContainers;

@interface GCTerminalContainer : NSObject
{
    id terminal;
    NSString *scope;
}
@end

@implementation GCTerminalContainer
- (id)initWithScope:(NSString *)aScope
{
    self = [super init];
    if(self)
    {
        scope = aScope;
        terminal = [self makeTerminal];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(windowWillClose:)
                                                     name:NSWindowWillCloseNotification
                                                   object:[terminal window]];
    }
    return self;
}

- (id)makeTerminal
{
    [iTerm newWindow:nil];
    NSArray *iTerm_terminals = [iTerm terminals];
    id terminal = [iTerm_terminals objectAtIndex:[iTerm_terminals count] - 1];
    [terminal setAntiAlias:NO];
    return terminal;
}

- (void)windowWillClose:(NSNotification *)aNotification
{
    [terminalContainers removeObjectForKey:scope];
}

- (id)terminal
{
    return terminal;
}

- (id)session
{
    return [[terminal sessions] objectAtIndex:0];
}
@end


void initRuby(void)
{
    ruby_init();
    ruby_init_loadpath();
}

void cleanupRuby(void)
{
    ruby_finalize();
}

void initTerminalMateServer(void)
{
    rb_require("gserver");
    rb_require("fileutils");
    const char *code =
        "class TerminalMateServer < GServer\n"
        "  SUPPORT = File.expand_path('~/Library/Application Support/TerminalMate')\n"
        "  def initialize\n"
        "    FileUtils.mkdir_p(SUPPORT)\n"
        "    log = File.open(SUPPORT + '/server.log', 'w')\n"
        "    super(0, '127.0.0.1', 4, log, true, false)\n"
        "  end\n"
        "  def start\n"
        "    super()\n"
        "    log('Starting server…')\n"
        "    File.open(SUPPORT + '/server.bin', 'w') do |f|\n"
        "      Marshal.dump(port(), f)\n"
        "    end\n"
        "  end\n"
        "  def serve(io)\n"
        "    log('serve: io=' + io.inspect)\n"
        "    handle_request(io)\n"
        "  end\n"
        "end\n";
    int status = 0;
    rb_eval_string_protect(code, &status);
    // Uh oh, there was something wrong with our code.
    if (status)
    {
    }
}

VALUE getsChomp(VALUE io)
{
    return rb_funcall(rb_funcall(io, rb_intern("gets"), 0),
                      rb_intern("chomp"),
                      0);
}

NSString *readConvert(VALUE io)
{
    VALUE s = rb_funcall(io, rb_intern("read"), 0);
    return [NSString stringWithCString:StringValuePtr(s)];
}

id sessionForScope(NSString *scope)
{
    if ([[terminalContainers allKeys] containsObject:scope]) {
        id container = [terminalContainers objectForKey: scope];
        return [container session];
    }
    return nil;
}

VALUE terminalMateHandleRequest(VALUE s, VALUE io)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    VALUE command = getsChomp(io);
    
    VALUE scopev = getsChomp(io);
    // This doesn't work for all scopes, like source.ruby.rails
    scopev = rb_funcall(rb_funcall(scopev, rb_intern("split"), 1, rb_str_new2(" ")),
                        rb_intern("first"),
                        0);
    NSString *scope = [NSString stringWithCString:StringValuePtr(scopev)];
    //GCLog(@"scope='%@'", scope);
    
    ID equals = rb_intern("==");

    if (rb_funcall(command, equals, 1, rb_str_new2("new"))) {
        GCLog(@"new command");
        
        VALUE tm_project_directory = getsChomp(io);
        NSString *argument = readConvert(io);
        
        GCTerminalContainer *container = [[GCTerminalContainer alloc] initWithScope:scope];
        id session = [container session];
        [terminalContainers setObject:container forKey:scope];
            
        if (rb_funcall(tm_project_directory, rb_intern("empty?"), 0) == Qfalse)
        {
            NSString *directory = [NSString stringWithCString:StringValuePtr(tm_project_directory)];
            GCLog(@"Changing directory to '%@'", directory);
            [session insertText:[NSString stringWithFormat:@"cd '%@'\n", directory]];
        }
        
        if (![argument isEqualToString:@"\n"])
            [session insertText:argument];
    }
    else if (rb_funcall(command, equals, 1, rb_str_new2("paste"))) {
        GCLog(@"paste command");
        NSString *argument = readConvert(io);
        id session = sessionForScope(scope);
        if (session)
        {
            [session insertText:argument];
        }
    }
    else if (rb_funcall(command, equals, 1, rb_str_new2("load_file"))) {
        GCLog(@"load_file command");
        NSString *argument = readConvert(io);
        id session = sessionForScope(scope);
        if (session)
        {
            [session insertText:argument];
        }
    }
    else {
        GCLog(@"unknown command %s", StringValuePtr(command));
        NSBeep();
    }

    [pool release];
    return Qnil;
}

void *initTerminalMateThread(void *data)
{
    initRuby();
    initTerminalMateServer();
    terminalMateServer = rb_class_new_instance(0, 0, rb_const_get(rb_cObject, rb_intern("TerminalMateServer")));
    rb_define_method(rb_funcall(terminalMateServer, rb_intern("class"), 0),
                     "handle_request",
                     terminalMateHandleRequest,
                     1);
    
    rb_funcall(terminalMateServer, rb_intern("start"), 0);
    GCLog(@"Server started");
    rb_funcall(terminalMateServer, rb_intern("join"), 0);
    return NULL;
}

@implementation GCTerminalMate
- (id)initWithPlugInController:(id <TMPlugInController>)aController
{
    self = [super init];
    [self loadGrowl];
    
    iTerm = [[iTermApplicationDelegate alloc] init];
    terminalContainers = [[NSMutableDictionary alloc] initWithCapacity:10];
    
    pthread_t thread;
    int thread_status;
    thread_status = pthread_create(&thread, NULL, initTerminalMateThread, NULL);
    GCLog(@"thread status: %d", thread_status);
    
    [self installMenuItem];
    
    return self;
}

- (void)loadGrowl
{
    NSString *path1 = @"/Library/Application Support/TextMate/PlugIns/TerminalMate.tmplugin/Contents/Frameworks/Growl.framework";
    NSString *path2 = [@"~/Library/Application Support/TextMate/PlugIns/TerminalMate.tmplugin/Contents/Frameworks/Growl.framework" stringByExpandingTildeInPath];
    NSString *path;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path1])
        path = path1;
    else if ([[NSFileManager defaultManager] fileExistsAtPath:path2])
        path = path2;
    else
        GCLog(@"Error. Growl could not be found. Prepare for a crash");
    
    GCLog(@"Using Growl path='%@'", path);
    
    NSBundle * bundle = [NSBundle bundleWithPath:path];
    if ([bundle load])
        GCLog(@"Growl loaded");
    else
        GCLog(@"Error. Growl not loaded. Prepare for a crash");
}

// TODO: Install in TextMate menu
- (void)installMenuItem
{
    windowMenu = [[[[NSApp mainMenu] itemWithTitle:@"Window"] submenu] retain];
    if (windowMenu)
    {
        id showiTermPrefsMenuItem = [[NSMenuItem alloc] initWithTitle:@"iTerm Preferences"
                                                               action:@selector(showPrefWindow:)
                                                        keyEquivalent:@""];
        [showiTermPrefsMenuItem setTarget:iTerm];
        [windowMenu insertItem:showiTermPrefsMenuItem atIndex:1];        
    }
}

- (float)version
{
    return 0.1f;
}

- (void)dealloc
{
    [iTerm dealloc];
    [terminalContainers dealloc];
    rb_funcall(terminalMateServer, rb_intern("shutdown"), 0);
    cleanupRuby();
    [super dealloc];
}
@end
