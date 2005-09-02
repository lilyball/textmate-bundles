#!/usr/bin/env ruby

$: << "#{ENV['TM_SUPPORT_PATH']}/lib/RedCloth/lib/"

require 'RedCloth'

contents = Array.new()
$stdin.each_line() { |line|
	contents << line
}

puts(RedCloth.new(contents.join()).to_html())
