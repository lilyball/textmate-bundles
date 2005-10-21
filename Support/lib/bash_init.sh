# This script simulates the behavior of a login shell
# This is done to give the user a full PATH

: ${TM_BASH_INIT:=$HOME/Library/Application Support/TextMate/bash_init.sh}

if [ ! -f "$TM_BASH_INIT" ]; then

	# First read the system-wide profile
	[ -f /etc/profile ] && . /etc/profile               &>/dev/null

	# Now find the first local profile, just like a normal login shell
	if   [ -f ~/.bash_profile ]; then . ~/.bash_profile &>/dev/null
	elif [ -f ~/.bash_login ];   then . ~/.bash_login   &>/dev/null
	elif [ -f ~/.profile ];      then . ~/.profile      &>/dev/null
	fi

fi

if [[ -d "$TM_SUPPORT_PATH/bin" ]]; then
	PATH="$PATH:$TM_SUPPORT_PATH/bin"
	if [[ -d "$TM_SUPPORT_PATH/bin/CocoaDialog.app/Contents/MacOS" ]]; then
		PATH="$TM_SUPPORT_PATH/bin/CocoaDialog.app/Contents/MacOS:$PATH"
	fi
fi

if [[ -d "$TM_BUNDLE_SUPPORT" && -d "$TM_BUNDLE_SUPPORT/bin" ]]; then
   PATH="$TM_BUNDLE_SUPPORT/bin:$PATH"
fi

export PATH

if [[ -f "$TM_BASH_INIT" ]]; then
	. "$TM_BASH_INIT"
fi

# force TM to refresh current file and project drawer
rescan_project () {
	osascript &>/dev/null \
	   -e 'tell app "SystemUIServer" to activate' \
	   -e 'tell app "TextMate" to activate' &
}

# use this as a filter (|pre) when you want 
# raw output to show as such in the HTML output
pre () {
	echo -n '<pre>'
	perl -pe 's/&/&amp;/g; s/</&lt;/g; s/>/&gt;/g'
	echo '</pre>'
}

# this will check for the presence of a command and
# prints an (HTML) error + exists if it's not there
require_cmd () {
	if ! type -p "$1" >/dev/null; then
		cat <<EOF
<h3 class="error">Couldn't find $1</h3>
${2:+<p>$2</p>}
<p>Locations searched:</p>
<p><pre>
${PATH//:/
}
</pre></p>
<p><em>Contact your system administrator if you do not know what this means.</em></p>
EOF
		exit;
	fi
}
