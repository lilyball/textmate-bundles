#!/usr/bin/env ruby
#
# Ale Muñoz <ale@bomberstudios.com> - 2006-11-25
# Feel free to use and improve...
# 

require ENV['TM_SUPPORT_PATH'] + "/lib/exit_codes"
require ENV['TM_SUPPORT_PATH'] + "/lib/escape"
require ENV['TM_SUPPORT_PATH'] + "/lib/progress"
require ENV["TM_SUPPORT_PATH"] + "/lib/web_preview"
require "rexml/document"

WORD    = ENV['TM_CURRENT_WORD']
HELPTOC = 'help_toc.xml'

help_dir_options = [
	"#{ENV['HOME']}/Library/Application Support/Adobe/Flash CS3/en/Configuration/HelpPanel/Help/ActionScriptLangRefV2",
	"/Users/Shared/Library/Application Support/Macromedia/Flash 8/en/Configuration/HelpPanel/Help/ActionScriptLangRef",
	"/Users/Shared/Library/Application Support/Macromedia/Flash MX 2004/en/Configuration/HelpPanel/Help/ActionScriptLangRef"
]

# Try to locate help dir
if %x(defaults read com.macromates.textmate.actionscript FlashDocumentationPath).empty?
	help_dir_options.each do |path|
		if File.exist? "#{path}/#{HELPTOC}"
			help_dir = path
			%x(defaults write com.macromates.textmate.actionscript FlashDocumentationPath "#{help_dir}")
			break
		end
	end
	if help_dir.empty?
		# Help dir not found...
		puts html_head({:title => "Error!", :sub_title => "Find in ActionScript Dictionary"})
		puts "
		<h1>Search failed for “#{WORD}”</h1>
		<p>In order for this command to work TextMate needs to know where to find the ActionScript Dictionary index file. The commands tries to find it in the following places:</p>
		<ul>
			<li>#{ENV['HOME']}/Library/Application Support/Adobe/Flash CS3/en/Configuration/HelpPanel/Help/ActionScriptLangRefV2/help_toc.xml</li>
			<li>/Users/Shared/Library/Application Support/Macromedia/Flash 8/en/Configuration/HelpPanel/Help/ActionScriptLangRef/help_toc.xml</li>
			<li>/Users/Shared/Library/Application Support/Macromedia/Flash MX 2004/en/Configuration/HelpPanel/Help/ActionScriptLangRef/help_toc.xml</li>
		</ul>
		<p>If the command can't find the index file, you can set a search path manually:
			<ul>
				<li>Open <strong>Preferences » Advanced » Shell Variables</strong>.</li>
				<li>Click <strong>+</strong></li>
				<li>Name the variable <code>TM_FLASH_HELP</code></li>
				<li>Set the value to the path to the directory containing the help_toc.xml file on your system.</li>
			</ul>
		</p>
	"
		html_footer
		exit
		# TextMate.exit_show_html output
	end
else
	help_dir = %x(defaults read com.macromates.textmate.actionscript FlashDocumentationPath).chomp
end

# Find matching lines...
search_results = []
open("#{help_dir}/#{HELPTOC}").each do |line|
	search_results << line.strip if line[/name=\"#{WORD}/]
end

puts html_head( :title => "Documentation for ‘#{WORD}’", :sub_title => "ActionScript Dictionary" )

# ...parse results for links...
links = []
puts "<ul>"
search_results.each do |line|
	xml_line = REXML::Document.new(line)
	puts "<li><a href=\"tm-file://#{help_dir}/#{xml_line.root.attributes['href']}\">#{xml_line.root.attributes['name']}</a></li>"
end
puts "</ul>"

# ...or display error if no matches
puts "No results :(" if search_results.size == 0

html_footer
