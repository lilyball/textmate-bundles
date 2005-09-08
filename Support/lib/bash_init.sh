# This script simulates the behavior of a login shell
# This is done to give the user a full PATH

# First read the system-wide profile
[ -f /etc/profile ] && . /etc/profile               &>/dev/null

# Now find the first local profile, just like a normal login shell
if   [ -f ~/.bash_profile ]; then . ~/.bash_profile &>/dev/null
elif [ -f ~/.bash_login ];   then . ~/.bash_login   &>/dev/null
elif [ -f ~/.profile ];      then . ~/.profile      &>/dev/null
fi

if [[ -d "$TM_SUPPORT_PATH/bin" ]]; then
	PATH="$PATH:$TM_SUPPORT_PATH/bin"
	if [[ -d "$TM_SUPPORT_PATH/bin/CocoaDialog.app/Contents/MacOS" ]]; then
		PATH="$TM_SUPPORT_PATH/bin/CocoaDialog.app/Contents/MacOS:$PATH"
	fi
fi

if [[ -d "$TM_BUNDLE_PATH/bin" ]]; then
   PATH="$TM_BUNDLE_PATH/bin:$PATH"
fi

if [[ -d "$TM_BUNDLE_SUPPORT/bin" ]]; then
   PATH="$TM_BUNDLE_SUPPORT/bin:$PATH"
fi

export PATH
