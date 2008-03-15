TM_DIALOG_READ_DYLIB="$(dirname "$0")/../build/tm_dialog_read.dylib"

if [ ! -f "$TM_DIALOG_READ_DYLIB" ]
then
    echo "$TM_DIALOG_READ_DYLIB doesn't exist, build it first"
    exit 1  
fi

if [ -x "$DIALOG_1" ]; then # FIXME this is only because Dialog v2 is apparently not backwards compatible with these tests
  export DIALOG="$DIALOG_1"
fi


. "$(dirname "$0")/../helpers/tm_dialog_read.sh"