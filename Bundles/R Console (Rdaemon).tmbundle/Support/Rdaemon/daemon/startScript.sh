###########
#
# Rdaemon start script
#
#   Hans-Jörg Bibiko - bibiko@eva.mpg.de
#
###########

######### global variables #########

RDHOME="$HOME/Library/Application Support/Rdaemon"

if [ "$TM_RdaemonRAMDRIVE" == "1" ]; then
	RDRAMDISK="/tmp/TMRramdisk1"
else
	RDRAMDISK="$HOME/Library/Application Support/Rdaemon"
fi

RAMSIZE=${TM_RdaemonRAMSIZE:-50}

######### functions #########

runs() {
	RUBYRUN=$(ps xw | grep '[0-9] ruby.*Rdaemon')
	RRUN=$(ps aw | grep '[0-9] /.*TMRdaemon')
	if [ ${#RRUN} == 0 -a ${#RUBYRUN} == 0 ]; then
		return 0
	else
		return 1
	fi
}

######### script begin #########

# dispose all Rdaemon dialogs
{
while [ 1 ]
do
	res=$("$DIALOG" -x `"$DIALOG" -l 2>/dev/null| grep Rdaemon | cut -d " " -f 1` 2>/dev/null)
	[[ ${#res} -eq 0 ]] && break
done
} &

#check whether R is already running
runs
if [ $? == 1 ]; then
	echo -en "Rdaemon is already running!"
	exit 206
fi

#only for Mac OSX 10.4 X11
OS=$(uname -r | perl -pe 's/(\d+)\..*/$1/')
[[ $OS -eq 8 ]] && export DISPLAY=:0.0

#test for ram drive
if [ "$TM_RdaemonRAMDRIVE" == "1" ]; then
	RES=""
	if [ -d "$RDRAMDISK" ]; then
		echo -n "a" > "$RDRAMDISK"/test.txt
		RES=$(cat "$RDRAMDISK"/test.txt)
	fi
	if [ "$RES" != "a" ]; then #create ram drive
		ramDiskSize=`echo "${RAMSIZE}*2048" | bc`
		ramDiskPath=`hdid -nomount ram://${ramDiskSize}`
		#save /dev/disk? for detaching
		echo -n "$ramDiskPath" > "$RDHOME"/daemon/ramDiskPath
		newfs_hfs -v 'TMRdaemon' $ramDiskPath
		[[ ! -d "$RDRAMDISK" ]] && mkdir "$RDRAMDISK"
		mount -t hfs $ramDiskPath "$RDRAMDISK"
	fi	
	echo -n "a" > "$RDRAMDISK"/test.txt 2> /dev/null
	RES=$(cat "$RDRAMDISK"/test.txt 2> /dev/null) 2> /dev/null
	[[ "$RES" != "a" ]] && echo "Please check RAM drive manually!" && exit 206
	rm "$RDRAMDISK"/test.txt
fi

#create plot directory
[[ ! -d "$RDHOME/plots" ]] && mkdir "$RDHOME/plots"

#create history directory
[[ ! -d "$RDHOME/history" ]] && mkdir "$RDHOME/history"

#create the named pipe /tmp/r_in
if [ ! -e "$RDHOME"/r_in ]; then
	mkfifo "$RDHOME"/r_in
else
	if [ ! -p "$RDHOME"/r_in ]; then
		rm "$RDHOME"/r_in
		mkfifo "$RDHOME"/r_in
	fi
fi

#delete r_out and r_tmp
[[ -f "$RDRAMDISK"/r_out ]] && rm "$RDRAMDISK"/r_out
[[ -f "$RDRAMDISK"/r_tmp ]] && rm "$RDRAMDISK"/r_tmp

#copy startOptions.R if not exists 
if [ ! -f "$RDHOME"/startOptions.R ]; then
	cp "$TM_BUNDLE_SUPPORT"/Rdaemon/startOptions.R "$RDHOME"/startOptions.R
fi

#copy Rhistory.txt if not exists 
if [ ! -f "$RDHOME"/history/Rhistory.txt ]; then
	touch "$RDHOME"/history/Rhistory.txt
fi

#remove duplicated lines and date entries of /Rhistory.txt
if [ -f "$RDHOME"/history/Rhistory.txt ]; then
	cat "$RDHOME"/history/Rhistory.txt | uniq | perl -e '
	@l = <>;
	$flag=0;
	$dateline="";
	foreach $a (@l) {
		if ($a=~m/^----# /) {
			$flag = 1;
			$dateline = $a;
		} else {
			if($flag) {print "$dateline";}
			print "$a";
			$flag = 0;
		}
	}
	' > "$RDHOME"/history/Rhistory.temp
	rm "$RDHOME"/history/Rhistory.txt
	cat "$RDHOME"/history/Rhistory.temp > "$RDHOME"/history/Rhistory.txt
	rm "$RDHOME"/history/Rhistory.temp
fi

echo -n "----# " >> "$RDHOME"/history/Rhistory.txt
echo -n `date` >> "$RDHOME"/history/Rhistory.txt
echo " #----" >> "$RDHOME"/history/Rhistory.txt
#start Rdaemon
"$RDHOME"/daemon/startR.sh &> /dev/null &

#reset history counter
echo -n 0 > "$RDHOME"/history/Rhistcounter.txt

#safety counter
SAFECNT=0
#wait until r_out is created (or not) by the Rdaemon
while [ ! -f "$RDRAMDISK"/r_out ]
do
	SAFECNT=$(($SAFECNT+1))
	if [ $SAFECNT -gt 50000 ]; then
		echo -en "Start failed! No response from Rdaemon!"
		exit 206
	fi
	sleep 0.01
done

#wait for Rdaemon's output is ready
CNT=10
export token=$("$DIALOG" -a ProgressDialog -p "{title=Rdaemon;progressValue=$CNT;summary='Rdaemon is starting…';}")
while [ 1 ]
do
	ST=$(tail -n 1 "$RDRAMDISK"/r_out )
	[[ "$ST" == "> " ]] && break
	sleep 0.05
	CNT=$(( $CNT + 7 ))
	"$DIALOG" -t $token -p "{progressValue=$CNT;}" 2&>/dev/null
done

#get R's PID
RPID=$(ps aw | grep '[0-9] /.*TMRdaemon' | awk '{print $1;}' )

runs
if [ $? == 1 ]; then
	# check for R errors while starting
	"$DIALOG" -t $token -p "{summary='Waiting for respond…';progressValue=90;}" 2&>/dev/null
	POS=$(stat "$RDRAMDISK"/r_out | awk '{ print $8 }')
	echo "@|sink('$RDRAMDISK/r_tmp');cat(geterrmessage());sink(file=NULL)" > "$RDHOME"/r_in
	POSNEW=$(stat "$RDRAMDISK"/r_out | awk '{ print $8 }')
	OFF=$(($POSNEW - $POS + 2))
	while [ 1 ]
	do
		RES=$(tail -c 2 "$RDRAMDISK"/r_out)
		#expect these things from R
		[[ "$RES" == "> " ]] && break
		[[ "$RES" == "+ " ]] && break
		[[ "$RES" == ": " ]] && break
		sleep 0.05
	done
	ERR=`cat "$RDRAMDISK"/r_tmp 2>/dev/null`
	[[ ! -z "$ERR" ]] && echo -e "$ERR"
	echo -en ""
	"$DIALOG" -x $token 2&>/dev/null
else
	echo "While starting Rdaemon was shutdown unexpectedly!"
	"$DIALOG" -x $token 2&>/dev/null
	exit 206
fi
