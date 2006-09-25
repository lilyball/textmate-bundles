#!/bin/sh
# It doesn't seem that sourcing bash_init was necessary, so I commented it out.
# . "$TM_SUPPORT_PATH/lib/bash_init.sh"
cd "${TM_DIRECTORY:-$HOME}"
if [[ -z $TM_SELECTED_TEXT ]]
   then 
# If the cursor is inside empty braces {}, then offer
# a list of all bibliography items. In that case, 
# the variable $phrase is not being set.
	prev_ch=${TM_CURRENT_LINE:$TM_LINE_INDEX-1:1}
	if [[ $prev_ch != '{' ]]
		then phrase="$TM_CURRENT_WORD"
	fi
   else phrase="$TM_SELECTED_TEXT"
fi
# Searches for bibliography items in bib files and also things linked to from all included files.
if [[ -z $phrase ]]
	then res=`"$TM_SUPPORT_PATH/bin"/LatexCitekeys.rb "$TM_LATEX_BIB" "$TM_LATEX_MASTER" "$TM_FILEPATH"`
	else res=`"$TM_SUPPORT_PATH/bin"/LatexCitekeys.rb -p=$phrase "$TM_LATEX_BIB" "$TM_LATEX_MASTER" "$TM_FILEPATH"`
fi
if [[ $? != 0 ]]
 then exit
fi
if [[ -n $res ]]
then
	sed <<<"$res" -e $'s/, /\\\n/g'
else
	exit
fi