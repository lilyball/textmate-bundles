#!/usr/bin/env ruby
# encoding: utf-8

SUPPORT    = ENV['TM_SUPPORT_PATH']
FL_HELPDIR = '/Library/Application Support/Adobe/Flash CS3/en/Configuration/HelpPanel/help/ExtendingFlash/'
FL_HELPTOC = FL_HELPDIR+'help_toc.xml'

require "rexml/document"
require SUPPORT + '/lib/exit_codes'
require SUPPORT + "/lib/escape"
require SUPPORT + "/lib/progress"
require SUPPORT + "/lib/web_preview"
require SUPPORT + '/lib/ui'

if File.exist?(FL_HELPTOC)
	
	flash_lang_intro = "<a href=\"tm-file://#{FL_HELPDIR}00003797.html\" title=\"Extending Flash Reference - Introduction\">Introduction to Extending Flash</a><br>"
	flash_lang_methods = "<a href=\"tm-file://#{FL_HELPDIR}00003813.html\" title=\"Extending Flash Reference - Top Level Functions and Methods\">Top Level Functions and Methods</a><br>"
	flash_lang_objects = "<a href=\"tm-file://#{FL_HELPDIR}00003831.html\" title=\"Extending Flash Reference - Objects\">Object List</a><br>" 

end

word = STDIN.read.strip

word = TextMate::UI.request_string( :title => "ActionScript 3 Help Search",
                            		:prompt => "Enter a term to search for:",
                            		:button1 => "search") if word.empty?

TextMate.exit_discard if !word

word = word.gsub("&", "&amp;").gsub("<", "&lt;")

puts html_head( :title => "Documentation for ‘#{word}’", :sub_title => "Extending Flash Dictionary" )

if File.exist?( FL_HELPTOC )
	
		puts "<h1>Search results for <span class=\"search\">‘#{word}’</span></h1><span class=\"search_results\"><p>" 
    
    puts flash_lang_intro
    puts flash_lang_methods
    puts flash_lang_objects
 
    # Open TOC
    toc_lines = IO.readlines( FL_HELPTOC )
        
    # find matching lines
    search_results = []
    toc_lines.each do |line|
        search_results << line.strip if line[/name=\".*#{word}/]
    end
    
    if search_results.size > 0

        puts "<p><ul>"

		collected_results = []
		
        #parse results for links        
        search_results.each do |line|
            xml_line = REXML::Document.new(line)
            help_path = xml_line.root.attributes['href']
            help_class = xml_line.root.attributes['name']
            collected_results << "<li><a href=\"tm-file://#{FL_HELPDIR}#{help_path}\">#{help_class}</a></li>"
        end
		
		collected_results = collected_results.uniq
		puts collected_results
		
        puts "</ul></p>"

	else    	
        puts "<ul><li>No results</li></ul><br>"
	end

else
	
	puts "<h1>Help Not Found.</h1><br><p>Please note this bundle has only been tested with Flash CS3, and is unlikely to work completely with other versions of the Flash authoring environment.<p><br/>"	
	
end

puts "<a title=\"Search Adobe Livedocs for #{word}\" href=\"http://livedocs.adobe.com/cfusion/search/index.cfm?loc=en_US&termPrefix=site%3Alivedocs.macromedia.com%2Fflex%2F201++&term=site%3Alivedocs.macromedia.com%2Fflex%2F201++%22#{word}%22&area=&search_text=#{word}&action=Search\">Search Livedocs</a></p>"

html_footer
TextMate.exit_show_html
