#!/usr/bin/env bash

dir=`dirname $0`
lib=$dir/../target/Release/tm_dialog_read.dylib

if [ ! -f $lib ]
then
    echo "$lib doesn't exist, build it first with 'Release' profile"
    exit 1
fi

if [ $DYLD_INSERT_LIBRARIES ]
then
    export DYLD_INSERT_LIBRARIES="$lib:$DYLD_INSERT_LIBRARIES"
else
    export DYLD_INSERT_LIBRARIES="$lib"
fi 

export DYLD_FORCE_FLAT_NAMESPACE=

#export DIALOG="/Applications/TextMate.app/Contents/PlugIns/Dialog.tmplugin/Contents/Resources/tm_dialog"
#export DIALOG_NIB="RequestString"
export DIALOG_PROMPT="Custom Prompt"
export DIALOG_TITLE="Custom Title"

# Does a simple gets with no DATA - this seems to work as expected
$dir/simple-test.rb 
 
# Does a simple gets with DATA
# $dir/simple-test-with-data.rb