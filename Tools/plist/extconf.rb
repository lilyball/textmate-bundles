require 'mkmf'
$CFLAGS.gsub!("-arch i386", "")
#$LIBS += ' -framework CoreFoundation'
$LDFLAGS += ' -framework CoreFoundation'
create_makefile("plist")
