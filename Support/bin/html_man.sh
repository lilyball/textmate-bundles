#!/bin/bash

HTML_MAN=$0
SECTION=$1
WORD=$2

DST=$(mktemp /tmp/tm_man_XXXXXX).html
"$TM_SUPPORT_PATH/bin/man2html" >"$DST" "$SECTION" "$WORD" "$0"
echo -n "$DST"

{ sleep 300; rm "$DST"; rm "${DST%.html}"; } &>/dev/null &
