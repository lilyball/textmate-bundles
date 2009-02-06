cat <<- AS | osascript -- 2>/dev/null
tell application "TextMate"
	activate
	display dialog "$1" $2 with title "Rdaemon" buttons {"OK"} default button 1
	text returned of result
end tell
AS