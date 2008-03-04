#!/usr/bin/env ruby

require "redcloth"

contents = Array.new()
$stdin.each_line() { |line|
	contents << line
}

puts(RedCloth.new(contents.join()).to_html(:textile))
