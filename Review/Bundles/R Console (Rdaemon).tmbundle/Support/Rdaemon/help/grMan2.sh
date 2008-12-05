if [ "$TM_RdaemonRAMDRIVE" == "1" ]; then
	RDRAMDISK="/tmp/TMRramdisk1"
else
	RDRAMDISK="$HOME"/Rdaemon
fi

RDHOME="$HOME/Rdaemon"
[[ ! -d "$HOME"/Rdaemon/plots/tmp ]] && mkdir "$HOME"/Rdaemon/plots/tmp > /dev/null
rm -f "$HOME"/Rdaemon/plots/tmp/*.* > /dev/null

POS=$(stat "$RDRAMDISK"/r_out | awk '{ print $8 }')
echo "@|sink('$RDRAMDISK/r_tmp');.chooseActiveScreenDevice();sink(file=NULL)" > ~/Rdaemon/r_in
POSNEW=$(stat "$RDRAMDISK"/r_out | awk '{ print $8 }')
OFF=$(($POSNEW - $POS + 2))

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
	sleep 0.1
	if [ $PROGRESS_INIT -eq 0 ]; then
		export token=$("$DIALOG" -a ProgressDialog -p "{title=Rdaemon;progressValue=50;summary='Rdaemon is busy…';}")
		PROGRESS_INIT=1
	fi
	"$DIALOG" -t $token -p "{details='`tail -n 1 "$RDRAMDISK"/r_out|perl -pe 's/\x27/\\\\\x27/g'`';progressValue=$CP;}" 2&>/dev/null
done
"$DIALOG" -x $token 2&>/dev/null


OUT=$(cat "$RDRAMDISK/r_tmp")
if [ "${#OUT}" -gt "30" ]; then
	echo "$OUT" | sed 's/^\[1\] "//;s/"$//'
else
	echo "<small>No Graphic Devices found or press 'Refresh'.</small>"
fi
