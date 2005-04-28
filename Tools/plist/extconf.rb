require 'mkmf'
$CFLAGS.gsub!("-arch i386", "")
$LIBS += ' -framework CoreFoundation'
create_makefile("plist")
