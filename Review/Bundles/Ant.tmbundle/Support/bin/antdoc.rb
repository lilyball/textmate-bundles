#!/usr/bin/env ruby

SUPPORT = ENV['TM_SUPPORT_PATH']

require "rexml/document"
require SUPPORT + '/lib/exit_codes'
require SUPPORT + "/lib/web_preview"

ANT_HELP_DICT = ENV['TM_BUNDLE_SUPPORT'] + '/data/ant_doc_dictionary.xml'

# Work out what uri to use for the manual
# If the user has specified the path use it, 
# otherwise fall back on the default apple 
# developer tools install location, then onto 
# the apache website.

ant_manual_path = "/Developer/Java/Ant/docs/manual" if !ENV['TM_ANT_MANUAL_PATH']
ant_manual_uri = "http://ant.apache.org/manual"
ant_manual_uri = "tm-file://" + ant_manual_path if File.directory? ant_manual_path
ant_manual_uri = ant_manual_uri.gsub( /\/$/, '' )

WORD = STDIN.read.strip

if WORD.empty?
    
    puts html_head( :title => "Error", :sub_title => "Ant Documentation" )
    puts "<h1>Please specify a search term.</h1>"
    puts "<p><a href='" + ant_manual_uri + "/index.html'>Ant Manual</a></p>"
    html_footer
    TextMate.exit_show_html

end

puts html_head( :title => "Ant Documentation Search", :sub_title => "Apache Ant" )
puts "<h1>Results for ‘#{WORD}’</h1><p>"

# Open the ANT_HELP_DICT xml file and
# collect matching results.

search_results = [];
ant_doc = REXML::Document.new File.new(ANT_HELP_DICT)
ant_doc.elements.each( "dict/a" ) do |tag|

    e = tag[0].to_s
    if e[/#{WORD}/i]
        href = tag.attributes["href"]
        tag.attributes["href"] = ant_manual_uri + "/" + href;
        tag.attributes["title"] = href.split(/\/|\#/).join( " > " ).sub( ".html", "");
        search_results.push( tag )
    end
    
end

if search_results.size == 1

    puts "<p>Redirecting: <ul>"
    puts "<li>" + search_results[0].to_s + "</li>"
    puts "<meta http-equiv=\"refresh\" content=\"0; #{search_results[0].attributes['href']}\">"
    puts "</ul></p>"
    
elsif search_results.size > 0
    
    puts "<p><ul>"
    search_results.each { |tag| puts "<li>" + tag.to_s + "</li>" }
    puts "</ul></p>"

else

   puts "<ul><li>No results in Core or Optional Task Lists</li></ul></p>" 

end

puts "<a href='" + ant_manual_uri + "/index.html'>Ant Manual</a>"

html_footer
TextMate.exit_show_html
