#!/bin/sh
BPATH="$1"
TERM="$2"
AS="$3"
PORT="$4"

if [ -z "$PORT" -a -e "$TM_BUNDLE_SUPPORT/httpPort" ]; then
	PORT=$(cat "$TM_BUNDLE_SUPPORT/httpPort")
fi
HEAD="$BPATH"/lib/head.html
DATA="$BPATH"/lib/data.html

LIBPATHSFILE="$TM_BUNDLE_SUPPORT"/libpaths
# get LIB paths from R
if [ ! -e "$LIBPATHSFILE" ]; then
	echo "cat(.libPaths())" | R --slave > "$LIBPATHSFILE"
fi
LIBPATHS=$(cat "$LIBPATHSFILE")
IS_HELPSERVER=$(cat "$TM_BUNDLE_SUPPORT"/isHelpserver)

echo "<html><body style='margin-top:5mm'><table style='border-collapse:collapse'><tr><td style='padding-right:1cm;border-bottom:1px solid black'><b>Package</b></td><td style='border-bottom:1px solid black'><b>Topic</b></td></tr>" > "$HEAD"

if [ "$IS_HELPSERVER" == "TRUE" ]; then
	echo "write.table(help.search('^$TERM')[[4]][,c(1,3)],file='/tmp/r_help_result_dummy',sep='\t',quote=F,col.names=F,row.names=F)" | R --slave
	sleep 0.5
	TAB=$(head -n 1 /tmp/r_help_result_dummy | egrep '	' | wc -l)
	if [ "$TAB" -eq 0 ]; then
		cat /tmp/r_help_result_dummy | perl -e 'undef($/);$a=<>;$a=~s/\n(.)/\t$1/sg;print $a' > /tmp/r_help_result_dummy1
		exec</tmp/r_help_result_dummy1
	else
		exec</tmp/r_help_result_dummy
	fi
	if [ `cat /tmp/r_help_result_dummy | wc -l` -gt 300 ]; then
		echo "<br><i>too much matches...</i>"
	else
		while read i
		do
			lib=$(echo "$i" | cut -f2)
			fun=$(echo "$i" | cut -f1)
			echo "<tr><td>$lib</td><td>" >> "$HEAD"
			[[ ! -z "$PORT" ]] && echo "<a href='http://127.0.0.1:$PORT/library/$lib/html/$fun.html' target='data'>$fun</a></td></tr>" >> "$HEAD"
		done
		if [ "$TAB" -eq 0 ]; then
			curl -sS "http://127.0.0.1:$PORT/library/$lib/html/$fun.html" > "$DATA"
			echo "<base href='http://127.0.0.1:$PORT/library/$lib/html/$fun.html'>" >> "$DATA"
		fi
	fi
	rm /tmp/r_help_result_dummy 2>/dev/null
	rm /tmp/r_help_result_dummy1 2>/dev/null
else

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
fi

echo "</table></body></html>" >> "$HEAD"
