require 'erb'

HTML_TEMPLATE = <<-HTML
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  <title><%= window_title %></title>
  <link rel="stylesheet" href="file://<%= support_path %>/themes/default/style.css"   type="text/css" charset="utf-8" media="screen">
  <link rel="stylesheet" href="file://<%= support_path %>/themes/bright/style.css"    type="text/css" charset="utf-8" media="screen">
  <link rel="stylesheet" href="file://<%= support_path %>/themes/dark/style.css"      type="text/css" charset="utf-8" media="screen">
  <link rel="stylesheet" href="file://<%= support_path %>/themes/shiny/style.css"     type="text/css" charset="utf-8" media="screen">
  <link rel="stylesheet" href="file://<%= support_path %>/themes/halloween/style.css" type="text/css" charset="utf-8" media="screen">
  <script src="file://<%= support_path %>/script/default.js"    type="text/javascript" charset="utf-8"></script>
  <script src="file://<%= support_path %>/script/webpreview.js" type="text/javascript" charset="utf-8"></script>
  <%= html_head %>
</head>
<body id="tm_webpreview_body" class="<%= html_theme %>">
  <div id="tm_webpreview_header">
    <img id="gradient" src="file://<%= support_path %>/themes/<%= html_theme %>/images/header.png">
    <p class="headline"><%= page_title %></p>
    <p class="type"><%= sub_title %></p>
    <img id="teaser" src="file://<%= support_path %>/themes/<%= html_theme %>/images/teaser.png" alt="teaser">
    <div id="theme_switcher">
      <form action="#" onsubmit="return false;">
        Theme: 
        <select onchange="selectTheme(this.value);" id="theme_selector">
          <option value="bright"   >bright    </option>
          <option value="dark"     >dark      </option>
          <option value="shiny"    >shiny     </option>
          <option value="halloween">halloween </option>
        </select>
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

def html_head(options = { })
  window_title = options[:window_title] || options[:title]    || 'Window Title'
  page_title   = options[:page_title]   || options[:title]    || 'Page Title'
  sub_title    = options[:sub_title]    || ENV['TM_FILENAME'] || 'untitled'

  html_theme   = selected_theme
  support_path = ENV['TM_SUPPORT_PATH']

  html_head    = options[:html_head]    || ''

  if options[:fix_href] && File.exist?(ENV['TM_FILEPATH'].to_s)
    require "cgi"
    html_head << "<base href='tm-file://#{CGI.escape(ENV['TM_FILEPATH'])}'>"
	end

  ERB.new(HTML_TEMPLATE).result binding
end

# compatibility function
def html_header(tm_html_title, tm_html_lang = "", tm_extra_head = "")
  puts html_head(:title => tm_html_title, :sub_title => tm_html_lang, :html_head => tm_extra_head)
end

def html_footer
	puts <<-HTML
	</div>
</body>
</html>
HTML
end
