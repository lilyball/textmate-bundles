#!/usr/bin/env ruby

require ENV['TM_BUNDLE_SUPPORT'] + '/lib/redcloth'

contents = Array.new()
$stdin.each_line() { |line|
	contents << line
}

puts(RedCloth.new(contents.join()).to_html(:textile))
