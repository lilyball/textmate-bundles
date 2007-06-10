#!/usr/bin/env ruby
# Checks user and local Application Support domains for TextMate bundles
# Parses them for the keyboard shortcuts
# And displays a nice HTML view
#
# Pass -b to get a list per-bundle instead of per-type

$bundle = ENV['TM_BUNDLE_SUPPORT'].chomp('/')

$: << "#{$bundle}"
require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"

SHORTCUT_TITLES = {
	"keyEquivalent" => "Key Equivalent",
	"tabTrigger" => "Tab Trigger",
	"inputPattern" => "Input Pattern",
}

def getShortcutTypes(child)
	types = []
	if child.has_key?('keyEquivalent')
		types << 'keyEquivalent'
	elsif child.has_key?('tabTrigger') or child.has_key?('trigger')
		types << 'tabTrigger'
	elsif child.has_key?('inputPattern')
		types << 'inputPattern'
	end
	types
end

def getShortcuts(child)
	shortcuts = []
	if child.has_key?('keyEquivalent')
		shortcuts << ["keyEquivalent", convertKeyEquivalent(child['keyEquivalent'])]
	end
	if child.has_key?('tabTrigger')
		shortcuts << ["tabTrigger", addEntities(child['tabTrigger'])]
	end
	if child.has_key?('trigger')
		shortcuts << ["tabTrigger", addEntities(child(['tabTrigger']))]
	end
	if child.has_key?('inputPattern')
		shortcuts << ["inputPattern", addEntities(child['inputPattern'])]
	end
	shortcuts
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
	"\xEF\x9C\xA8"	=> "delete",
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
	keypad = (text.include?('#') and not text.include?("\x03")) ? '&#x20E3' : ''
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

#$scripturl = "file://#{$bundle}/Scripts/list_shortcuts.js"
#$stylesheeturl = "file://#{$bundle}/Stylesheets/list_shortcuts.css"
$scripturl = "#{$bundle}/Scripts/list_shortcuts.js"
$stylesheeturl = "#{$bundle}/Stylesheets/list_shortcuts.css"

puts '<html><head><title>Keyboard Shortcuts List</title>'
puts '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />'
#puts %{<script type="text/ecmascript" src="#{$scripturl}" charset="utf-8" />}
#puts '<style type="text/css">'
#puts "	@import '#{$stylesheeturl}';"
#puts '</style></head>'
#
# I'm including the extra files directly in here to get around the caching issue
puts '<script type="text/ecmascript">'
IO.foreach($scripturl) { |line| puts line }
puts '</script>'
puts '<style type="text/css">'
IO.foreach($stylesheeturl) { |line| puts line }
puts '</style>'
puts '<body onload="setup();">'
puts '<h1>Keyboard Shortcuts List</h1><hr />'

bundles = OSX::PropertyList.load(%x{"#{$bundle}/bin/KeyboardShortcuts"})

puts '<div id="header">'
puts '<div class="jumpblock">'
puts 'Jump:'
puts '<select id="jump">'
puts '<option>Bundles:</option>'
bundles.each do |bundle|
	name = addEntities(bundle['name'])
	puts %{<option value="#{name.gsub(' ', '_')}">#{name}</option>}
end
puts '</select>'
puts '</div>'
puts '<div class="filter">'
puts 'Filter:'
puts '<select id="filter" onchange="jump">'
puts '<option value="all">All</option>'
puts '<option value="keyEquivalent">Key Equivalent</option>'
puts '<option value="tabTrigger">Tab Trigger</option>'
puts '<option value="trigger">Input Pattern</option>'
puts '</select>'
puts '</div>'
puts '</div>'

puts '<hr />'

bundles.each do |bundle|
	puts %{<a name="#{addEntities(bundle['name']).gsub(' ', '_')}"></a>}
	puts "<h2>#{addEntities(bundle['name'])}</h2>"
	['Commands', 'Macros', 'Snippets'].each do |type|
		items = bundle[type]
		classes = Hash.new("");
		items.each do |item|
			shortcutTypes = getShortcutTypes(item)
			shortcutTypes.each { |shortcutType| classes[shortcutType] = shortcutType + 'Block' }
		end if not items.nil?
		classes = classes.values.join(' ')
		if not items.to_a.empty?
			puts %{\t<div class="typeblock #{classes}">}
			puts %{\t<h3>#{addEntities(type)}</h3>\n\t<table>}
			items.each do |item|
				shortcuts = getShortcuts(item)
				shortcuts.each do |shortcut|
					shortcutType = shortcut[0]
					shortcutValue = shortcut[1]
					puts "\t\t<tr class=\"#{shortcutType}\">"
					puts %{\t\t\t<td class="name">#{addEntities(item['name'])}</td>}
					puts %{\t\t\t<td class="type">#{SHORTCUT_TITLES[shortcutType]}</td>}
					puts %{\t\t\t<td class="shortcut">#{shortcutValue}</td>}
					puts "\t\t</tr>"
					item['name'] = ''
				end
			end
			puts "\t</table>"
			puts "\t</div>"
		end
	end
end

puts '<hr />'

puts '<div id="footer">'
puts '<div class="jump">'
puts 'Jump:'
puts '<select id="jump2">'
puts '<option>Bundles:</option>'
bundles.each do |bundle|
	name = addEntities(bundle['name'])
	puts %{<option value="#{name.gsub(' ', '_')}">#{name}</option>}
end
puts '</select>'
puts '</div>'

puts '</body></html>'
