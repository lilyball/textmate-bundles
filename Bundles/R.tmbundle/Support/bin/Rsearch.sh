#!/bin/sh
BPATH="$1"
TERM="$2"
AS="$3"

HEAD="$BPATH"/lib/head.html
DATA="$BPATH"/lib/data.html

LIBPATHSFILE="$TM_BUNDLE_SUPPORT"/libpaths
# get LIB paths from R
if [ ! -e "$LIBPATHSFILE" ]; then
	echo "cat(.libPaths())" | R --slave > "$LIBPATHSFILE"
fi
LIBPATHS=$(cat "$LIBPATHSFILE")


echo "<html><body style='margin-top:5mm'><table style='border-collapse:collapse'><tr><td style='padding-right:1cm;border-bottom:1px solid black'><b>Package</b></td><td style='border-bottom:1px solid black'><b>Topic</b></td></tr>" > "$HEAD"

if [ "$AS" == "1" ]; then
	REFS=$(cat `find -f "${R_HOME:-/Library/Frameworks/R.framework/Resources}"/library/* -name INDEX` | egrep -m 260 -i "$TERM" | awk '{print $1;}' | sort | uniq | perl -pe 's/\n/|/g;s/\[/\\[/g;s/\-/\\-/g;s/\./\\./g;s/\(/\\(/g;s/\)/\\)/g')
	# 
	FILE=$(egrep -i "^($REFS$TERM)	" "$BPATH"/help.index | awk '{print $2;}' | perl -pe 's!/latex/!/html/!;s!tex$!html!' | sort | uniq)
	
	CNT=$(echo "$FILE" | wc -l)
	#echo "<tr><td>$CNT</td><td>$REFS$TERM</td></tr>" >> "$HEAD
	if [ "$CNT" -gt "250" ]; then
		echo "<tr><td colspan=2><font style='color:red;font-size:8pt'>More than $CNT files found.<br>Please narrow your search.</td></tr>" >> "$HEAD"
		#echo "<html><head><title>R Documentation</title></head><body></body></html>" > "$DATA"
	else
		for i in `echo $FILE`
			do
			echo "<tr><td>" >> "$HEAD"
			echo "$i" | sed 's/\(.*\)library\/\(.*\)\/html\/\(.*\)\.html/\2/' >> "$HEAD"
			echo "</td><td><a href='$i' target='data'>" >> "$HEAD"
			echo "$i" | sed 's/\(.*\)library\/\(.*\)\/html\/\(.*\)\.html/\3/' >> "$HEAD"
			echo "</a></td></tr>" >> "$HEAD"
		done
	fi
else
	for lpath in $LIBPATHS
	do
  	FILE=$(egrep -m 260 -l -i -r "$TERM" "$lpath"/*/help/ | perl -pe  's!/help/(.*)!/html/$1.html!;s/AnIndex\.html/00Index.html/')

  	CNT=$(echo "$FILE" | wc -l)
  	if [ "$CNT" -gt "250" ]; then
  		echo "<tr><td colspan=2><font style='color:red;font-size:8pt'>More than $CNT files found.<br>Please narrow your search.</td></tr>" >> "$HEAD"
  		#echo "<html><head><title>R Documentation</title></head><body></body></html>" > "$DATA"
  	else
  		for i in `echo $FILE`
  		do
  			echo "<tr><td>" >> "$HEAD"
  			echo "$i" | sed 's/\(.*\)library\/\(.*\)\/html\/\(.*\)\.html/\2/' >> "$HEAD"
  			echo "</td><td><a href='$i' target='data'>" >> "$HEAD"
  			echo "$i" | sed 's/\(.*\)library\/\(.*\)\/html\/\(.*\)\.html/\3/' >> "$HEAD"
  			echo "</a></td></tr>" >> "$HEAD"
  		done
  	fi
	done
fi
if [ "$CNT" -eq "1" -a "${#FILE}" -gt "0" ]; then
	cat "$FILE" > "$DATA"
	echo "<base href='tm-file://${FILE// /%20}'>" >> "$DATA"
else
	[[ "$CNT" -eq "0" ]] && echo "<tr><td colspan=2><i><small>nothing found</small></i></td></tr>" >> "$HEAD"
	echo "<html><head><title>R Documentation</title></head><body></body></html>" > "$DATA"
fi

echo "</table></body></html>" >> "$HEAD"
