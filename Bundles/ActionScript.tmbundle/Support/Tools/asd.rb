#!/usr/bin/env ruby
#
# Ale Muñoz <ale@bomberstudios.com> - 2006-11-25
# Feel free to use and improve...

require "#{ENV["TM_SUPPORT_PATH"]}/lib/web_preview"
require "rexml/document"

WORD    = ENV['TM_CURRENT_WORD']
HELPDIR		= ENV['TM_FLASH_HELP']
HELPTOC		= 'help_toc.xml'

# Help dir not set?
if !HELPDIR
	puts html_head(
		:title => "Error!",
		:subtitle => "Find in ActionScript Dictionary"
	)
	puts <<HEREDOC
	<h1>Search failed for #{WORD}</h1>
	<p>In order for this command to work TextMate needs to know where to find the ActionScript Dictionary index file. This is set in <strong>Preferences > Advanced > Shell Variables</strong>.</p>
	<p>Click <strong>+</strong> and name the variable <code>TM_FLASH_HELP</code> with value of the path to the directory containing the help_toc.xml file on your system.</p>
	<p>Macromedia have made this tricky and the files arent always in the same place.</p>
	<p>Try clicking the following links:
	<ul>
	<li><a href="txmt://open?url=file:///Users/Shared/Library/Application Support/Macromedia/Flash 8/en/Configuration/HelpPanel/Help/ActionScriptLangRef/help_toc.xml">//Users/Shared/Library/Application Support/Macromedia/Flash 8/en/Configuration/HelpPanel/Help/ActionScriptLangRef</a></li>
	<li><a href="txmt://open?url=file:///Users/Shared/Library/Application Support/Macromedia/Flash MX 2004/en/Configuration/HelpPanel/Help/ActionScriptLangRef/help_toc.xml">//Users/Shared/Library/Application Support/Macromedia/Flash MX 2004/en/Configuration/HelpPanel/Help/ActionScriptLangRef</a></li>
	<li><a href="txmt://open?url=file:///Applications/Macromedia Flash MX 2004/First Run/HelpPanel/Help/ActionScriptDictionary">/Applications/Macromedia Flash MX 2004/First Run/HelpPanel/Help/ActionScriptDictionary</a></li>
	</ul>
	<p>If any of the links work (TextMate will open the help_toc.xml file) then copy and paste the link, omitting the /help_toc.xml on the end, to the path of the shell variable.
HEREDOC
	html_footer
else

	# Open TOC...
	toc_lines = IO.readlines(HELPDIR + "/" + HELPTOC)

	# ...find matching lines...
	search_results = []
	toc_lines.each do |line|
		search_results << line.strip if line[/name=\"#{WORD}/]
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

end