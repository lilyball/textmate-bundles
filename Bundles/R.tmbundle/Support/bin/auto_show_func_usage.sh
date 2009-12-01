
export WORD=$(ruby -- <<-SCR1
print ENV['TM_CURRENT_LINE'][0...ENV['TM_LINE_INDEX'].to_i].gsub!(/ *$/, "").match(/[\w.]*$/).to_s
SCR1
)

#check whether WORD is defined otherwise quit
[[ -z "$WORD" ]] && exit 200

TEXT=$(cat)

RhelperAnswer="/tmp/textmate_Rhelper_out"

# Rdaemon
RPID=$(ps aw | grep '[0-9] /Lib.*TMRdaemon' | awk '{print $1;}' )
RD=$(echo -n "$TM_SCOPE" | grep -c -F 'source.rd.console')
if [ ! -z "$RPID" -a "$RD" -gt 0 ]; then
	RDHOME="$HOME/Library/Application Support/Rdaemon"
	if [ "$TM_RdaemonRAMDRIVE" == "1" ]; then
		RDRAMDISK="/tmp/TMRramdisk1"
	else
		RDRAMDISK="$RDHOME"
	fi
	[[ -e "$RDRAMDISK"/r_tmp ]] && rm "$RDRAMDISK"/r_tmp

	# execute "args()" in Rdaemon
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
	# "args()" did find something
	if [ ! -z "$RES" ]; then
		echo -en "$WORD${RES:9}" | perl -e 'undef($/);$a=<>;$a=~s/"\t"/"\\t"/sg;$a=~s/"\n"/"\\n"/sg;print $a'
		"$TM_BUNDLE_SUPPORT"/bin/askRhelperDaemon.sh "@getPackageFor('$WORD')"
		LIB=$(cat "$RhelperAnswer")
		if [ -z "$LIB" ]; then
			LIB="local"
		fi
		echo -en "\n•• library: $LIB"
		exit 206
	# "args()" didn't find anything ergo library isn't yet loaded
	else
		"$TM_BUNDLE_SUPPORT"/bin/askRhelperDaemon.sh "@getHelpURL('$WORD')"
		FILE=$(cat "$RhelperAnswer")
		if [ ! -z "$FILE" -a "$FILE" != "NA" ]; then
			if [ "${FILE:0:1}" = "/" ]; then
				RES=$(cat "$FILE")
			else
				RES=$(curl -gsS "$FILE")
			fi
			echo -en "$RES" | "$TM_BUNDLE_SUPPORT/bin/parseHTMLForUsage.sh" "$WORD" 0
		else
			exit 200
		fi
		"$TM_BUNDLE_SUPPORT"/bin/askRhelperDaemon.sh "@getPackageFor('$WORD')"
		LIB=$(cat "$RhelperAnswer")
		TASK="@|sink('$RDRAMDISK/r_tmp')"
		echo "$TASK" > "$RDHOME"/r_in
		TASK="@|cat(sum((.packages()) %in% \"$LIB\"),sep='')"
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
		RES=$(cat "$RDRAMDISK"/r_tmp)
		if [ ! -z "$RES" -a "$RES" == "1" ]; then
			echo -en "\n•• library: $LIB"
		else
			echo -en "\n• Library “${LIB}” not yet loaded! [press CTRL+SHIFT+L]"
		fi
		exit 206
	fi
fi

# R script
"$TM_BUNDLE_SUPPORT"/bin/askRhelperDaemon.sh "@getHelpURL('$WORD')"
FILE=$(cat "$RhelperAnswer")
if [ ! -z "$FILE" -a "$FILE" != "NA" ]; then
	if [ "${FILE:0:1}" = "/" ]; then
		RES=$(cat "$FILE")
	else
		RES=$(curl -gsS "$FILE")
	fi
	"$TM_BUNDLE_SUPPORT"/bin/askRhelperDaemon.sh "@getPackageFor('$WORD')"
	LIB=$(cat "$RhelperAnswer")
	RES=$(echo -en "$RES" | "$TM_BUNDLE_SUPPORT/bin/parseHTMLForUsage.sh" "$WORD" 0)
	if [ ! -z "$RES" -a "${RES:0:1}" == "${WORD:0:1}" ]; then
		echo -n "$RES"
		echo -en "\n•• library: $LIB"
		exit 206
	fi
else
	# Parse R script for functions
	OUT=$(echo -en "$TEXT" | "$TM_BUNDLE_SUPPORT/bin/parseDocForFunctions.sh" "$WORD")

	LIB="local"

	[[ -z "$OUT" ]] && exit 200

	OUT=$WORD$OUT
	echo -n "$OUT"
	echo -en "\n•• library: $LIB"
	exit 206
fi
