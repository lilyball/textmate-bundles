#dispose all frozen ProgressDialogs
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
LIBPATHSFILE="$TM_BUNDLE_SUPPORT"/libpaths

# get LIB paths from R
if [ ! -e "$LIBPATHSFILE" ]; then
	echo "cat(.libPaths())" | R --slave > "$LIBPATHSFILE"
fi

LIBPATHS=$(cat "$LIBPATHSFILE")

#check for removed/installed packages
if [ -e "$PKGS" ]; then
	rm -f "$PKGSTEMP"
	for lpath in $LIBPATHS
	do
		ls "$lpath" | grep -v -F . >> "$PKGSTEMP"
	done
	if ! cmp --silent "$PKGS" "$PKGSTEMP"; then
		[[ -e "$INDEX" ]] && rm "$INDEX"
		[[ -e "$PKGS" ]] && rm "$PKGS"
	fi
	rm "$PKGSTEMP"
else
	[[ -e "$INDEX" ]] && rm "$INDEX"
fi

if [ ! -e "$HOME/Library/Application Support/TextMate/R/help" ]; then
	mkdir -p "$HOME/Library/Application Support/TextMate/R/help"
	cp -R "$TM_BUNDLE_SUPPORT/lib/command_args" "$HOME/Library/Application Support/TextMate/R/help/command_args"
fi

if [ ! -e "$INDEX" ]; then
	export token=$("$DIALOG" -a ProgressDialog -p "{title=Rdaemon;isIndeterminate=1;summary='R Documentation';details='Create Help Index…';}")
	rm -f "$PKGS"
	for lpath in $LIBPATHS
	do
		ls "$lpath" | grep -v -F . >> "$PKGS"
		FILE=$(find -f "$lpath"/* -name AnIndex)
		for f in $FILE
		do
			lib=$(echo -n "${f//\//\\/}" | sed 's/\\\/help\\\/AnIndex//')
			cat "$f" | perl -e "while(<>){\$a=\$_;\$a=~s!(.*?)\t(.*)!\$1\t$lib/latex/\$2.tex!;print \$a;}" >> "$INDEX"
		done
	done
	"$DIALOG" -x $token 2&>/dev/null
fi
