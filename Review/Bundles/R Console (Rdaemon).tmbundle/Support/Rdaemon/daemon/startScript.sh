###########
#
# Rdaemon start script
#
#   Hans-Jörg Bibiko - bibiko@eva.mpg.de
#
###########

######### global variables #########

if [ "$TM_RdaemonRAMDRIVE" == "1" ]; then
	RDRAMDISK="/tmp/TMRramdisk1"
else
	RDRAMDISK="$HOME"/Rdaemon
fi

RDHOME="$HOME/Rdaemon"
RAMSIZE=${TM_RdaemonRAMSIZE:-50}


######### functions #########

runs() {
	RUBYRUN=$(ps xw | grep '[0-9] ruby.*Rdaemon')
	RRUN=$(ps aw | grep '[0-9] /Lib.*TMRdaemon')
	if [ ${#RRUN} == 0 -a ${#RUBYRUN} == 0 ]; then
		return 0
	else
		return 1
	fi
}

######### script begin #########

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
		echo -n "$ramDiskPath" > ~/Rdaemon/daemon/ramDiskPath
		newfs_hfs -v 'TMRdaemon' $ramDiskPath
#		if [ -d "$RDRAMDISK" ]; then
#			RES=$(rmdir "$RDRAMDISK")
#			[[ ! -z "$RES" ]] && echo "Please delete $RDRAMDISK manually!" && exit 206
#		fi
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
	cp "$TM_BUNDLE_SUPPORT"/bin/startOptions.R "$RDHOME"/startOptions.R
fi
#copy Rhistory.txt if not exists 
if [ ! -f "$RDHOME"/history/Rhistory.txt ]; then
	touch "$RDHOME"/history/Rhistory.txt
fi

#remove duplicated lines of /Rhistory.txt
if [ -f "$RDHOME"/history/Rhistory.txt ]; then
	cat "$RDHOME"/history/Rhistory.txt | uniq > "$RDHOME"/history/Rhistory.temp
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
echo -n 0 > "$HOME"/Rdaemon/history/Rhistcounter.txt

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
while [ 1 ]
do
	ST=$(tail -n 1 "$RDRAMDISK"/r_out )
	[[ "$ST" == "> " ]] && break
	echo "100 Rdaemon is starting…";
	sleep .05
done|CocoaDialog progressbar --indeterminate --title "Rdaemon"

#get R's PID
RPID=$(ps aw | grep '[0-9] /Lib.*TMRdaemon' | awk '{print $1;}' )

runs
if [ $? == 1 ]; then
	# check for R errors while starting
	POS=$(stat "$RDRAMDISK"/r_out | awk '{ print $8 }')
	echo "@|sink('$RDRAMDISK/r_tmp');cat(geterrmessage());sink(file=NULL)" > ~/Rdaemon/r_in
	POSNEW=$(stat "$RDRAMDISK"/r_out | awk '{ print $8 }')
	OFF=$(($POSNEW - $POS + 2))
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
	done|CocoaDialog progressbar --title "Rdaemon is busy ..."
	ERR=`cat "$RDRAMDISK"/r_tmp 2>/dev/null`
	[[ ! -z "$ERR" ]] && echo -e "$ERR"
	echo -en ""
else
	echo "While starting Rdaemon was shutdown unexpectedly!"
	exit 206
fi
