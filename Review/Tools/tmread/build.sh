#!/usr/bin/env bash

dir="$(dirname "$0")"
build="$dir/build"
src="$dir/src"

if [ ! -d "$build" ]
then
    mkdir "$build"
fi

gcc -dynamiclib -Wmost -Os -fno-common \
 -DNDEBUG=1 \
 -DDATE=\"$(date +%Y-%m-%d)\" \
 -o "$build/tm_dialog_read.dylib" \
 -framework CoreFoundation \
 -arch ppc -arch i386 \
 -mmacosx-version-min=10.4 \
 -isysroot /Developer/SDKs/MacOSX10.4u.sdk \
 "$src/read.c" \
 "$src/write.c" \
 "$src/die.c" \
 "$src/buffer.c" \
 "$src/stringutil.c" \
 "$src/dialog.c" \
 "$src/plist.c"
