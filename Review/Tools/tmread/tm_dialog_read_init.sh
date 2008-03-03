# This probably seems a bit weird right now, it just means you have to set this
# yourself, but hopefully we could set it to $TM_SUPPORT/lib/tm_dialog_read.dylib 
# when in production
TM_DIALOG_READ_DYLIB="$TM_DIALOG_READ_DYLIB" 

function tm_dialog_read_init {

    while getopts "n:t:p:s:" optionName; do
        case "$optionName" in
            n) export DIALOG_NIB="$OPTARG";;
            t) export DIALOG_TITLE="$OPTARG";;
            p) export DIALOG_PROMPT="$OPTARG";;
            s) export DIALOG_STRING="$OPTARG";;
            [?]) exit 1;;
        esac
    done
    
    if tm_dialog_read_dylib_isnt_inserted
    then
        insert_tm_dialog_read_dylib
    fi
}

function tm_dialog_read_dylib_isnt_inserted {
    expr "$DYLD_INSERT_LIBRARIES" : ".*$TM_DIALOG_READ_DYLIB.*" > /dev/null
    [ $? -ne 0 ]
    return $?
}

function insert_tm_dialog_read_dylib {
    if [ $DYLD_INSERT_LIBRARIES ]
    then
        export DYLD_INSERT_LIBRARIES="$TM_DIALOG_READ_DYLIB:$DYLD_INSERT_LIBRARIES"
    else
        export DYLD_INSERT_LIBRARIES="$TM_DIALOG_READ_DYLIB"
    fi
    export DYLD_FORCE_FLAT_NAMESPACE=
    
    return 0
}
