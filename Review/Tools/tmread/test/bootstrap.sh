#!/usr/bin/env bash

dir=`dirname $0`
TM_DIALOG_READ_DYLIB=$dir/../target/Release/tm_dialog_read.dylib

if [ ! -f $TM_DIALOG_READ_DYLIB ]
then
    echo "$TM_DIALOG_READ_DYLIB doesn't exist, build it first with 'Release' profile"
    exit 1  
fi

. $dir/../tm_dialog_read_init.sh

tm_dialog_read_init -p "Custom Prompt" -t "Custom Title" -n "/Applications/TextMate.app/Contents/SharedSupport/Support/nibs/RequestString.nib"

# Does a simple gets with no DATA - this seems to work as expected
#$dir/simple-test.rb 

nm -m /usr/lib/libruby.dylib | grep _read

# Does a simple gets with DATA
# $dir/simple-test-with-data.rb