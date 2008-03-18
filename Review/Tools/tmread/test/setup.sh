TM_DIALOG_READ_DYLIB="$(dirname "$0")/../build/tm_dialog_read.dylib"

if [ ! -f "$TM_DIALOG_READ_DYLIB" ]
then
    echo "$TM_DIALOG_READ_DYLIB doesn't exist, build it first"
    exit 1  
fi

. "$(dirname "$0")/../helpers/tm_dialog_read.sh"