#!/bin/bash
#
# This file contains support functions for generating HTML, to be used with TextMate's
# HTML output window.  Please don't put functions in here without coordinating with me
# or Allan.
#
# By Sune Foldager. Updated 2005-05-20.
#

# Generate JavaScript code (i.e. wrap arguments in script tags). A final ; is added.
# USAGE: javaScript <code...>
javaScript() {
	echo "<script type=\"text/javascript\">${@};</script>"
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
# USAGE: importCSS <filename>
importCSS() {
   echo '<style type="text/css">'
   cat $1
   echo '</style>'
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

