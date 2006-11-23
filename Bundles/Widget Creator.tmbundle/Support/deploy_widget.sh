#!/usr/bin/env bash
open /Library/Widgets/Textmate.wdgt > /dev/null 2>&1
if [[ $? != 0 ]]; then
	open ~/Library/Widgets/Textmate.wdgt > /dev/null 2>&1
	if [[ $? != 0 ]]; then
		echo "Textmate Widget Installed."
		cp -R "$TM_BUNDLE_SUPPORT/Textmate.wdgt" ~/Library/Widgets/ > /dev/null
		open ~/Library/Widgets/Textmate.wdgt > /dev/null 2>&1
	fi
fi
