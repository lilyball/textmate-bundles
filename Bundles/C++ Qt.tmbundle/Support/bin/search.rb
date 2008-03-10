#! /usr/bin/env ruby
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/rails_bundle_tools'

# NOTE: In order to use this script, you must 
# have already run Qt Assistant application,
# because assistant_search does not regenerate
# indices on its own - it relies on the ones
# built by Qt Assistant.

# Displays Qt help in TextMate's HTML window.
#
# When "fuzzy" is passed on command line, fuzzy 
# search is performed - i.e. it displays all
# topics relevant to search string, not only
# the most relevant one.
#
# When "input" is passed on command line,
# input dialog appears, and you can input
# query string in it. Useful for opening documentation
# on some specific topic.
#
# If there were error, assistant_search writes them
# to stderr, which is passed directly to HTML window,
# so this script only parses assistant topics.

# apparently, sometimes, if there are several TextMate HTML
# windows open, this function has no visible effect.
# maybe I should report that to Allan.
def close_browser
  puts '<script name="JavaScript">window.close();</script>'
end

def redirect(url)
  puts "<meta http-equiv='Refresh' content='0;URL=tm-file://#{url}'>"
end

do_fuzzy = ARGV.find { |a| a == "fuzzy" }
do_input = ARGV.find { |a| a == "input" }

begin
  query = STDIN.readline.chomp # TextMate.selected_text || TextMate.current_word
rescue
  query = nil
end
query = TextMate::UI.request_string(
  :title => "Documentation Search", 
  :default => query ? query : "",
  :prompt => "Input search word:",
  :button1 => 'Search'
) if do_input

if query.nil? or query.length < 1
  close_browser
  exit
end

text = `"#{ENV['TM_BUNDLE_SUPPORT']}/lib/assistant_search/assistant_search" "#{query}" #{do_fuzzy}`

results = []
text.each_line do |line|
  results << [$1, $2] if line =~ /\* ([^\|]+)\|file\:(.+)$/
end

def select_item(query, items)
  items.map! { |i| i.gsub("\"", "\\\"") }
  items.map! { |i| "\"#{i}\"" }
  o = IO.popen("/usr/bin/osascript", "w+")
  o.puts 'tell app "TextMate"'
  o.puts "  choose from list { #{items.join(", ")} } " +
         '      with title "Choose Topic" ' +
         "      with prompt \"Choose a topic for '#{query}'\""
  o.puts 'end tell'
  o.close_write
  o.gets.chomp
end

if results.length == 1
  redirect(results[0][1])
elsif results.length > 1
  topic = select_item(query, results.map { |i| i[0] })
  link = results.find { |i| topic == i[0] }
  if !link.nil?
    redirect(link[1])
  else
    close_browser
  end
end