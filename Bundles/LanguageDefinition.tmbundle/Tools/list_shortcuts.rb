#!/usr/bin/env ruby
# Checks user and local Application Support domains for TextMate bundles
# Parses them for the keyboard shortcuts
# And displays a nice HTML view
#
# Pass -b to get a list per-bundle instead of per-type

$bundle = ENV['TM_BUNDLE_PATH'].chomp('/')

$: << "#{$bundle}/Tools"
require 'plist'


def getShortcut(child)
	if child.has_key?('keyEquivalent')
		["Key Equivalent", convertKeyEquivalent(child['keyEquivalent'])]
	elsif child.has_key?('tabTrigger')
		["Tab Trigger", addEntities(child['tabTrigger'])]
	elsif child.has_key?('trigger')
		["Input Pattern", addEntities(child['trigger'])]
	else
		nil
	end
end

def convertKeyEquivalent(text)
	option = text.sub!('~','').nil? ? '' : '&#x2325;'
	control = text.sub!('^','').nil? ? '' : '&#x2303;'
	command = text.sub!('@','').nil? ? '' : '&#x2318;'
	shift = text.upcase!.nil? ? '&#x21E7;' : ''
	text.gsub!("&", "&amp;")
	text.gsub!("<", "&lt;")
	text.gsub!(">", "&gt;")
	(1..15).each { |i| text.sub!("\xEF\x9C%c" % (0x83+i), 'F'+i.to_s ) }
	text.sub!("\xEF\x9D\x86", '?&#x20DD;')
	text.sub!("\xEF\x9C\A8", '&#x2326;')
	text.sub!("\n", '&#x21A9;')
	control + option + shift + command + text
end

def addEntities(text)
	text.gsub!("&", "&amp;")
	text.gsub!("<", "&lt;")
	text.gsub!(">", "&gt;")
	text
end

puts '<html><head><title>Keyboard Shortcuts List</title>'
puts '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />'
puts '<style type="text/css">'
puts "	@import 'file://#{$bundle}/Stylesheets/list_shortcuts.css';"
puts '</style></head>'
puts '<body>'
puts '<h1>Keyboard Shortcuts List</h1><hr />'

bundles = PropertyList::load(%x{"#{$bundle}/Tools/KeyboardShortcuts"})

bundles.each do |bundle|
	puts "<h2>#{addEntities(bundle['name'])}</h2>"
	['Commands', 'Macros', 'Snippets'].each do |type|
		items = bundle[type]
		puts "\t<h3>#{addEntities(type)}</h3>\n\t<table>" if not items.to_a.empty?
		alternate = false
		items.each do |item|
			puts "\t\t<tr#{alternate ? ' class="alternate"' : ''}>"
			alternate = ! alternate
			shortcutType, shortcut = getShortcut(item)
			puts "\t\t\t<td>#{addEntities(item['name'])}</td>"
			puts "\t\t\t<td>#{shortcutType}</td>"
			puts "\t\t\t<td>#{shortcut}</td>"
			puts "\t\t</tr>"
		end if not items.nil?
		puts "\t</table>"
	end
end

puts '</body></html>'