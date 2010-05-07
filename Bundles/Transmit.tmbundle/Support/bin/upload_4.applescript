tell application "Transmit"
	tell current tab of front document
		tell remote browser
			upload item at path (system attribute "TM_FILEPATH")
		end tell
	end tell
end tell
