#!/usr/bin/env bash

dir="$(dirname "$0")"
build="$dir/build"
src="$dir/src"

if [ ! -d "$build" ]
then
    mkdir "$build"
fi

gcc -dynamiclib -Wmost -Os -fno-common \
 -DDATE=\"$(date +%Y-%m-%d)\" \
 -o "$build/tm_dialog_read.dylib" \
 -framework CoreFoundation \
 -arch ppc -arch i386 \
 -mmacosx-version-min=10.4 \
 -isysroot /Developer/SDKs/MacOSX10.4u.sdk \
 "$src/tm_dialog_read.c"
