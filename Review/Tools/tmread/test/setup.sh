TM_DIALOG_READ_DYLIB="$(dirname "$0")/../build/tm_dialog_read.dylib"

if [ ! -f "$TM_DIALOG_READ_DYLIB" ]
then
    echo "$TM_DIALOG_READ_DYLIB doesn't exist, build it first"
    exit 1  
fi

export DYLD_INSERT_LIBRARIES="$TM_DIALOG_READ_DYLIB${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES}"
export DYLD_FORCE_FLAT_NAMESPACE=1