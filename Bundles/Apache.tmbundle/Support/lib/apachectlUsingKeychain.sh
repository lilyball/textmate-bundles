#!/bin/bash

if [ "$1" == "" ] 
	then
	echo "Please specifiy a command to exec."
	exit 1;
fi

APACHE_CMD=$1	

PWD=`exec osascript <<EOF | tr "\r" "\n"
	
	(* 
	 To use the Keychain to store the admin password then open /Applications/Utilities/Keychain Access.app
	 Add a new keychain called "TextMate" 
	 Add a Key with the name "ApacheBundle" to the new Keychaing then store your password in it.
     
	 I'd recommend learning how keychains work then tailoring the process to your security needs.
	*)

	tell application "Keychain Scripting"
		set myKeyChain to keychain "TextMate.keychain"
		set theKeyList to every key of myKeyChain
		set thePassword to "THE_PASSWORD_WAS_NOT_FOUND_IN_THE_KEYCHAIN"
		repeat with x from 1 to (length of theKeyList)
			set theKey to item x of theKeyList
			if the name of theKey is "ApacheBundle" then
				set thePassword to password of theKey
				--exit repeat leaves us without a value returned to the shell script...
			end if
		end repeat
	end tell
	
EOF`

if [ "$PWD" == "THE_PASSWORD_WAS_NOT_FOUND_IN_THE_KEYCHAIN" ]
	then
	echo "Your password could not be found in the specified keychain"
	exit 1;
fi

#Pass the password to sudo, then gracefully restart apache.
echo "$PWD" | sudo -S apachectl $APACHE_CMD

if [ "$?" != "0" ] 
	then
	echo "Please check your KeyChain contains the right key and password"
fi

#Close sudo immediatley
sudo -k
exit 0;