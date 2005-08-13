#!/usr/bin/ruby
require 'mkmf'
$LDFLAGS += ' -framework CoreFoundation'
create_makefile("plist")
