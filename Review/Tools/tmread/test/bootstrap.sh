#!/usr/bin/env bash

dir=`dirname $0`




tm_dialog_read_init -p "Custom Prompt" -t "Custom Title" -n "/Applications/TextMate.app/Contents/SharedSupport/Support/nibs/RequestString.nib"

# Does a simple gets with no DATA - this seems to work as expected
#$dir/simple-test.rb 

nm -m /usr/lib/libruby.dylib | grep _read

# Does a simple gets with DATA
# $dir/simple-test-with-data.rb