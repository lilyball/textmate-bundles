#!/usr/bin/ruby
require 'mkmf'
newFlags = " -mmacosx-version-min=10.4 -arch ppc -arch i386 " + ENV['CFLAGS'].to_s
$CFLAGS += newFlags
$LDFLAGS += ' -framework CoreFoundation' + newFlags + ' -undefined suppress -flat_namespace'
$LIBRUBYARG_SHARED=""
create_makefile("osx/plist")
