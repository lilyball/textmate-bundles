#!/usr/bin/env ruby

require "RedCloth/lib/redcloth"

contents = Array.new()
$stdin.each_line() { |line|
	contents << line
}

puts(RedCloth.new(contents.join()).to_html(:textile))
