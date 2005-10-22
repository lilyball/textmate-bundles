#!/usr/bin/ruby
require 'mkmf'
$CFLAGS += " -arch ppc -arch i386 -isysroot /Developer/SDKs/MacOSX10.4u.sdk"
$LDFLAGS += ' -framework CoreFoundation'
create_makefile("plist")
