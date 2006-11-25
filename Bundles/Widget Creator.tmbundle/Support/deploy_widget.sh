#!/usr/bin/env bash
INST_VER=`paste -s ~/Library/Widgets/Textmate.wdgt/info.plist 2>&1 | grep -oE '<key>CFBundleVersion</key>.*?<string>.*?</string>' | grep -oE '<string>.*?</string>' | sed -e 's/<string>//' -e 's/<\/string>//'`
BUND_VER=`paste -s "$TM_BUNDLE_SUPPORT/Textmate.wdgt/info.plist" | grep -oE '<key>CFBundleVersion</key>.*?<string>.*?</string>' | grep -oE '<string>.*?</string>' | sed -e 's/<string>//' -e 's/<\/string>//'`
if [[ $INST_VER < $BUND_VER ]]; then
	rm -fR ~/"Library/Widgets/Textmate.wdgt"
	cp -R "$TM_BUNDLE_SUPPORT/Textmate.wdgt" ~/Library/Widgets/ > /dev/null
	echo "Textmate Widget Installed."
fi
open ~/"Library/Widgets/Textmate.wdgt" > /dev/null 2>&1
