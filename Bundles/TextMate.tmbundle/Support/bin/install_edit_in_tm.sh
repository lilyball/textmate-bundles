SRC="$TM_APP_PATH/Contents/Resources/Edit in TextMate"

# check if we have the input manager in TextMate.app
[[ ! -d "$SRC" ]] && { echo "<h2>Error</h2><p>The input manager (<tt>$SRC</tt>) was not found in the TextMate application bundle.</p><p>You may need a newer version of TextMate.</p>"; exit; }

osascript 2>&1 <<-APPLESCRIPT
	do shell script "mkdir -p /Library/InputManagers &&
	cp -pR '$SRC' /Library/InputManagers &&
	chown -R root:admin /Library/InputManagers &&
	chmod -R go-w /Library/InputManagers/Edit\\\\ in\\\\ TextMate &&
	echo '<strong>Success!</strong> <tt>$SRC</tt> copied to <tt>/Library/InputManagers</tt>' &&
	[[ -d ~/Library/InputManagers ]] && mv ~/Library/InputManagers{,Disabled} && echo '<br>Your local directory (<tt>~/Library/InputManagers</tt>) has been renamed to <tt>~/Library/InputManagersDisabled</tt> to ensure there are no conflicts';
	true; # Stops osascript outputting an error if ~/Library/InputManagers does not exist" with administrator privileges
APPLESCRIPT
