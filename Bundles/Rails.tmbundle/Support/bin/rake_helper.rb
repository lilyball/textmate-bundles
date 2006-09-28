#!/usr/bin/env ruby

# Copyright:
#   (c) 2006 InquiryLabs, Inc.
#   Visit us at http://inquirylabs.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Runs 'rake' and executes a particular task

require 'rails_bundle_tools'

Dir.chdir ENV['TM_PROJECT_DIRECTORY']
task = ARGV.shift
optional_question = ARGV.shift
optional_prefix = ARGV.shift

if optional_question
  optional_answer = TextMate.input(optional_question, "", :title => "Rake")
end

command = "rake #{task}"
command += " #{optional_prefix}=#{optional_answer}" if optional_answer
output = `#{command}`

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
