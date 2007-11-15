SRC="$(ruby -r"$TM_SUPPORT_PATH/lib/textmate.rb" -e 'print TextMate.app_path')/Contents/Resources/Edit in TextMate"

# check if we have the input manager in TextMate.app
[[ ! -d "$SRC" ]] && { echo "<h2>Error</h2><p>The input manager (<tt>$SRC</tt>) was not found in the TextMate application bundle.<p>You may need a newer version of TextMate."; exit; }

if [[ `defaults read /System/Library/CoreServices/SystemVersion ProductVersion` = 10.5* ]]; then
	osascript 2>&1 <<-APPLESCRIPT
		do shell script "mkdir -p /Library/InputManagers &&
		cp -pR '$SRC' /Library/InputManagers &&
		chown -R root:admin /Library/InputManagers &&
		chmod -R go-w /Library/InputManagers/Edit\\\\ in\\\\ TextMate &&
		echo '<strong>Success!</strong> <tt>$SRC</tt> copied to <tt>/Library/InputManagers</tt>' &&
		[[ -d ~/Library/InputManagers ]] && mv ~/Library/InputManagers{,Disabled} && echo '<br>Your local directory (<tt>~/Library/InputManagers</tt>) has been renamed to <tt>~/Library/InputManagersDisabled</tt> to ensure there are no conflicts';
		true; # Stops osascript outputting an error if ~/Library/InputManagers does not exist" with administrator privileges
	APPLESCRIPT
else
	{
		mkdir -p ~/Library/InputManagers &&
		ln -s "$SRC" ~/Library/InputManagers &&
		echo "<strong>Success!</strong> Link to <tt>$SRC</tt> created in <tt>~/Library/InputManagers</tt>.";
	} 2>&1;
fi
