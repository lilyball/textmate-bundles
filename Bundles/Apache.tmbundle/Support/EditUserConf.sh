#!/bin/bash

SEARCH_DIR="/private/etc/httpd/users"
SEARCH_FILE_EXT="conf"

getDirContentsList()
{
	#Makes a list of all the files found in the specified directory, then assigns it to the variable $REPLY.
	local fileList=""	
	for file in "$1"/*
	do
		if [ -f "$file" ]
			then
			# Process files only..
			local ext=${file##*.}
			if [ "$ext" == "$SEARCH_FILE_EXT" ]
				then
				# Extract the name and add it to the list.
				local curFile=`basename "$file"`
				#echo $curFile
				fileList=`expr "$fileList\"$curFile\"$2"` 
			fi
		fi  
	done	
	#To return a variable you need to specify a global variable to read.
	REPLY=${fileList%$2*}
}
	
getDirContentsList $SEARCH_DIR ","
	
if [ "$REPLY" == "" ]
	then
	#There's nothing to pick from so exit
	exit 0;
fi
	
selectedFile=`exec osascript <<EOF | tr "\r" "\n"
	tell app "TextMate"
		set file_list to { $REPLY }
		set open_list to (choose from list file_list with prompt "Select the user.conf files you wish to open")
	end tell
EOF`
	
if [ "$selectedFile" != "false" ]
	then
	open -a TextMate "$SEARCH_DIR/$selectedFile"
fi
