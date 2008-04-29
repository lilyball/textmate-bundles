cat <<- AS | osascript --
tell application "TextMate"
	activate
	choose from list {$1} with title "$2" with prompt "Please choose an item:"
end tell
AS