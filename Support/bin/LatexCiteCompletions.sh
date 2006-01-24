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

sed <<<$res -e $'s/, /\\\n/g'
# 
# NEED TO ADD HANDLING OF PRESSING "Cancel"
# 
# osascript -e 'tell app "TextMate" to activate' &>/dev/null &
# 
# res=`perl -pe <<<$res 's/^(.*?)(\s*)%.*/$1/'` # strip comment
# res="${res//\\\\/\\\\}"                       # \ -> \\
# res="${res//$/\\$}"                           # $ -> \$
# 
# if [[ -z $TM_SELECTED_TEXT ]] && [[ -n $phrase ]]
#    then echo -n ${res:${#TM_CURRENT_WORD}}
#    else echo -n ${res}
# fi
