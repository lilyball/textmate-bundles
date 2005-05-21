#!/bin/bash
#
# This file contains support functions for generating HTML, to be used with TextMate's
# HTML output window.  Please don't put functions in here without coordinating with me
# or Allan.
#
# Only some basic stuff is included, as well as stuff designed to work with the default
# stylesheet and javascript.
#
# By Sune Foldager. Updated 2005-05-20.
#

# Initialization.
_toggleID=1

# Generate JavaScript code (i.e. wrap arguments in script tags). A final ; is added.
# USAGE: javaScript <code...>
javaScript() {
	echo "<script type=\"text/javascript\">${@};</script>"
}

# Import JavaScript code.
# USAGE: importJS <local filename>
importJS() {
   echo '<script type="text/javascript">'
   cat "$1"
   echo '</script>'
}

# Execute JavaScript code after a delay (in milliseconds).
# USAGE: delayedExec <delay in ms> <code...>
delayedJS() {
   local to=$1
   shift
	javaScript "setTimeout('$@', $to)"
}

# Redirect to a given URL.
# USAGE: redirect <url>
redirect() {
	javaScript 'window.location="'$1'"'
}

# Generate CSS (i.e. wrap arguments in style tags).
# USAGE: css <styles...>
css() {
   echo "<style type=\"text/css\">$@</style>"
}

# Import a CSS script.
# USAGE: importCSS <local filename>
importCSS() {
   echo '<style type="text/css">'
   cat "$1"
   echo '</style>'
}

# Generate HTML header up to and including the body tag. Also includes the default
# stylesheet and javascript.
# USAGE: htmlHeader [optional <head> stuff...]
htmlHeader() {
   echo '<?xml version="1.0" encoding="utf-8"?>'
   echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"'
   echo '	"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">'
   echo '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"><head>'
   echo '<meta http-equiv="content-type" content="text/html; charset=utf-8" />'
#  echo "<title>$1</title>"
   importCSS "${TM_SUPPORT_PATH}/css/default.css"
   importJS "${TM_SUPPORT_PATH}/script/default.js"
   [ -n "$1" ] && echo "$@"
   echo '</head><body>'
}

# Generate HTML footer.
# USAGE: htmlFooter
htmlFooter() {
   echo '</body></html>'
}

# Close the HTML window, after a delay (in milliseconds). Defaults to 1 second.
# USAGE: closeWindow <delay in ms>
closeWindow() {
   local to=$1
   [ ${to:=1000} ]
	delayedJS $to 'window.close();'
}

# Typesets the arguments in <em> tags.
# USAGE: emph <text...>
emph() {
   echo "<em>$@</em>"
}

# Typesets the arguments in <strong> tags.
# USAGE: strong <text...>
strong() {
   echo "<strong>$@</strong>"
}

# Creates a link (HTML anchor tag)
# USAGE: link <url> <text...>
link() {
   local url=$1
   shift
   echo "<a href=\"${url}\">$@</a>"
}

# Generate a tag, with optional class, id and other attributes.
# USAGE: tagB <name> [class] [id] [extra]
#        tagE <name>
#        tag <name> <contents> [class] [id] [extra]
tagB() {
   echo -n "<$1"
   [ -n "$2" ] && echo -n " class=\"$2\""
   [ -n "$3" ] && echo -n " id=\"$3\""
   [ -n "$4" ] && echo -n " $4"
   echo '>'
}
tagE() {
   echo "</$1>"
}
tag() {
   tagB $1 $3 $4 $5
   echo "$2"
   tagE $1
}

# Creates a toggle tag, and bumps the global ID. Used by the functions below.
# Mainly an internal function; USAGE: makeToggle
makeToggle() {
   tagB div toggle
   tagB span '' "toggle${_toggleID}_s" 'style="display: inline;"'
   link "javascript:showElement('toggle${_toggleID}');" 'Show details'
   tagE span
   tagB span '' "toggle${_toggleID}_h" 'style="display: none;"'
   link "javascript:hideElement('toggle${_toggleID}');" 'Hide details'
   tagE span
   tagE div
   _toggleID=$((_toggleID + 1))
}

# Creates a toggle box, which consists of the following:
#  - The main box.
#  - A show/hide button.
#  - A part that is always displayed (called 'brief').
#  - A part initially hidden, but toggleable with the button (called 'details').
# The box will be left open at the 'details' part. Use toggleBoxE to close it.
# USAGE: toggleBox <class name> <brief matter>
toggleBox() {
   local id=$_toggleID
   tagB div "$1"
   makeToggle
   tagB div brief
   echo "$2"
   tagE div
   tagB div details "toggle${id}_b" 'style="display: none;"'
}
toggleBoxE() {
   tagE div
   tagE div
}

# Quick way to create sideBars and boxes (see the default stylesheet).
# Leaves the box open at the 'details' part. Use toggleBoxE to close it.
# USAGE: sideBar/box <brief matter>
sideBar() {
   toggleBox sideBar "$1"
}

box() {
   toggleBox box "$1"
}

