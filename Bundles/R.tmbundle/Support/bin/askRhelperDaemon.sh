
#dispose all frozen ProgressDialogs first
{
while [ 1 ]
do
	res=$("$DIALOG" -x `"$DIALOG" -l 2>/dev/null| grep Rdaemon | cut -d " " -f 1` 2>/dev/null)
	[[ ${#res} -eq 0 ]] && break
done
} &


"$TM_BUNDLE_SUPPORT"/bin/startRhelperDaemon.sh &> /dev/null
echo "$1" > /tmp/textmate_Rhelper_in
sleep 0.01
SAFECNT=0
while [ 1 ]
do
	SAFECNT=$(($SAFECNT+1))
	if [ $SAFECNT -gt 5000 ]; then
		echo -en "No RESULT from R Helper server!"
		exit 206
	fi
	RES=$(tail -c 2 /tmp/textmate_Rhelper_console)
	[[ "$RES" == "> " ]] && break
	sleep 0.05
done
#sleep 0.1

