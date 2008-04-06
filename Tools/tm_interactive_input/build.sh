#!/usr/bin/env bash

NDEBUG=1

SCRIPT_DIR="$(dirname "$0")"
SRC_DIR="$SCRIPT_DIR/src"
DST_DIR="$SCRIPT_DIR/build"
LIB_NAME="tm_interactive_input.dylib"

function build {
  DEPLOYMENT=10.4
  SDK=/Developer/SDKs/MacOSX10.4u.sdk

  if [[ "$1" = *64 ]]; then
  	DEPLOYMENT=10.5
  	SDK=/Developer/SDKs/MacOSX10.5.sdk
  fi

  echo "Building ‘tm_interactive_input_$1.dylib’ (for ${DEPLOYMENT}${NDEBUG:+, no debug})…"
  gcc -dynamiclib -Wmost -Os -fno-common \
    -framework CoreFoundation \
    -DDATE=\"$(date +%Y-%m-%d)\" \
    ${NDEBUG:+-DNDEBUG=1} \
    -mmacosx-version-min="$DEPLOYMENT" -isysroot "$SDK" \
    -arch "$1" \
    -o "$DST_DIR/tm_interactive_input_$1.dylib" \
    "$SRC_DIR"/*.c
    [ $? = 0 ] || exit 1
}

if [[ -d "$DST_DIR" ]]; then
  echo "Cleaning old build dir (‘"$DST_DIR"’)…"
  rm -rf "$DST_DIR"
fi

if ! mkdir "$DST_DIR"; then exit; fi

for ARCH in ppc i386 ppc64 x86_64; do build "$ARCH"; done

echo "Merging…"
cd "$DST_DIR"
lipo -create tm_interactive_input_*.dylib -output "$LIB_NAME" && rm tm_interactive_input_*.dylib
lipo -info "$LIB_NAME"

SUPPORT_LIB="$TM_SUPPORT_PATH/lib"
echo "Copying to support…"
cp "$LIB_NAME" "$SUPPORT_LIB"