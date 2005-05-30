svn_diff () {

REV=$1
TITLE=$2

# until 1.1b12 we need to setup this manually
export PATH="$TM_SUPPORT_PATH/bin/CocoaDialog.app/Contents/MacOS:$PATH"

TMP_DIR=`mktemp -d /tmp/TextMate_svn_diff.XXXXXX` || exit 1
FILE="$TMP_DIR/$TM_FILENAME.diff"
PIPE="$TMP_DIR/pipe"

mkfifo "$PIPE"
CocoaDialog progressbar --indeterminate --title "$TITLE" --text "Contacting subversion server…" <"$PIPE" &>/dev/null &

# associate file descriptor 3 with that pipe and send a character through the pipe
exec 3<> "$PIPE"
echo -n . >&3

"${TM_SVN:=svn}" diff -r"$REV" "$TM_FILEPATH" &>"$FILE"

exec 3>&-

{ open -a TextMate "$FILE"; sleep 30; rm -rf "$TMP_DIR"; } </dev/null &>/dev/null &	
}
