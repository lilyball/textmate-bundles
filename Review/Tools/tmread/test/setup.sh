TM_INTERACTIVE_INPUT_DYLIB="$(dirname "$0")/../build/tm_interactive_input.dylib"

if [ ! -f "$TM_INTERACTIVE_INPUT_DYLIB" ]
then
    echo "$TM_INTERACTIVE_INPUT_DYLIB doesn't exist, build it first"
    exit 1  
fi

export DYLD_INSERT_LIBRARIES="$TM_INTERACTIVE_INPUT_DYLIB${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES}"
export DYLD_FORCE_FLAT_NAMESPACE=1