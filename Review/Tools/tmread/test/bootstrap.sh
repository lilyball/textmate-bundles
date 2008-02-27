#!/usr/bin/env bash

dir=`dirname $0`
lib=$dir/../target/Release/tmread.dylib

if [ ! -f $lib ]
then
    echo "$lib doesn't exist, build it first"
    exit 1
fi

export DYLD_INSERT_LIBRARIES=$lib
export DYLD_FORCE_FLAT_NAMESPACE=
export COCOADIALOG_PATH="/Applications/TextMate.app/Contents/SharedSupport/Support/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog"

$dir/test.rb