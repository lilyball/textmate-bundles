######### global variables #########

RDHOME="$HOME/Library/Application Support/Rdaemon"
if [ "$TM_RdaemonRAMDRIVE" == "1" ]; then
	RDRAMDISK="/tmp/TMRramdisk1"
else
	RDRAMDISK="$RDHOME"
fi


######### begin script #########

#get R's PID
export RPID=$(ps aw | grep '[0-9] /Lib.*TMRdaemon' | awk '{print $1;}' )


# dispose all frozen ProgressDialogs if there're some
{
while [ 1 ]
do
	res=$("$DIALOG" -x `"$DIALOG" -l 2>/dev/null| grep Rdaemon | cut -d " " -f 1` 2>/dev/null)
	[[ ${#res} -eq 0 ]] && break
done
} &

#check whether Rdaemon runs
test -z $RPID && echo -en "Rdaemon is not running." && exit 206

#check free space on ram drive
if [ "$TM_RdaemonRAMDRIVE" == "1" ]; then
	RES=$(df -H | grep TMRramdisk1 | awk '{ print $5 }' | perl -e 'print <>+0;')
	if [ $RES -gt 96 ]; then
		"$DIALOG" -e -p '{messageTitle="Rdaemon – RAM drive – Security Alert"; alertStyle="critical"; informativeText="Free disk space is less than 3%!\nFor safety reasons save your data image and restart the Rdaemon!";}' >/dev/null
		echo "RAM drive on '/tmp/TMRramdrive1':"
		RES=$(df -H | grep TMRramdisk1 | awk '{ print $5 }')
		echo -n " $RES are used of"
		RES=$(df -H | grep TMRramdisk1 | awk '{ print $2 }')
		echo -n " $RES."
		exit 206
	fi
fi

#get the task from TM and delete beginning >+: SPACE TAB
TASK=$(cat | sed -e 's/Browse\[.*\]//;s/^[>+:] \{0,1\}//;s/	/    /g;s/\\/\\\\/g;')

#check named input pipe for safety reasons
if [ ! -p "$RDHOME"/r_in ]; then
	echo -en "Rdaemon Error:\nThe pipe /tmp/r_in is not found!\n\nYou have to kill Rdaemon manually!"
	exit 206
fi

#check if user wants to quit
QTASK=$(echo -en "$TASK" | perl -pe 's/ *//g')
if [ "$QTASK" == "q()" -o "$QTASK" == "quit()" ]; then
	ANS=$("$DIALOG" -e -p "{messageTitle='Closing Rdaemon';informativeText='Save workspace image?';buttonTitles=('Save','Cancel','Don\'t Save');}")
	if [ "$ANS" == "1" ]; then
		echo -en "> "
		exit 204
	else
		if [ "$ANS" == "0" ]; then
			echo -e "@|q()\n@|y\n" > "$HOME/Library/Application Support/Rdaemon/r_in"
		fi
		if [ "$ANS" == "2" ]; then
			echo -e "@|q()\n@|n\n" > "$HOME/Library/Application Support/Rdaemon/r_in"
		fi
		if [ ! -e "$HOME/Library/Application Support/Rdaemon"/daemon/x11runs ]; then
			osascript <<-AS &>/dev/null
	 			ignoring application responses
	 			tell application "X11" to quit
	 			end ignoring
			AS
		fi
		exit 200
	fi
fi

#check if user wants to edit or fix
QTASK=$(echo -en "$TASK" | perl -pe 's/ *//g;s/\(.*?\)//g')
if [ "$QTASK" == "fix" -o "$QTASK" == "edit" ]; then
	echo -e "Please use “Execute Line/Selection (Background > r_res)”!\nKey: SHIFT + ⌅"
	exit 206
fi

#set history counter to 0
echo -n 0 > "$RDHOME"/history/Rhistcounter.txt

#get current position of r_out
POS=$(stat "$RDRAMDISK"/r_out | awk '{ print $8 }')
PROMPT=$(tail -n 1 "$RDRAMDISK"/r_out | sed 's/> $//')

#send task to Rdaemon and give Rdaemon the chance to read from the pipe

if [ -z "$TM_SELECTED_TEXT" ]; then
	echo -e "$TASK" > "$RDHOME"/r_in
else
	export token=$("$DIALOG" -a ProgressDialog -p "{title=Rdaemon;isIndeterminate=1;summary='Sending task to Rdaemon…';}")
	echo "$TASK" | sed 's/\\n/\\\\n/g' | while read LINE
	do
		echo "$LINE" > "$RDHOME"/r_in
		sleep 0.002
		"$DIALOG" -t $token -p "{details='${LINE//\'/’}';}" 2&>/dev/null
	done
	"$DIALOG" -x $token 2&>/dev/null
fi


#wait for R's response by expecting >, +, or : plus SPACE!
POSNEW=$(stat "$RDRAMDISK"/r_out | awk '{ print $8 }')
OFFBIAS=2
[[ "${TM_CURRENT_LINE:0:2}" == "+ " ]] && OFFBIAS=0

trap "
kill -s INT $RPID ; 
echo -en 'Warning: Task was canceled. Press ⌘Z to get the last command(s).\nThe progress window will be disposed before the next R command.\n> '" 2
PROGRESS_INIT=0 # to start the progress dialog after 100ms only
while [ 1 ]
do
	RES=$(tail -c 2 "$RDRAMDISK"/r_out)
	#expect these things from R
	if [ "$RES" == "> " ]; then
		"$DIALOG" -x $token 2&>/dev/null
		break
	fi
	[[ "$RES" == "+ " ]] && break
	[[ "$RES" == ": " ]] && break
	#monitoring of the CPU coverage as progress bar
	cpu=$(ps o pcpu -p "$RPID" | tail -n 1)
	[[ "${cpu:0:1}" == "%" ]] && break
	CP=$(echo -n "$cpu" | perl -e 'print 100-<>')
	sleep 0.1
	if [ $PROGRESS_INIT -eq 0 ]; then
		export token=$("$DIALOG" -a ProgressDialog -p "{title=Rdaemon;progressValue=50;summary='Rdaemon is busy…';}")
		PROGRESS_INIT=1
	fi
	"$DIALOG" -t $token -p "{details='`tail -n 1 "$RDRAMDISK"/r_out|perl -pe 's/\x27/\\\\\x27/g'`';progressValue=$CP;}" 2&>/dev/null
done
"$DIALOG" -x $token 2&>/dev/null

#read only the current response from Rdaemon
POSNEW=$(stat "$RDRAMDISK"/r_out | awk '{ print $8 }')
OFF=$(($POSNEW - $POS + $OFFBIAS))
#clean/escape the response
echo -en "$PROMPT"
tail -c $OFF "$RDRAMDISK"/r_out | head -n20000|perl -e '
	undef($/); $a=<>;
	$a=~s/\x0D{1,}/\x0D/sg;
	while($a=~m/(.*?)\x0D<.{50}(.) +\x08+(.*)/) { $a=~s/(.*?)\x0D<.{50}(.) +\x08+(.*)/$1$2$3/sg; }
	$a=~s/\\/\\\\/g;$a=~s/\`/\\\`/sg;$a=~s/\$/\\\$/sg;$a=~s/_\x08//sg;
	$a=~s/\x07//sg;
	$a=$a."…cut…\nWarning: more than 20000 lines (see the entire output in the “Console Logfile/r_out” ⌥⌘T)\n> " if ($a=~tr/\n/\n/ > 19999);
	$a .= "\n> " if ($a!~/> $/ && $a!~/\+ $/);
	print "$a";
'

