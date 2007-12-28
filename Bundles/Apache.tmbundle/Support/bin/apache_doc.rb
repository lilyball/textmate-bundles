#!/usr/bin/env ruby

SUPPORT = ENV['TM_SUPPORT_PATH']

require "rexml/document"
require 'net/http'
require SUPPORT + '/lib/exit_codes'
require SUPPORT + "/lib/web_preview"

APACHE_HELP_DICT = ENV['TM_BUNDLE_SUPPORT'] + '/data/apache_doc_dictionary.xml'

# Work out what uri to use for the manual

# If the user has specified the path use it, 
# otherwise fall back on the default apple 
# install location, then onto the apache website.

apache_web_manual = "http://httpd.apache.org/docs/2.2"
localhost_manual  = "http://localhost/manual"
file_manual       = "/Library/WebServer/share/httpd/manual"
user_manual       = ENV['TM_APACHE_MANUAL_URI']
apache_manual_uri = if !user_manual then localhost_manual else user_manual end

#First check the http connection and location appear valid.
if apache_manual_uri =~ /^http:\/\//

    begin

        #Try and see if we can reach our server.
        httpd_running = Net::HTTP.get_response(URI.parse( apache_manual_uri ))
        unless httpd_running === Net::HTTPSuccess or httpd_running === Net::HTTPRedirection
            #If we can't use it try file://.
            apache_manual_uri = file_manual
        end
    #rescue SocketError    
    rescue Error

        #If we can't get to the server then fall back to tm-file://
        #TODO: Check the Error "Superclass" assumption otherwise this will fail.
        #TODO: If the user has specifed the uri and it fails warn them.
        apache_manual_uri = file_manual
    
    end
end        

if File.directory? apache_manual_uri
    apache_manual_uri = "tm-file://" + apache_manual_uri
else
    #We could loop back and check for an internet connection...
    apache_manual_uri = apache_web_manual
end

#Strip trailing slashes.
apache_manual_uri  = apache_manual_uri.gsub( /\/$/, '' )
apache_manual_lang = "en" #Only ja.euc-jp and .ko.euc-kr seem to be viable alternatives.

WORD = STDIN.read.strip

#Temp detection of OS and if it's < Leopard, stick with the old system.
#This is because I don't have Tiger to test against at the moment.
system_version = `defaults read /System/Library/CoreServices/SystemVersion ProductVersion`
unless system_version =~ /10.5.*/
    print "<html><head><meta http-equiv=\"Refresh\" content=\"0; http://search.apache.org/index.cgi?query=#{WORD}\"></head><body></body></html>"
end

if WORD.empty?
    
    puts html_head( :title => "Error", :sub_title => "Apache Documentation" )
    puts "<h1>Please specify a search term.</h1>"
    puts "<p><a href='" + apache_manual_uri + "/index.html."+apache_manual_lang+"'>Apache Manual</a></p>"
    html_footer
    TextMate.exit_show_html

end

puts html_head( :title => "Apache Documentation Search", :sub_title => "Apache HTTP Server" )
puts "<h1>Results for ‘#{WORD}’</h1><p>"

# Open the APACHE_HELP_DICT xml file and
# collect matching results.

search_results = [];
apache_doc = REXML::Document.new File.new(APACHE_HELP_DICT)
apache_doc.elements.each( "dict/a" ) do |tag|

    e = tag[0].to_s
    if e[/#{WORD}/i]
        href = tag.attributes["href"]
        tag.attributes["href"] = apache_manual_uri + "/" + href.sub( ".html", ".html." + apache_manual_lang);
        tag.attributes["title"] = href.split(/\/|\#/).join( " > " ).sub( ".html", "");
        search_results.push( tag )
    end
    
end

if search_results.size == 1

    puts "<meta http-equiv=\"refresh\" content=\"0; #{search_results[0].attributes['href']}\">"
    puts "<ul><li>#{WORD} Found, redirecting..</li></ul></p>"
       
elsif search_results.size > 0
    
    puts "<p><ul>"
    search_results.each { |tag| puts "<li>" + tag.to_s + "</li>" }
    puts "</ul></p>"    

else

   puts "<ul><li>No results.</li></ul></p>"

end

puts "Apache: <a href='" + apache_manual_uri + "/index.html."+apache_manual_lang+"' title='Located Manual'>Manual</a>,"
puts "<a href='" + apache_web_manual + "/index.html' title='Online Manual'>Website</a><br/>"

html_footer
TextMate.exit_show_html
