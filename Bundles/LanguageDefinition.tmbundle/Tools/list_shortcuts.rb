#!/usr/bin/env ruby
# Checks user and local Application Support domains for TextMate bundles
# Parses them for the keyboard shortcuts
# And displays a nice HTML view
#
# Pass -b to get a list per-bundle instead of per-type

$bundle = ENV['TM_BUNDLE_PATH'].chomp('/')

$: << "#{$bundle}/Tools"
require 'plist'

SHORTCUT_TITLES = {
	"keyEquivalent" => "Key Equivalent",
	"tabTrigger" => "Tab Trigger",
	"trigger" => "Input Pattern",
}

def getShortcut(child)
	if child.has_key?('keyEquivalent')
		["keyEquivalent", convertKeyEquivalent(child['keyEquivalent'])]
	elsif child.has_key?('tabTrigger')
		["tabTrigger", addEntities(child['tabTrigger'])]
	elsif child.has_key?('trigger')
		["trigger", addEntities(child['trigger'])]
	else
		nil
	end
end

KEY_GLYPHS = {
	"left"			=> "&#x2190;",
	"up"			=> "&#x2191;",
	"right"			=> "&#x2192;",
	"down"			=> "&#x2193;",
	"home"			=> "&#x2196;",
	"end"			=> "&#x2198;",
	"return"		=> "&#x21A9;",
	"pageup"		=> "&#x21DE;",
	"pagedown"		=> "&#x21DF;",
	"tab"			=> "&#x21E5;",
	"backtab"		=> "&#x21E4;",
	"shift"			=> "&#x21E7;",
	"control"		=> "&#x2303;",
	"enter"			=> "&#x2305;",
	"command"		=> "&#x2318;",
	"modifier"		=> "&#x2325;",
	"clear"			=> "&#x2327;",
	"backspace"		=> "&#x232B;",
	"delete"		=> "&#x2326;",
	"escape"		=> "&#x238B;",
}

KEY_BYTES = {
	"\xEF\x9C\x80"	=> "up",
	"\xEF\x9C\x81"	=> "down",
	"\xEF\x9C\x82"	=> "left",
	"\xEF\x9C\x83"	=> "right",
	"\xEF\x9C\A8"	=> "delete",
	"\xEF\x9C\xA9"	=> "home",
	"\xEF\x9C\xAB"	=> "end",
	"\xEF\x9C\xAC"	=> "pageup",
	"\xEF\x9C\xAD"	=> "pagedown",
	"\xEF\x9C\xB9"	=> "clear",
	"\x7F\x0A"		=> "backspace",
	"\n"			=> "return",
	"\r"			=> "return",
	"\x03"			=> "enter",
	"\x1B"			=> "escape",
	"\t"			=> "tab",
	"\x19"			=> "backtab",
}

def convertKeyEquivalent(text)
	option = text.include?('~') ? KEY_GLYPHS['modifier'] : ''
	control = text.include?('^') ? KEY_GLYPHS['control'] : '' 
	command = text.include?('@') ? KEY_GLYPHS['command'] : ''
	shift = (text != text.downcase or text.include?('$')) ? KEY_GLYPHS['shift'] : ''
	text.upcase!
	keypad = text.include?('#') ? '&#x20E3' : ''
	text.gsub!(/[~^@$#]/,'')
	text.gsub!("&", "&amp;")
	text.gsub!("<", "&lt;")
	text.gsub!(">", "&gt;")
	(1..16).each { |i| text.sub!("\xEF\x9C%c" % (0x83+i), 'F'+i.to_s ) }
	text.sub!("\xEF\x9D\x86", '?&#x20DD;')
	KEY_BYTES.each { |key, value| text.sub!(key, KEY_GLYPHS[value]) }
	control + option + shift + command + text + keypad
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
			shortcutType, shortcut = getShortcut(item)
			puts "\t\t<tr class=\"#{shortcutType} #{alternate ? ' alternate' : ''}\">"
			alternate = ! alternate
			puts "\t\t\t<td>#{addEntities(item['name'])}</td>"
			puts "\t\t\t<td>#{SHORTCUT_TITLES[shortcutType]}</td>"
			puts "\t\t\t<td>#{shortcut}</td>"
			puts "\t\t</tr>"
		end if not items.nil?
		puts "\t</table>"
	end
end

puts '</body></html>'