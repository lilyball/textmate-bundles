#!/bin/sh
if [[ -z $TM_SELECTED_TEXT ]]
   then 
# If the cursor is inside empty braces {}, then offer
# a list of all bibliography items. In that case, 
# the variable $phrase is not being set.
	prev_ch=${TM_CURRENT_LINE:$TM_COLUMN_NUMBER-2:1}
	if [[ $prev_ch != '{' ]]
		then phrase=$TM_CURRENT_WORD
	fi
   else phrase=$TM_SELECTED_TEXT
fi
# Find user's preference for bibfile.
if [[ -n $TM_LATEX_BIB ]]
# Case where user explicitly defined a particular file. Call the LatexCitekeys.rb script.
# This could hopefully accept more than one files, separated by space.
	then 
	cd "$TM_SUPPORT_PATH/bin"
	res2=`pwd`
	if [[ -z $phrase ]]
		then res=`./LatexCitekeys.rb $TM_LATEX_BIB`
		else res=`./LatexCitekeys.rb -p=$phrase $TM_LATEX_BIB`
	fi
elif [[ -n $TM_LATEX_MASTER ]]
# If there is a master file, look in it for \bibliography{bibfile} lines and use those bibfile's instead.
# LatexCitekeys.rb must be so designed as to deal differently with tex files and with bib files.
	then 
	cd "$TM_SUPPORT_PATH/bin"
	res2=`pwd`
	if [[ -z $phrase ]]
		then res=`./LatexCitekeys.rb $TM_LATEX_MASTER`
		else res=`./LatexCitekeys.rb -p=$phrase $TM_LATEX_MASTER`
	fi
else
# Look at BibDesk as a last resort
	if [[ -z $phrase ]]
	then 
# Case where $phrase is not defined

res=`osascript <<EOF
tell application "Bibdesk"
	set publist to get displayed publications of the first item of documents
	set candidates to {}
		repeat with anItem in publist
		set candidates to candidates & (cite key of anItem)
		end repeat
	end tell
	return candidates
EOF`
	else 
# Case where $phrase is defined
res=`osascript <<EOF
	tell application "Bibdesk" 
	set publist to search for "$phrase" without for completion
	set candidates to {}
		repeat with anItem in publist
		set candidates to candidates & (cite key of anItem)
		end repeat
	end tell
    return candidates
EOF`
	fi
fi
if [[ $? != 0 ]]; then exit; fi
sed <<<$res -e $'s/, /\\\n/g'