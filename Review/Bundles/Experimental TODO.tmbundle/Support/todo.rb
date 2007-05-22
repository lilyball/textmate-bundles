#!/usr/bin/env ruby

# TODO: Fix relative Links wrt offset header
# TODO: Hide categories with no items (like radar)

$tags = [
  { :label => "FIXME",   :color => "#A00000", :regexp => /FIX ?ME[\s,:]+(\S.*)$/i },
  { :label => "TODO",    :color => "#CF830D", :regexp => /TODO[\s,:]+(\S.*)$/i    },
  { :label => "CHANGED", :color => "#008000", :regexp => /CHANGED[\s,:]+(\S.*)$/  },
  { :label => "RADAR",   :color => "#0090C8", :regexp => /(.*<)ra?dar:\/(?:\/problem|)\/([&0-9]+)(>.*)$/, :trim_if_empty => true },
]

if RUBY_VERSION =~ /^1\.6\./ then
  puts <<-HTML
<p>Sorry, but this function requires Ruby 1.8.</p>
<p>If you do have Ruby 1.8 installed (default for Tiger users) then you need to setup the path variable in <tt> ~/.MacOSX/environment.plist</tt>.</p>
<p>For detailed instructions see <a href="http://macromates.com/textmate/manual/shell_commands#search_path">the manual</a> (scroll down to the paragraph starting with <em>Important</em>.)</p>
HTML
  abort
end

require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
require "#{ENV['TM_SUPPORT_PATH']}/lib/textmate"
require "#{ENV['TM_SUPPORT_PATH']}/lib/web_preview"
require "erb"
include ERB::Util

ignores = ENV['TM_TODO_IGNORE']

def TextMate.file_link (file, line = 0)
  return "txmt://open/?url=file://" +
    file.gsub(/[^a-zA-Z0-9.-\/]/) { |m| sprintf("%%%02X", m[0]) } +
    "&amp;line=" + line.to_s
end

# output header
options_a = []
$tags.each do |tag|
  tag[:matches] = []
  tag[:rendered] = ''
  options_a << ".bg_#{tag[:label]} {background-color: #{tag[:color]}; color: #FFF; padding: 0.5ex;}"
  options_a << "\#jump_to_#{tag[:label]} {color: #{tag[:color]};}"
  options_a << "tr.#{tag[:label]} {color: #{tag[:color]}}"
end

options = '<style type="text/css">' + options_a.join("\n") + '</style>'

puts html_head(:window_title => "TODO", :page_title => "TODO List", :sub_title => 'TODO', :html_head => options)
tmpl_file = "#{ENV['TM_BUNDLE_SUPPORT']}/template_head.rhtml"
puts ERB.new(File.open(tmpl_file), 0, '<>').result
# puts '<table class="todo">'
STDOUT.flush

$total = 0
TextMate.each_text_file do |file|
  next if (ignores != nil and file =~ /#{ignores}/) or File.symlink?(file)
  $tags.each do |tag|
    File.open(file) do |io|
      io.grep(tag[:regexp]) do |content|
        $match = {
          :file => file,
          :line => io.lineno,
          :content => content,
          :type => tag[:label]
        }
        if tag[:label] == "RADAR" then
          url = "rdar://" + $2
          $match[:match] = html_escape($1) + "<a href=\"" + url + "\">" + html_escape(url) + "</a>" + html_escape($3)
        else
          $match[:match] = html_escape($1)
        end
        tag[:matches] << $match
        $count = tag[:matches].length
        $total += 1
        puts ERB.new(File.open("#{ENV['TM_BUNDLE_SUPPORT']}/template_update.rhtml"), 0, '<>').result
        tag[:rendered] += ERB.new(File.open("#{ENV['TM_BUNDLE_SUPPORT']}/template_item.rhtml"), 0, '<>').result
        STDOUT.flush
      end
    end if File.readable?(file)
  end
end

# trim tags that didn't match, if requested
# $tags.delete_if { |tag| tag[:trim_if_empty] and tag[:matches].empty? }

tmpl_file = "#{ENV['TM_BUNDLE_SUPPORT']}/template_tail.rhtml"
puts ERB.new(File.open(tmpl_file), 0, '<>').result

html_footer()

