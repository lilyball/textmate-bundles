tell application "Transmit"
	(upload item (system attribute "TM_FILEPATH")) in current session of first document
end tell
