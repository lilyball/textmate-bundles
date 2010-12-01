# tm/htmloutput.rb

# Provides an API function in the TextMate namespace TextMate::HTMLOutput.show
# This function expects a block, and basically just calls web_preview's html_header
# before the block is executed, and html_footer after the block is executed.

# The block itself is given an io object (stdout) to which it can write whatever html it
# would like to have appear between the header and footer.

# Call it like this:

# TextMate::HTMLOutput.show(:title => "My Title", :sub_title => "Your subtitle") do |io|
#   io << «something something»
# end

require 'erb'
require 'cgi'
require "#{ENV['TM_SUPPORT_PATH']}/lib/escape.rb"

HTMLOUTPUT_TEMPLATE = <<-HTML
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <meta http-equiv="Content-type" content="text/html; charset=utf-8">
  <title><%= window_title %></title>
  <%- screen_themes.each do |style| -%>
  <link rel="stylesheet" href="file://<%= e_url style %>/style.css" type="text/css" charset="utf-8" media="screen">
  <%- end -%>
  <%- print_themes.each do |style| -%>
  <link rel="stylesheet" href="file://<%= e_url style %>/print.css" type="text/css" charset="utf-8" media="print">
  <%- end -%>
  <script src="file://<%= e_url support_path %>/script/default.js"    type="text/javascript" charset="utf-8"></script>
  <script src="file://<%= e_url support_path %>/script/webpreview.js" type="text/javascript" charset="utf-8"></script>
  <script src="file://<%= e_url support_path %>/script/sortable.js"   type="text/javascript" charset="utf-8"></script>
  <%= html_head -%>
</head>
<body id="tm_webpreview_body" class="<%= html_theme %>">
  <div id="tm_webpreview_header">
    <img id="gradient" src="file://<%= theme_path %>/images/header.png" alt="header">
    <p class="headline"><%= page_title %></p>
    <p class="type"><%= sub_title %></p>
    <img id="teaser" src="file://<%= theme_path %>/images/teaser.png" alt="teaser">
    <div id="theme_switcher">
      <form action="#" onsubmit="return false;">
        <div>
          Theme:        
          <select onchange="selectTheme(event);" id="theme_selector">
            <%- screen_themes.sort { |lhs, rhs| File.basename(lhs) <=> File.basename(rhs) }.each do |path| -%>
              <%- if path =~ %r{^.*/((.)([^/]*))$} -%>
            <option value="<%= $1 %>" title="<%= path %>"><%= $2.upcase + $3 %></option>
              <%- end -%>
            <%- end -%>
          </select>
        </div>
        <script type="text/javascript" charset="utf-8">
          document.getElementById('theme_selector').value = '<%= html_theme %>';
        </script>
      </form>
    </div>
  </div>
  <div id="tm_webpreview_content" class="<%= html_theme %>">
HTML

module TextMate
  module HTMLOutput
    class << self
      def show(options = { }, &block)
        $stdout << header(options)
        $stdout.sync = true
        block.call($stdout)
        $stdout << footer()
      end

      def header(options)
        window_title = options[:window_title] || options[:title]    || 'Window Title'
        page_title   = options[:page_title]   || options[:title]    || 'Page Title'
        sub_title    = options[:sub_title]    || ENV['TM_FILENAME'] || 'untitled'
        html_head    = options[:html_head]    || ''

        if options[:fix_href] && File.exist?(ENV['TM_FILEPATH'].to_s)
          require "cgi"
          html_head << "<base href='tm-file://#{CGI.escape(ENV['TM_FILEPATH'])}'>"
        end

        screen_themes, print_themes = collect_themes
        html_theme = selected_theme
        theme_path = screen_themes.find { |e| e =~ %r{.*/#{html_theme}$} }

        support_path = ENV['TM_SUPPORT_PATH']

        ERB.new(HTMLOUTPUT_TEMPLATE, 0, '%-<>').result(binding)
      end

      def footer
      	"  </div>\n</body>\n</html>"
      end
      
      private
      
      def collect_themes
        screen = [ ]
        print  = [ ]

        paths = ENV['TM_THEME_PATH'].to_s.split(/:/)
        paths << "#{ENV['TM_SUPPORT_PATH']}/themes"
        paths << "#{ENV['TM_BUNDLE_SUPPORT']}/css" if ENV.has_key? 'TM_BUNDLE_SUPPORT'
        paths << "#{ENV['HOME']}/Library/Application Support/TextMate/Themes/Webpreview"

        paths.each do |path|
          Dir.foreach(path) do |file|
            screen << "#{path}/#{file}" if File.exist?("#{path}/#{file}/style.css")
            print  << "#{path}/#{file}" if File.exist?("#{path}/#{file}/print.css")
          end if File.exists? path
        end

        return [ screen, print ]
      end

      def selected_theme
        res = %x{ defaults 2>/dev/null read com.macromates.textmate.webpreview SelectedTheme }.chomp
        $? == 0 ? res : 'bright'
      end
    end
  end
end