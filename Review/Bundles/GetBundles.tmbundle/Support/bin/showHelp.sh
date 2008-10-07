
CHECK=$("$DIALOG" -l | egrep -c 'GetBundles — Help')

if [ ! $CHECK == 0 ]; then
	"$DIALOG" -x `"$DIALOG" -l | egrep 'GetBundles — Help' | awk '{print $1}'`
fi

TMPDIR="/tmp/TM_GetBundlesTEMP"
mkdir -p "$TMPDIR"

echo "<base href='file://${TM_BUNDLE_SUPPORT// /%20}/help.markdown'>" > "$TMPDIR/help.html"
echo "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>" >> "$TMPDIR/help.html"
cat "$TM_BUNDLE_SUPPORT/help.html" >> "$TMPDIR/help.html"

echo -en "{title='GetBundles — Help';path='$TMPDIR/help.html';}" | "$DIALOG" -a help 1> /dev/null

rm -rf "$TMPDIR"
