#!/usr/bin/env ruby

# single tags
single = /^img|br|hr|meta|link|input|base|area|col|frame|param$/i

# if we have something selected, turn it into a tag,
# if we are just in a word, use that, otherwise - a blank
# tag
if(ENV['TM_SELECTED_TEXT'].to_s.strip != '')
	tag = ENV['TM_SELECTED_TEXT'].strip[/^\S+/]
	if(single.match(tag))
		print("<#{tag}#{ENV['TM_SELECTED_TEXT'].strip[/^\S+(\s+.*)/, 1]} />$0")
	else
		print("<#{tag}#{ENV['TM_SELECTED_TEXT'].strip[/^\S+(\s+.*)/, 1]}>$1</#{tag}>$0")
	end
else
	print("#{ENV['TM_SELECTED_TEXT']}<${1:p}>$2</${1/\\s.*//}>$0")
end
