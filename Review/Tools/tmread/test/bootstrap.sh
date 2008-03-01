#!/usr/bin/env bash

dir=`dirname $0`
lib=$dir/../target/Release/tmread.dylib

if [ ! -f $lib ]
then
    echo "$lib doesn't exist, build it first with 'Release' profile"
    exit 1
fi

export DYLD_INSERT_LIBRARIES=$lib
export DYLD_FORCE_FLAT_NAMESPACE=

export DIALOG="/Applications/TextMate.app/Contents/PlugIns/Dialog.tmplugin/Contents/Resources/tm_dialog"
export DIALOG_NIB="/Applications/TextMate.app/Contents/SharedSupport/Support/nibs/RequestString.nib"
export DIALOG_PROMPT="Custom Prompt"
export DIALOG_TITLE="Custom Title"

# Does a simple gets with no DATA - this seems to work as expected
$dir/simple-test.rb 
 
# Does a simple gets with DATA - this isn't working as I expect, but I am not sure how exactly what __END__ does.
# $dir/simple-test-with-data.rb