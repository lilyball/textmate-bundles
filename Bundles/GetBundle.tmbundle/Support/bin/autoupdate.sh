#!/bin/sh

SCRIPT_PATH=$(dirname "$0")
DIALOG_PATH=~/Library/Application\ Support/TextMate/Support/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog
BUNDLES_PATH=~/Library/Application\ Support/TextMate/Pristine\ Copy/Bundles
SUPPORT_PATH=~/Library/Application\ Support/TextMate/Support

# if the user already has svn in the path, prefer that
if type >/dev/null -p svn
  then SVN=svn
  else SVN="$SCRIPT_PATH/svn"
fi

cd "$BUNDLES_PATH"
LC_CTYPE=en_US.UTF-8 "$SVN" up *.tmbundle --no-auth-cache --non-interactive

if [[ $? == 0 ]]; then
    if ps -xcU $USER|grep -sq "TextMate"; then
        osascript -e 'tell app "TextMate" to reload bundles'
    fi
    "$DIALOG_PATH" bubble --title 'All Bundles Updated' --text 'All your TextMate Bundles have been updated!' --icon-file "$SCRIPT_PATH/../Textmate.icns"
else
    "$DIALOG_PATH" bubble --title 'There was a problem' --text "Wasn't able to update your TextMate Bundles" --icon-file "$SCRIPT_PATH/../Textmate.icns"
fi

LC_CTYPE=en_US.UTF-8 "$SVN" up "$SUPPORT_PATH"