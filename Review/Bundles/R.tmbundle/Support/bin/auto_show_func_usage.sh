TEXT=$(cat)

export WORD=$(ruby -- <<-SCR1
print ENV['TM_CURRENT_LINE'][0...ENV['TM_LINE_INDEX'].to_i].gsub!(/ *$/, "").match(/[\w.]*$/).to_s
SCR1
)

#check whether WORD is defined otherwise quit
[[ -z "$WORD" ]] && exit 200

RD=$(echo -n "$TM_SCOPE" | grep -c -F 'source.rd.console')
[[ "${TM_CURRENT_LINE:0:1}" == "+" ]] && RD="0"
if [ $RD -gt 0 ]; then
	RDHOME="$HOME/Rdaemon"
	if [ "$TM_RdaemonRAMDRIVE" == "1" ]; then
		RDRAMDISK="/tmp/TMRramdisk1"
	else
		RDRAMDISK="$HOME"/Rdaemon
	fi
	#get R's PID
	RPID=$(ps aw | grep '[0-9] /Lib.*TMRdaemon' | awk '{print $1;}' )

	#check whether Rdaemon runs
	if [ -z $RPID ]; then
		RDTEXT="•• Rdaemon is not running."
	else
		[[ -e "$RDRAMDISK"/r_tmp ]] && rm "$RDRAMDISK"/r_tmp

		TASK="@|sink('$RDRAMDISK/r_tmp')"
		echo "$TASK" > "$RDHOME"/r_in
		TASK="@|args($WORD)"
		echo "$TASK" > "$RDHOME"/r_in
		TASK="@|sink(file=NULL)"
		echo "$TASK" > "$RDHOME"/r_in

		while [ 1 ]
		do
			RES=$(tail -c 2 "$RDRAMDISK"/r_out)
			[[ "$RES" == "> " ]] && break
			[[ "$RES" == ": " ]] && break
			[[ "$RES" == "+ " ]] && break
			sleep 0.02
		done
		RES=$(cat "$RDRAMDISK"/r_tmp | sed 's/NULL$//;')

		[[ "$RES" == "NULL" ]] && RES=""

		if [ ! -z "$RES" ]; then
			echo -en "$WORD${RES:9}" | perl -pe 's/\n/ /g;s/ {2,}/ /g' | fmt | perl -e 'undef($/);$a=<>;$a=~s/\n/\n\t/g;$a=~s/\n\t$//;print $a'
			exit 206
		fi
	fi
fi


. "$TM_BUNDLE_SUPPORT"/bin/rebuild_help_index.sh

#get the reference for WORD
FILE=$(grep "^${WORD//./\\.}	" "$TM_BUNDLE_SUPPORT"/help.index | awk '{print $2;}')
#get the library in which WORD is defined
LIB=$(echo -en \"$FILE\" | perl -pe 's!.*/library/(.*?)/latex.*!$1!')

#check whether something is found within the installed packages or within the curretn doc otherwise quit
if [ -z "$FILE" ]; then #look for local defined functions
	OUT=$(echo -en "$TEXT" | egrep -A 10 "${WORD//./\\.} *<\- *function *\(" | perl -e '
		undef($/);$a=<>;$a=~s/.*?<\- *function *(\(.*?\)) *[\t\n\{\w].*/$1/s;
		$a=~s/\t//sg;$a=~s/\n/ /g;print "$a" if($a=~m/^\(/ && $a=~m/\)$/s)
	' | fmt | perl -e 'undef($/);$a=<>;$a=~s/\n/\n\t/g;$a=~s/\n\t$//;print $a')

	LIB="local"
	[[ -z "$OUT" ]] && exit 200

	OUT=$WORD$OUT
else #get the usage from the latex file
	OUT=$(cat "$FILE" | perl -e '
		undef($/);$w=$ENV{"WORD"};$a=<>;
		$a=~m/\\begin\{Usage\}\n\\begin\{verbatim\}\n?.*?($w *\(.*?\))\n.*?\\end\{verbatim\}/s;
		if(length($1)) {
			print $1;
		} else {
			$a=~m/\\begin\{Usage\}\n\\begin\{verbatim\}\n?.*?($w *\(.*?\)).*?\\end\{verbatim\}/s;
			print "$1";
		}
')
fi

#if no usage is found show the HTML page for WORD otherwise output the command usage
if [ -z "$OUT" ]; then
	exit 200
else
	echo -n "$OUT"
fi

#output the library in which WORD is defined
if [ $RD -gt 0 -a "$LIB" != "base" ]; then
	echo -en "\n• Library “${LIB}” not yet loaded! [press CTRL+SHIFT+L]"
else
	echo -en "\n•• library: $LIB ••"
fi
echo -e "\n$RDTEXT"