#!/usr/bin/env bash

dir=`dirname "$0"`
build="$dir/build"
src="$dir/src"

if [ ! -d $build ]
then
    mkdir $build
fi

gcc -dynamiclib -o "$build/tm_dialog_read.dylib" -fno-common -framework CoreFoundation -mmacosx-version-min=10.4 -Xlinker -undefined -Xlinker dynamic_lookup  "$src/tm_dialog_read.c" 