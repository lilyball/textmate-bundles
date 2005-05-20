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
	echo '<script type="text/javascript">'$@';</script>'
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
	javaScript 'document.url="'$1'"'
}

# Close the HTML window, after a delay (in milliseconds). Defaults to 1 second.
# USAGE: closeWindow <delay in ms>
closeWin() {
   local to=$1
   [ ${to:=1000} ]
	delayedJS $to 'window.close();'
}

