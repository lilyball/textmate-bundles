require 'erb'
require 'cgi'
require "#{ENV['TM_SUPPORT_PATH']}/lib/escape"

HTML_TEMPLATE = <<-HTML
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <meta http-equiv="Content-type" content="text/html; charset=utf-8">
  <title><%= window_title %></title>
  <% screen_themes.each do |style| %>
    <link rel="stylesheet" href="file://<%= e_url style %>/style.css" type="text/css" charset="utf-8" media="screen">
  <% end %>
  <% print_themes.each do |style| %>
    <link rel="stylesheet" href="file://<%= e_url style %>/print.css" type="text/css" charset="utf-8" media="print">
  <% end %>

  <script src="file://<%= e_url support_path %>/script/default.js"    type="text/javascript" charset="utf-8"></script>
  <script src="file://<%= e_url support_path %>/script/webpreview.js" type="text/javascript" charset="utf-8"></script>
  <script src="file://<%= e_url support_path %>/script/sortable.js"   type="text/javascript" charset="utf-8"></script>
  <script type="text/javascript" charset="utf-8">
    var image_path = "file://<%= e_url support_path %>/images/";
  </script>
  <%= html_head %>
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
            <% screen_themes.sort { |lhs, rhs| File.basename(lhs) <=> File.basename(rhs) }.each do |path| %>
              <% if path =~ %r{^.*/((.)([^/]*))$} %>
                <option value="<%= $1 %>" title="<%= path %>"><%= $2.upcase + $3 %></option>
              <% end %>
            <% end %>
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

def selected_theme
	res = %x{ defaults 2>/dev/null read com.macromates.textmate.webpreview SelectedTheme }.chomp
  $? == 0 ? res : 'bright'
end

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

def html_head(options = { })
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

  ERB.new(HTML_TEMPLATE).result binding
end

# compatibility function
def html_header(tm_html_title, tm_html_lang = "", tm_extra_head = "", tm_window_title = nil, tm_fix_href = nil)
  puts html_head(:title => tm_html_title, :sub_title => tm_html_lang, :html_head => tm_extra_head,
                 :window_title => tm_window_title, :fix_href => tm_fix_href)
end

def html_footer
	puts <<-HTML
	</div>
</body>
</html>
HTML
end
