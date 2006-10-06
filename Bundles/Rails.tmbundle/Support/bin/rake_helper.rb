#!/usr/bin/env ruby

# Copyright:
#   (c) 2006 InquiryLabs, Inc.
#   Visit us at http://inquirylabs.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Runs 'rake' and executes a particular task

require 'optparse'
require 'rails_bundle_tools'

Dir.chdir TextMate.project_directory

options = {}

task = ARGV.shift

OptionParser.new do |opts|
  opts.banner = "Usage: rake_helper.rb [options]"

  opts.separator ""
  opts.separator "Rake helper options:"

  opts.on("-q", "--question [QUESTION TEXT]", "Ask a question before running rake.") do |question|
    options[:question] = question
  end

  opts.on("-a", "--answer [ANSWER TEXT]", "Default answer for the question.") do |answer|
    options[:answer] = answer
  end
  
  opts.on("-v", "--variable [VARIABLE]", "Variable to assign the ANSWER to.") do |variable|
    options[:variable] = variable
  end

  opts.on("-t", "--title [TITLE TEXT]", "Title of pop-up window.") do |title|
    options[:title] = title
  end
end.parse!

if options[:question]
  unless options[:answer] = TextMate.input(optional_question, options[:answer] || "", :title => options[:title] || "Rake")
    TextMate.exit_discard
  end
end

command = "rake #{task}"
if options[:variable] && options[:answer]
  command += " #{options[:variable]}=#{options[:answer]}"
end
output = `#{command}`

# puts "<span style='color:blue; font-size: 1.2em'>#{options.inspect}</span><br>"

puts "<span style='color:red; font-size: 1.2em'>#{command}</span><br>"

styles = ["table {padding-left: 2em;}", "td {padding-right: 1.5em;}", ".time {color: #f99; font-weight: bold}"]

report = "<style>#{styles.join}</style>"
report += "<h1>Migration Report</h1>"
inside_table = false
output.each_line do |line|
  case line
    when /^==\s+/
      # Replace == headings with <h2></h2>
      line.gsub!(/^==\s+([^=]+)[=\s]*$/, "<h2>\\1</h2>")
      # Replace parenthetical times with time class
      line.gsub!(/(\([\d\.]+s\))/, "<span class=\"time\">\\1</span>")
      # Show details inside table
      if !inside_table
        line << "<table>"
      else
        line << "</table>"
      end
      inside_table = !inside_table
    when /^--\s+(.+)$/
      # Show command inside table cell
      line = "<tr><td>#{$1}</td>"
    when /^\s+->(.+)$/
      # Show execution time inside table cell
      line = "<td class=\"time\">#{$1}</td></tr>\n"
    else
      line += "<br/>"
  end
  report << line
end
report << "</table>" if inside_table

puts report
