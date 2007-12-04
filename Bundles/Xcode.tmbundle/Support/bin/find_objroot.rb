#!/usr/bin/env ruby

require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"

result = %x{defaults read com.apple.Xcode PBXApplicationwideBuildSettings}
if $? == 0
	print OSX::PropertyList::load(result)["OBJROOT"]
	exit(0)
else
	exit($?)
end