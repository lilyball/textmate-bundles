#!/usr/bin/env ruby
require "#{ENV['TM_SUPPORT_PATH']}/lib/progress.rb"
require "#{ENV['TM_SUPPORT_PATH']}/lib/exit_codes.rb"
require "#{ENV['TM_SUPPORT_PATH']}/lib/ui.rb"

def show_url(url)
  TextMate.exit_show_html "<meta http-equiv='Refresh' content='0;URL=tm-file://#{url}'>"
end

def show_documentation(searchPath)
  show_url(searchPath + "index.html")
end

def show_help(searchPath, searchTerm)
  Dir.chdir(searchPath)
  classResults = Dir.glob("**/" +searchTerm + ".html")
  objectResults = Dir.glob("**/" +searchTerm + "$object.html")  
  results = classResults + objectResults

  if results.length == 0
    TextMate.exit_show_tool_tip "Cannot find documentation for #{searchTerm}." 
  elsif results.length == 1
    show_url(searchPath + results[0])
  else
    strResults = "Multiple results for " + searchTerm + "<BR />"
    results.each do |result|
      displayText = result.tr("/", ".")[0..-6] # change path to object notation and remove ".html" from end
      strResults += "<a href='tm-file://#{searchPath}#{result}'>" + displayText + "</a> <BR />"
    end
    TextMate.exit_show_html strResults
  end
end

scalaDocPath = ENV['SCALA_DOC']
searchTerm = ENV['SEARCH_TERM']

if (not scalaDocPath) or  scalaDocPath == "" then
  TextMate.exit_create_new_document "Please set the SCALA_DOC TM shell variable to directory containing the scala api index.html file. \n" +
                              "For example /usr/local/scala/share/doc/scala/api.  \n" +
                              "You can set this by going to Preferences->Advanced->Shell Variables"
end

scalaDocPath += "/" if(not scalaDocPath.index(/\/$/))

if (not searchTerm) or (searchTerm.strip.length == 0)
  show_documentation(scalaDocPath)
else
  show_help(scalaDocPath, searchTerm)
end

