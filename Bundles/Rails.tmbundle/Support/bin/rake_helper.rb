#!/usr/bin/env ruby

# Copyright:
#   (c) 2006 InquiryLabs, Inc.
#   Visit us at http://inquirylabs.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Runs 'rake' and executes a particular task

require 'optparse'
require 'rails_bundle_tools'
require "#{ENV["TM_SUPPORT_PATH"]}/lib/escape"

$RAKEMATE_VERSION = "$Revision: 15 $"

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
command += " #{options[:variable]}=#{options[:answer]}" if options[:variable] && options[:answer]

# puts "<span style='color:blue; font-size: 1.2em'>#{options.inspect}</span><br>"

reports = {
  "migrate" => "Migration Report",
  "db:migrate" => "Migration Report"
}

map = {
  'TASK'              => task,
  'COMMAND'           => command,
  'REPORT_TITLE'      => reports[task] || "Rake Report",
  'RAKEMATE_VERSION'  => $RAKEMATE_VERSION[/\d+/],
  'BUNDLE_SUPPORT'    => "tm-file://#{ENV['TM_BUNDLE_SUPPORT'].gsub(/ /, '%20')}",
  'TM_SUPPORT_PATH'   => ENV['TM_SUPPORT_PATH'],
  'TM_HTML_LANG'      => ENV['TM_MODE'],
  'TM_HTML_TITLE'     => 'RakeMate',
  'TM_HTML_THEME'     => %x{bash -c #{e_sh ". #{e_sh ENV['TM_SUPPORT_PATH']}/lib/webpreview.sh && selected_theme"}}.chomp,
  'TM_EXTRA_HEAD'     => '',
  'TM_CSS'            => `cat "${TM_SUPPORT_PATH}/css/webpreview.css" | sed "s|TM_SUPPORT_PATH|${TM_SUPPORT_PATH}|"`,
}

puts DATA.read.gsub(/\$\{([^}]+)\}/) { |m| map[$1] }
$stdout.flush

output = `#{command}`
lines = output.to_a
# Remove the test output from rake output
lines.pop if lines[-1] =~ /0 tests, 0 assertions, 0 failures, 0 errors/

report = ""

case task
when "db:migrate", "migrate"
  inside_table = false
  lines.each do |line|
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
else
  report += lines.join("<br>")
end

report += "<div class='done'>Done</div>"
puts report

puts <<-HTML
      </div>
    </div>
  </body>
</html>
HTML

__END__
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <title>RakeMate — ${TASK}</title>
  <style type="text/css" media="screen">
    ${TM_CSS}
    div#report_title {font-size: 1.2em; font-weight: bold; margin-top: 0.5em; margin-bottom: 1em;}
    div#rake_command {font-size: 0.9em; font-weight: bold; margin-bottom: 0.5em;}
    table {padding-left: 2em;}
    td {padding-right: 1.5em;}
    .time {color: #f99; font-weight: bold}
    .done {color: #b55; font-weight: bold; font-size: 1.1em;}
  </style>
  <script src="file://${TM_SUPPORT_PATH}/script/default.js" type="text/javascript" language="javascript" charset="utf-8"></script>
  <script src="file://${TM_SUPPORT_PATH}/script/webpreview.js" type="text/javascript" language="javascript" charset="utf-8"></script>
  ${TM_EXTRA_HEAD}
</head>
<body id="tm_webpreview_body" class="${TM_HTML_THEME}">
  <div id="tm_webpreview_header">
    <p class="headline">${TM_HTML_TITLE}</p>
    <p class="type">${TM_HTML_LANG}</p>
    <img class="teaser" src="file://${TM_SUPPORT_PATH}/images/gear2.png" alt="teaser" />
    <div id="theme_switcher">
      <form action="#" onsubmit="return false;">
        Theme: 
        <select onchange="selectTheme(this.value);" id="theme_selector">
          <option>bright</option>
          <option>dark</option>
          <option value="default">no colors</option>
        </select>
      </form>
    </div>
  </div>
  <div id="tm_webpreview_content" class="${TM_HTML_THEME}">
    <div id="report_title">${REPORT_TITLE}</div>
    <div id="rake_command">${COMMAND}</div>
    <div><!-- Script output -->