cat <<- AS | osascript --
tell application "TextMate"
	activate
	display dialog "$1" default answer "" with title "Rdaemon" buttons {"OK"} default button 1
	text returned of result
end tell
AS