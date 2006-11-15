#!/bin/sh
#
osascript << END
tell application "iTerm"
	-- Are we running any actual terminals?
	set sess_count to (count (every session of every terminal))
	if sess_count = 0 then
		make new terminal
	end if
	tell the first terminal
		if not (exists session named "$SHELL_NAME") then
			launch session "Default"
			tell the current session
				set name to "$SHELL_NAME"
				write text "$SHELL_INTERPRETER"
			end tell
		end if
		select session named "$SHELL_NAME"
    	activate
	end tell
end tell
END
