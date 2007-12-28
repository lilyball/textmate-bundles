#!/usr/bin/env ruby -wKU

require "rexml/document"

#Locates the ServerRoot path.
def findServerRoot
    conf = File.open( ENV['TM_FILEPATH'], "r" )
    conf.each do |line|
        if line =~ /^ServerRoot/ 
            return line.sub( "ServerRoot \"", "").sub("\"\n","")
        end
    end
    return ""
end

# Generates a completion list based on the prescribed document.
#
# TODO: Automatically locate modules and directives
#       /Library/WebServer/share/httpd/manual/mod/directives.html       
# TODO: Update the xPath definition to use the directives.html.
#
# Example useage: generateDefinitionCompletions( "directive_list.xml" )
#
def generateDefinitionCompletions( directive_list )

    completions = "{ completions = ( "
    
    directive_doc = REXML::Document.new File.new(directive_list)
    
    directive_doc.elements.each( "ul/li/a" ) do |tag|
        completion = tag[0].to_s.sub("&lt;","").sub("&gt;","");
        completions += "'" + completion + "',"
    end
        
    completions = completions.chop + " ); }"
    print completions
    
end

# TODO: generateModuleCompletions
# /Library/WebServer/share/httpd/manual/mod/index.html
#def generateModuleCompletions( module_list )
#end
