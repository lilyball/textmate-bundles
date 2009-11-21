######### global variables #########

RDHOME="$HOME/Library/Application Support/Rdaemon"
if [ "$TM_RdaemonRAMDRIVE" == "1" ]; then
	RDRAMDISK="/tmp/TMRramdisk1"
else
	RDRAMDISK="$RDHOME"
fi

######### begin script #########

IN=$1

#get R's PID
export RPID=$(ps aw | grep '[0-9] /Lib.*TMRdaemon' | awk '{print $1;}' )

#check whether Rdaemon runs
test -z $RPID && echo -en "Rdaemon is not running." && exit 206

#get the task from TM and delete beginning >+: SPACE TAB
TASK=$(echo -en "$IN" | sed -e 's/^[>+:]//;s/^[	 ]*//')

#check named input pipe for safety reasons
if [ ! -p "$RDHOME"/r_in ]; then
	echo -en "Rdaemon Error:\nThe pipe "$RDHOME"/r_in is not found!\n\nYou have to kill Rdaemon manually!"
	exit 206
fi

#set history counter to 0
echo -n 0 > "$RDHOME/history"/Rhistcounter.txt

#get current position of r_out
POS=$(stat "$RDRAMDISK"/r_out | awk '{ print $8 }')

#send task to Rdaemon
echo -e "$TASK" > "$RDHOME"/r_in

#wait for R's response by expecting >, +, or : plus SPACE!
POSNEW=$(stat "$RDRAMDISK"/r_out | awk '{ print $8 }')
OFF=$(($POSNEW - $POS + 2))

trap "
kill -s INT $RPID ; 
echo -en 'Warning: Task was canceled. Press ⌘Z to get the last command(s).\nThe progress window will be disposed before the next R command.\n> '" 2
PROGRESS_INIT=0 # to start the progress dialog after 100ms only
while [ 1 ]
do
	RES=$(tail -c 2 "$RDRAMDISK"/r_out)
	#expect these things from R
	[[ "$RES" == "> " ]] && break
	[[ "$RES" == "+ " ]] && break
	[[ "$RES" == ": " ]] && break
	#monitoring of the CPU coverage as progress bar
	cpu=$(ps o pcpu -p "$RPID" | tail -n 1)
	[[ "${cpu:0:1}" == "%" ]] && break
	CP=$(echo -n "$cpu" | perl -e 'print 100-<>')
	echo "$CP `tail -n 1 "$RDRAMDISK"/r_out`"
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
OFF=$(($POSNEW - $POS + 2))
RES=$(tail -c $OFF "$RDRAMDISK"/r_out)

#clean/escape the response
tail -c $OFF "$RDRAMDISK"/r_out | perl -e '
	undef($/); $a=<>;
	$a=~s/\x0D{1,}/\x0D/sg;
	while($a=~m/(.*?)\x0D<.{50}(.) +\x08+(.*)/) { $a=~s/(.*?)\x0D<.{50}(.) +\x08+(.*)/$1$2$3/sg; }
	#$a=~s/\`/\\\`/sg;$a=~s/\$/\\\$/sg;
	$a=~s/_\x08//sg;
	$a .= "\n> " if ($a!~/> $/ && $a!~/\+ $/);
	print "$a";
'
