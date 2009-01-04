#!/usr/bin/env ruby
# encoding: utf-8

#
# Ale Muñoz <ale@bomberstudios.com> - 2006-11-25
# Feel free to use and improve
# 
# Gaby Vanhegan <gaby@vanhegan.knet> - 2007-05-16
# Amended to search all actionscript help folders. This makes all
# the component, flash lite, remoting, etc help available in the
# help browser.


require ENV['TM_SUPPORT_PATH'] + "/lib/exit_codes"
require ENV['TM_SUPPORT_PATH'] + "/lib/escape"
require ENV['TM_SUPPORT_PATH'] + "/lib/progress"
require ENV["TM_SUPPORT_PATH"] + "/lib/web_preview"
require "rexml/document"

WORD    = ENV['TM_CURRENT_WORD']
HELPTOC = '/help_toc.xml'

def nice_name toc_file
  toc_lines = IO.readlines(toc_file)
  return toc_lines[1].match(/[A-Z][A-Za-z0-9\s.,_]*/).to_s
end

def get_help_dirs
  help_dirs = []
  help_dirs_options = [
    "/Library/Application Support/Adobe/Flash CS3/en/Configuration/HelpPanel/Help/",
    "#{ENV['HOME']}/Library/Application Support/Adobe/Flash CS3/en/Configuration/HelpPanel/Help/",
    "/Users/Shared/Library/Application Support/Macromedia/Flash 8/en/Configuration/HelpPanel/Help/",
    "/Users/Shared/Library/Application Support/Macromedia/Flash MX 2004/en/Configuration/HelpPanel/Help/"
  ]
  # Try to locate help dir
  help_dirs_options.each do |path|
    if File.exist? "#{path}"
      help_dirs << path
    end
  end
  if help_dirs.empty?
    # Help dir not found...
    puts html_head({:title => "Error!", :sub_title => "Find in ActionScript Dictionary"})
    puts "
    <h1>Search failed for “#{WORD}”</h1>
    <p>In order for this command to work TextMate needs to know where to find the ActionScript Dictionary index file. The commands tries to find it in the following places:</p>
    <ul>"
    help_dirs_options.each do |path|
      puts "<li>#{path}</li>"
    end
    puts "</ul>
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
    # exit
    TextMate.exit_show_html
  end
  return help_dirs
end

def get_search_dirs
  search_dirs = []
  get_help_dirs.each do |search_dir|
    Dir.entries(search_dir).each do |dir|
      search_dirs.push( search_dir + dir ) if File.exists?(search_dir + dir + HELPTOC);
    end
  end
  return search_dirs
end

def find_matching_lines
  search_results = {}
  get_search_dirs.each do |path|
    current_toc_file = path + HELPTOC
    IO.readlines("#{current_toc_file}").each do |line|
      if line.match(/name=\"#{WORD}/)
        section = nice_name(current_toc_file)
        if search_results[section].nil?
          search_results[section] = []
        end
        xml_line = REXML::Document.new(line.strip)
        search_results[section] << "<li><a href=\"tm-file://#{path}/#{xml_line.root.attributes['href']}\">#{xml_line.root.attributes['name']}</a></li>"
      end
    end
  end
  return search_results
end

puts html_head( :title => "Documentation for ‘#{WORD}’", :sub_title => "ActionScript Dictionary" )

matches = find_matching_lines
if matches.length > 0
  find_matching_lines.each do |section|
    puts "<h3>" + section[0] + "</h3>"
    puts "<ul>"
    section.shift
    section.each do |match|
      puts match
    end
    puts "</ul>"
  end
else
  puts "No results :("
end

html_footer
TextMate.exit_show_html