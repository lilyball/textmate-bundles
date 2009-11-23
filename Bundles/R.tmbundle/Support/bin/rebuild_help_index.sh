#dispose all frozen ProgressDialogs first
{
while [ 1 ]
do
	res=$("$DIALOG" -x `"$DIALOG" -l 2>/dev/null| grep Rdaemon | cut -d " " -f 1` 2>/dev/null)
	[[ ${#res} -eq 0 ]] && break
done
} &

#rebuild help.index?

PKGS="$TM_BUNDLE_SUPPORT"/help.pkgs
PKGSTEMP="$TM_BUNDLE_SUPPORT"/help.pkgstemp
INDEX="$TM_BUNDLE_SUPPORT"/help.index
INDEXSHORT="$TM_BUNDLE_SUPPORT"/helpshort.index
IS_HELPSERVERPATH="$TM_BUNDLE_SUPPORT"/isHelpserver
LIBPATHSFILE="$TM_BUNDLE_SUPPORT"/libpaths

# get LIB paths from R
LIBPATHS=$(echo "cat(paste(.libPaths(),collapse='\n'));cat('\n');cat(getRversion() >= '2.10.0')" | R --slave)
IS_HELPSERVER=$(echo -e "$LIBPATHS" | tail -n1)
LIBPATHS=$(echo -e "$LIBPATHS" | sed '$d')
echo "$IS_HELPSERVER" > "$IS_HELPSERVERPATH"
echo -e "$LIBPATHS" > "$LIBPATHSFILE"

#check for removed/installed packages
if [ -e "$PKGS" ]; then
	rm -f "$PKGSTEMP"
	for lpath in $LIBPATHS
	do
		ls "$lpath" | grep -v -F . >> "$PKGSTEMP"
	done
	if ! cmp --silent "$PKGS" "$PKGSTEMP"; then
		[[ -e "$INDEX" ]] && rm "$INDEX"
		[[ -e "$INDEXSHORT" ]] && rm "$INDEXSHORT"
		[[ -e "$PKGS" ]] && rm "$PKGS"
	fi
	rm "$PKGSTEMP"
else
	[[ -e "$INDEX" ]] && rm "$INDEX"
	[[ -e "$INDEXSHORT" ]] && rm "$INDEXSHORT"
fi

if [ ! -e "$HOME/Library/Application Support/TextMate/R/help" ]; then
	mkdir -p "$HOME/Library/Application Support/TextMate/R/help"
	cp -R "$TM_BUNDLE_SUPPORT/lib/command_args" "$HOME/Library/Application Support/TextMate/R/help/command_args"
fi

if [ ! -e "$INDEX" -o ! -e "$INDEXSHORT" ]; then
	rm -f "$PKGS"
	CNT=0
	export token=$("$DIALOG" -a ProgressDialog -p "{title=Rdaemon;progressValue=$CNT;summary='R Documentation';details='Creating Help Index…';}")
	for lpath in $LIBPATHS
	do
		CNT=0
		if [ -d "$lpath" ]; then
			ls "$lpath" | grep -v -F . >> "$PKGS"
			FILE=$(find -f "$lpath"/*//* -name AnIndex 2>/dev/null)
			LCNT=$(echo "$FILE" | wc -l)
			for f in $FILE
			do
				lib=$(echo -n "${f//\//\\/}" | sed 's/\\\/help\\\/AnIndex//')
				cat "$f" | perl -e "while(<>){\$a=\$_;\$a=~s!(.*?)\t(.*)!\$1\t$lib/latex/\$2.tex!;print \$a;}" >> "$INDEX"
				cat "$f" | perl -e "while(<>){\$a=\$_;\$a=~s!(.*?)\t(.*)!${lib##*/}/\$2!;print \$a;}" >> "$INDEXSHORT"
				cat "$f" | perl -e "while(<>){\$a=\$_;\$a=~s!(.*?)\t(.*)!${lib##*/}/\$1!;print \$a;}" >> "$INDEXSHORT"
				CNT=$(( $CNT + 1 ))
				DCNT=$(( $CNT*100/$LCNT ))
				"$DIALOG" -t $token -p "{details='Creating Help Index for ${lib##*/}…';progressValue=$DCNT;}" 2&>/dev/null
			done
		fi
	done
	#Make INDEXSHORT unique
	cat "$INDEXSHORT" > /tmp/tm_r_indexshort_temp0815
	[[ -e "$INDEXSHORT" ]] && rm "$INDEXSHORT"
	cat /tmp/tm_r_indexshort_temp0815 | sort | uniq > "$INDEXSHORT"
	rm /tmp/tm_r_indexshort_temp0815
	"$DIALOG" -x $token 2&>/dev/null
fi

