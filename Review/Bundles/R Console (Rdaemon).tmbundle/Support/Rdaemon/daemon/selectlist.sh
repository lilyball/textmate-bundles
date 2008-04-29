cat <<- AS | osascript --
tell application "TextMate"
	activate
	set retList to choose from list {$1} with title "$2" default items {$3} $4
	set out to ""
	repeat with x in retList
		set out to out & "!@#@!" & x
	end repeat
end tell
AS