#!/usr/bin/env bash

dir=`dirname "$0"`
build="$dir/build"
src="$dir/src"

if [ ! -d $build ]
then
    mkdir $build
fi

gcc -dynamiclib -o "$build/tm_dialog_read.dylib" -fno-common -framework CoreFoundation -mmacosx-version-min=10.4 -D__DARWIN_UNIX03=1  -D__DARWIN_NON_CANCELABLE=1 "$src/tm_dialog_read.c" 