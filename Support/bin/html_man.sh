#!/bin/bash

# Call this script using full path (!) and section + word as arguments.
#
# It returns the name of an HTML page written to /tmp which is
# created with PolyglotMan. Links to other man pages are
# re-written to call this script again (via TextMate’s JavaScript 
# shell extension). This is why the full path is necessary.
#
# The page created gets deleted after 5 minutes. The high time-out
# is so that back and forward works (for 5 minutes).

RMAN_1='/Library/Application Support/Apple/Developer Tools/Plug-ins/DocViewerPlugIn.xcplugin/Contents/Resources/rman'
RMAN_2='/Developer/Library/Xcode/Plug-ins/DocViewerPlugIn.xcplugin/Contents/Resources/rman'

if [[ -x "$RMAN_1" ]]; then
	RMAN="$RMAN_1"
elif [[ -x "$RMAN_2" ]]; then
	RMAN="$RMAN_2"
else
	exit -1
fi

MAN=/usr/bin/man
DST=$(mktemp /tmp/tm_man_XXXXXX).html

HTML_MAN=$0
SECTION=$1
WORD=$2

cat >"$DST" <<-HTML
<script type="text/javascript">
	function man (sect, word) {
		var page = TextMate.system("'$HTML_MAN' " + sect + " " + word, null).outputString;
		window.location="tm-file://" + page;
	}
</script>
<meta name="Content-Type" content="text/html; charset=UTF-8" />
HTML

"$MAN" "$SECTION" "$WORD"|"$RMAN" -fHTML \
| perl -pe 's/(<TITLE>).*(<\/TITLE>)/$1Documentation for “'"$WORD"'”$2/i' \
| perl >>"$DST" -pe 's/HREF=["'\'']([^#][^"'\''.]*)\.(\d+)["'\'']/HREF="javascript:man($2, &quot;$1&quot;)"/i'

{ sleep 300; rm "$DST"; rm "${DST%.html}"; } &>/dev/null &

echo -n "$DST"
