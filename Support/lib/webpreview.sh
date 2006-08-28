#!/bin/bash
# 
# Version 3 (2006-08-14) - by Soryu
# 
# This file contains support functions for generating HTML, to be used with TextMate's HTML output window. Please don't put functions in here without coordinating the core Bundle developers on IRC.
# 
# Further Notes:
# This is in flux right (see http://macromates.com/wiki/Suggestions/StylingHTMLOutput) now as I'm updating the Web Preview (HTML output). `html.sh` is the old version. To make for a smooth transition I threw out all the old (now partly incompatible and as I see it hardly used) functions and kind of started from scratch.

selected_theme() {
	RES=$(defaults 2>/dev/null read com.macromates.textmate.webpreview SelectedTheme)
	if [[ $? == 0 ]]
		then echo "$RES"
		else echo "bright"
	fi
}

# Generate HTML header up to and including the body tag. Also includes the default stylesheet and javascript.
# USAGE: html_header [page title] [page info, like Bundle Name, shown at the top right]
html_header() {
	TM_HTML_TITLE=${1}
	TM_HTML_THEME=$(selected_theme)
	case "$TM_HTML_THEME" in
		bright)  SEL_BRIGHT='selected="selected"';;
		dark)    SEL_DARK='selected="selected"';;
		default) SEL_DEFAULT='selected="selected"';;
	esac

	if [[ -n $2 ]]; then
		TM_HTML_LANG=$2
	fi
	# if [[ -f "$TM_FILEPATH" ]]; then
	#   TM_EXTRA_HEAD="<base href='tm-file://${TM_FILEPATH// /%20}'/>"
	# fi
	TM_CSS=`cat "${TM_SUPPORT_PATH}/css/webpreview.css" | sed "s|TM_SUPPORT_PATH|${TM_SUPPORT_PATH}|"`
	cat <<HTML
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<title>${TM_HTML_TITLE}</title>
	<style type="text/css" media="screen">
		${TM_CSS}
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
					<option ${SEL_BRIGHT}>bright</option>
					<option ${SEL_DARK}  >dark</option>
					<option ${SEL_DEFAULT} value="default">no colors</option>
				</select>
			</form>
		</div>
	</div>
	<div id="tm_webpreview_content" class="${TM_HTML_THEME}">
HTML
}

# Generate HTML footer.
# USAGE: html_footer
html_footer() {
	cat << HTML
	</div>
	<!-- <div id="tm_webpreview_footer">
		<p>TextMate Web Preview Window</p>
	</div>
	<script type="text/javascript">window.location.hash = "scroll_to_here";</script>
	 -->
</body>
</html>
HTML
}

