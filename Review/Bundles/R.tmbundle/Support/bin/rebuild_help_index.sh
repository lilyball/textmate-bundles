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

if [ ! -e "$INDEX" ]; then
	[[ -e "$HOME"/Rdaemon/daemon ]] && echo -n "$TM_BUNDLE_SUPPORT" > "$HOME"/Rdaemon/daemon/pathToRbundle
	ls "${R_HOME:-/Library/Frameworks/R.framework/Resources}"/library/ | grep -v -F . > "$PKGS"
	FILE=$(find -f "${R_HOME:-/Library/Frameworks/R.framework/Resources}"/library/* -name AnIndex)
	for f in $FILE
	do
		lib=$(echo -n "${f//\//\\/}" | sed 's/\\\/help\\\/AnIndex//')
		cat "$f" | perl -e "while(<>){\$a=\$_;\$a=~s!(.*?)\t(.*)!\$1\t$lib/latex/\$2.tex!;print \$a;}" >> "$INDEX"
		echo "100 Create Help Index…";
	done|CocoaDialog progressbar --indeterminate --title "R Documentation"
fi
