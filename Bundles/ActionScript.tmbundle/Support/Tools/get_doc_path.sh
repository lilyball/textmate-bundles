#!/bin/bash

DOC_PATH="`defaults 2>/dev/null read com.macromates.textmate.actionscript FlashDocumentationPath`"

if ! [[ -d "$DOC_PATH" ]]; then
	DOC_PATH="`osascript 2>/dev/null <<"EOF"
		tell app "System Events"
			activate
			return POSIX path of (choose folder with prompt "Select Flash Help Documentation Folder")
		end tell
	EOF`"
	osascript -e 'tell app "TextMate" to activate' &>/dev/null &

	if ! [[ -d "$DOC_PATH" ]]; then exit; fi

	defaults write com.macromates.textmate.actionscript FlashDocumentationPath "$DOC_PATH"
fi

echo "$DOC_PATH"
