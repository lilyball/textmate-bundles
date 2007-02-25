#!/usr/bin/ruby
require 'mkmf'
newFlags = " -arch ppc -arch i386 -isysroot /Developer/SDKs/MacOSX10.4u.sdk"
$CFLAGS += newFlags
$LDFLAGS += ' -framework CoreFoundation' + newFlags + ' -undefined suppress -flat_namespace'
$LIBRUBYARG_SHARED=""
create_makefile("osx/plist")
