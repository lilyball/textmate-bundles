#!/usr/bin/env ruby

# TODO: Print stylesheet

if RUBY_VERSION =~ /^1\.6\./ then
  puts <<-HTML
<p>Sorry, but this function requires Ruby 1.8.</p>
<p>If you do have Ruby 1.8 installed (default for Tiger users) then you need to setup the path variable in <tt> ~/.MacOSX/environment.plist</tt>.</p>
<p>For detailed instructions see <a href="http://macromates.com/textmate/manual/shell_commands#search_path">the manual</a> (scroll down to the paragraph starting with <em>Important</em>.)</p>
HTML
  abort
end

require "#{ENV['TM_SUPPORT_PATH']}/lib/web_preview"

if ENV['TM_PROJECT_DIRECTORY'] == '/'
  puts html_head(:window_title => "TODO", :page_title => "TODO List", :sub_title => "Error")
  puts <<-HTML
<p>Warning: Your project directory is the root directory!</p>
<p>This is problably because you have symbolic links or file references inside your project so that the most common directory of all the files in the project resolves to `/` (root).</p>
<p>Aborting.</p>
HTML
  abort
end

require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/settings.rb"
require "#{ENV['TM_SUPPORT_PATH']}/lib/textmate"
require "erb"
require "yaml"
include ERB::Util

tags = Settings.markers.map { |marker|
  { :label => marker.name,
    :color => marker.has_color? ? marker.color : '#808080',
    :regexp => marker.regexp,
    :trim_if_empty => marker.trim?
  }
}
ignores = ENV['TM_TODO_IGNORE']

def TextMate.file_link (file, line = 0)
  return "txmt://open/?url=file://" +
    file.gsub(/([^a-zA-Z0-9.-\/]+)/) { '%' + $1.unpack('H2' * $1.size).join('%').upcase } +
    "&amp;line=" + line.to_s
end

tags.each do |tag|
  tag[:matches] = []
  tag[:rendered] = ''
end

html_head = ERB.new(File.read("#{ENV['TM_BUNDLE_SUPPORT']}/template_html_header.rhtml"), 0, '<>').result(binding)

puts html_head(:window_title => "TODO", :page_title => "TODO List", :sub_title => ENV['TM_PROJECT_DIRECTORY'], :html_head => html_head)

puts ERB.new(File.read("#{ENV['TM_BUNDLE_SUPPORT']}/template_head.rhtml"), 0, '<>').result(binding)

STDOUT.flush

home_dir = /^#{Regexp.escape ENV['HOME']}/
total = 0
TextMate.each_text_file do |file|
  next if (ignores != nil and file =~ /#{ignores}/) or File.symlink?(file)
  file_name = file.sub(home_dir, '~')
  puts ERB.new(File.read("#{ENV['TM_BUNDLE_SUPPORT']}/template_update_dir.rhtml"), 0, '<>').result(binding)
  tags.each do |tag|
    File.open(file) do |io|
      io.grep(tag[:regexp]) do |content|
        match = {
          :file => file,
          :line => io.lineno,
          :content => content,
          :type => tag[:label]
        }
        if tag[:label] == "RADAR" then
          url, display = "http://openradar.appspot.com/" + $2, "rdar://" + $2
          match[:match] = html_escape($1) + "<a href=\"" + url + "\" target=\"_blank\">" + html_escape(display) + "</a>" + html_escape($3)
        else
          match[:match] = html_escape($1)
        end
        tag[:matches] << match
        count = tag[:matches].length
        total += 1
        puts ERB.new(File.read("#{ENV['TM_BUNDLE_SUPPORT']}/template_update.rhtml"), 0, '<>').result(binding)
        tag[:rendered] += ERB.new(File.read("#{ENV['TM_BUNDLE_SUPPORT']}/template_item.rhtml"), 0, '<>').result binding
        STDOUT.flush
      end
    end if File.readable?(file)
  end
end

tmpl_file = "#{ENV['TM_BUNDLE_SUPPORT']}/template_tail.rhtml"
puts ERB.new(File.read(tmpl_file), 0, '<>').result(binding)

html_footer()

