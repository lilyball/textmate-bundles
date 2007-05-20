#!/usr/bin/env ruby
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

def nice_name section_name
  section_names = {
    "ActionScriptLangRefV2" => "ActionScript 2.0",
    "ActionScriptLangRefV3" => "ActionScript 3.0",
    "FlashLiteAPIReference1" => "Flash Lite 1.0",
    "FlashLiteAPIReference2" => "Flash Lite 2.0",
    "ComponentsRef" => "Components Reference",
    "ExtendingFlash" => "Extending Flash",
    "FlashLite2DevGuide" => "Flash Lite 2.0 Dev Guide"
  }
  if section_names[section_name].nil?
    return section_name
  else
    return section_names[section_name].to_s
  end
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
  search_results = []
  get_search_dirs.each do |path|
    current_toc_file = path + HELPTOC
    IO.readlines("#{current_toc_file}").each do |line|
      if line.match(/name=\"#{WORD}/)
        section = nice_name(File.dirname(current_toc_file).split("/").last)
        xml_line = REXML::Document.new(line.strip)
        search_results << "<li>#{section}: <a href=\"tm-file://#{path}/#{xml_line.root.attributes['href']}\">#{xml_line.root.attributes['name']}</a></li>"
      end
    end
  end
  return search_results
end

puts html_head( :title => "Documentation for ‘#{WORD}’", :sub_title => "ActionScript Dictionary" )

matches = find_matching_lines
if matches.length > 0
  puts "<ul>"
  find_matching_lines.each do |line|
    puts line
  end
  puts "</ul>"
else
  puts "No results :("
end

html_footer
TextMate.exit_show_html