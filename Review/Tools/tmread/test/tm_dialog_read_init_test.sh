#!/usr/bin/env bash

dir=`dirname $0`

TM_DIALOG_READ_DYLIB=$dir/../target/Release/tm_dialog_read.dylib

source $dir/../tm_dialog_read_init.sh

if tm_dialog_read_dylib_isnt_inserted 
then
    echo isnt
else
    echo is
fi

tm_dialog_read_init -p "123"

if tm_dialog_read_dylib_isnt_inserted 
then
    echo isnt
else
    echo is
fi