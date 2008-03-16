# This probably seems a bit weird right now, it just means you have to set this
# yourself, but hopefully we could set it to $TM_SUPPORT/lib/tm_dialog_read.dylib 
# when in production

if [ ! "$TM_DIALOG_READ_DYLIB" ]
then
    echo "TM_DIALOG_READ_DYLIB not set"
    exit 1
fi

#TM_DIALOG_READ_DYLIB="$TM_SUPPORT_PATH/lib/tm_dialog_read.dylib" 

function tm_dialog_read_exec {

    exec="$1"
    title="$2"
    
    if [ "$exec" ]
    then
        DIALOG_TITLE="$title" \
        DYLD_INSERT_LIBRARIES="$TM_DIALOG_READ_DYLIB${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES}" \
        DYLD_FORCE_FLAT_NAMESPACE=1 \
        eval "$exec"
    else
        echo "tm_dialog_read_exec(): -e is required"
        exit 1
    fi

}
