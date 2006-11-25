#!/usr/bin/env ruby
#
# Ale Muñoz <ale@bomberstudios.com> - 2006-11-25
# Feel free to use and improve...

require "#{ENV["TM_SUPPORT_PATH"]}/lib/web_preview"
require "rexml/document"

WORD		= ENV['TM_CURRENT_WORD']
HELPDIR		= ENV['TM_FLASH_HELP']
HELPTOC		= 'help_toc.xml'

# Open TOC...
toc_lines = IO.readlines(HELPDIR + "/" + HELPTOC)

# ...find matching lines...
search_results = []
toc_lines.each do |line|
	search_results << line.strip if line.include? "name=\"" + WORD
end

puts html_head( :title => "Documentation for ‘#{WORD}’", :sub_title => "ActionScript Dictionary" )

# ...parse results for links...
links = []
puts "<ul>"
search_results.each do |line|
	xml_line = REXML::Document.new(line)
	puts "<li><a href=\"tm-file://#{HELPDIR}/#{xml_line.root.attributes['href']}\">#{xml_line.root.attributes['name']}</a></li>"
end
puts "</ul>"

# ...or display error if no matches
puts "No results :(" if search_results.size == 0

html_footer