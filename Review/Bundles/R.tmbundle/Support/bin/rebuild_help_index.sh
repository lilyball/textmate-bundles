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
INDEX="$TM_BUNDLE_SUPPORT"/help.index

#check for removed/installed paclages
if [ -e "$PKGS" ]; then
	FILE=$(ls "${R_HOME:-/Library/Frameworks/R.framework/Resources}"/library/  | grep -v -F .)
	OLD=$(cat "$PKGS")
	if [ "$OLD" != "$FILE" ]; then
		[[ -e "$INDEX" ]] && rm "$INDEX"
		[[ -e "$PKGS" ]] && rm "$PKGS"
	fi
else
	[[ -e "$INDEX" ]] && rm "$INDEX"
fi

if [ ! -e "$HOME/Library/Application Support/TextMate/R/help" ]; then
	mkdir -p "$HOME/Library/Application Support/TextMate/R/help"
	cp -R "$TM_BUNDLE_SUPPORT/lib/command_args" "$HOME/Library/Application Support/TextMate/R/help/command_args"
fi

if [ ! -e "$INDEX" ]; then
	export token=$("$DIALOG" -a ProgressDialog -p "{title=Rdaemon;isIndeterminate=1;summary='R Documentation';details='Create Help Index…';}")
	[[ -e "$HOME"/Rdaemon/daemon ]] && echo -n "$TM_BUNDLE_SUPPORT" > "$HOME"/Rdaemon/daemon/pathToRbundle
	ls "${R_HOME:-/Library/Frameworks/R.framework/Resources}"/library/ | grep -v -F . > "$PKGS"
	FILE=$(find -f "${R_HOME:-/Library/Frameworks/R.framework/Resources}"/library/* -name AnIndex)
	for f in $FILE
	do
		lib=$(echo -n "${f//\//\\/}" | sed 's/\\\/help\\\/AnIndex//')
		cat "$f" | perl -e "while(<>){\$a=\$_;\$a=~s!(.*?)\t(.*)!\$1\t$lib/latex/\$2.tex!;print \$a;}" >> "$INDEX"
	done
	"$DIALOG" -x $token 2&>/dev/null
fi
