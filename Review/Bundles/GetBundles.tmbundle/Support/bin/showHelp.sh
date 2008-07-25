
if [ `echo -n "$DIALOG" | tail -c 1` != "2" ]; then
	CHECK=$("$DIALOG" -l | egrep -c 'GetBundles — Help')
else
	CHECK=$("$DIALOG" window list | egrep -c 'GetBundles — Help')
fi

if [ ! $CHECK == 0 ]; then
	if [ `echo -n "$DIALOG" | tail -c 1` != "2" ]; then
		"$DIALOG" -l `"$DIALOG" -l | egrep 'GetBundles — Help' | awk '{print $1}'`
	else
		"$DIALOG" window close `"$DIALOG" window list | egrep 'GetBundles — Help' | awk '{print $1}'`
	fi
fi

TMPDIR="/tmp/TM_GetBundlesTEMP"
mkdir -p "$TMPDIR"

echo "<base href='file://${TM_BUNDLE_SUPPORT// /%20}/help.markdown'>" > "$TMPDIR/help.html"
echo "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>" >> "$TMPDIR/help.html"
cat "$TM_BUNDLE_SUPPORT/help.markdown" | Markdown.pl|SmartyPants.pl >> "$TMPDIR/help.html"

if [ `echo -n "$DIALOG" | tail -c 1` != "2" ]; then
	echo -en "{title='GetBundles — Help';path='$TMPDIR/help.html';}" | "$DIALOG" -a help 1> /dev/null
else
	echo -en "{title='GetBundles — Help';path='$TMPDIR/help.html';}" | "$DIALOG" window create help 1> /dev/null
fi

rm -rf "$TMPDIR"
