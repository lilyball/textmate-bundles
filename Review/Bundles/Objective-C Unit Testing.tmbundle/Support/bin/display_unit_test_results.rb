#!/usr/bin/env ruby

require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"

input = ""
until $stdin.eof?
	input << $stdin.readline
end
SECTIONS = input.split("\n\n")

SUITES = SECTIONS.inject([]) do |accum, section|
	suite = {
		"name" => section[/Test Suite '(\w+)'/, 1],
		"time" => section[/Test Suite '\w+' started at (.+?)$/, 1]
	}
	suite["cases"] = section.split(/\(.+?seconds\)\.\n/).reject{ |section| section =~ /^Suite/ }.collect do |section|
		# puts section, "\n\n"
		c = {
			"name" => section[/Test Case '-\[#{suite["name"]} (\w+)\]'/, 1],
			"passed" => !!section[/\bpassed\b/],
			"failed" => !!section[/\bfailed\b/],
		}
		c["details"] = section.sub(/\nTest Case.+$/, '') if c["failed"]
		c
	end.reject{ |c| !c["name"] }.sort{ |a, b| a["name"] <=> b["name"] }
	suite["failed"] = !!suite["cases"].detect{ |c| c["failed"] }
	suite["passed"] = !suite["failed"]
	accum << suite
end.sort{ |a, b| a["name"] <=> b["name"] }

%x{"$DIALOG" -cm "$TM_BUNDLE_SUPPORT/nibs/Unit Test Results.nib"<<END
#{{ "suites" => SUITES }.to_plist}
END}