#!/usr/bin/ruby
require 'mkmf'
newFlags = " -arch ppc -arch i386 " + ENV['CFLAGS'].to_s
$CFLAGS += newFlags
$LDFLAGS += ' -framework CoreFoundation -framework Security ' + newFlags + ' -undefined suppress -flat_namespace'
$LIBRUBYARG_SHARED=""
create_makefile("osx/keychain")
