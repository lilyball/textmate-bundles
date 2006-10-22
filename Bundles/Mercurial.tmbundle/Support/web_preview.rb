require "cgi"
require "#{ENV['TM_SUPPORT_PATH']}/lib/escape.rb"




def html_header(tm_html_title, tm_html_lang = "", tm_extra_head = "")
  
	tm_html_theme = `defaults 2>/dev/null read com.macromates.textmate.webpreview SelectedTheme`.chomp || "bright"
	sel_bright = sel_dark = sel_default = ""
	case tm_html_theme
  when "bright"
    sel_bright = ' selected="selected"'
  when "dark"
    sel_dark = ' selected="selected"'
  when "default"
    sel_default = ' selected="selected"'
  end



	puts <<END_HTML_HEAD
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<title>#{tm_html_title}</title>
	<script src="file://#{ENV['TM_SUPPORT_PATH']}/script/default.js" type="text/javascript" language="javascript" charset="utf-8"></script>
	<script src="file://#{ENV['TM_SUPPORT_PATH']}/script/webpreview.js" type="text/javascript" language="javascript" charset="utf-8"></script>
	#{tm_extra_head}
</head>
<body id="tm_webpreview_body" class="#{tm_html_theme}">
	<div id="tm_webpreview_header">
		<p class="headline">#{tm_html_title}</p>
		<p class="type">#{tm_html_lang}</p>
		<img class="teaser" src="file://#{ENV['TM_SUPPORT_PATH']}/images/gear2.png" alt="teaser" />
		<div id="theme_switcher">
			<form action="#" onsubmit="return false;">
				Theme: 
				<select onchange="selectTheme(this.value);" id="theme_selector">
					<option#{sel_bright}>bright</option>
					<option#{sel_dark}>dark</option>
					<option#{sel_default} value="default">no colors</option>
				</select>
			</form>
		</div>
	</div>
	<div id="tm_webpreview_content" class="#{tm_html_theme}">
END_HTML_HEAD
end

def html_footer
	puts <<HTML
	</div>
	<!-- <div id="tm_webpreview_footer">
		<p>TextMate Web Preview Window</p>
	</div> -->
	<script type="text/javascript">window.location.hash = "scroll_to_here";</script>
</body>
</html>
HTML
end
