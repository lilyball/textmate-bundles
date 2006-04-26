#!/bin/sh
#
# $1 = svn old revision
# $2 = svn new revision ('-' for working copy)
#
# $Id$
#

# Build the revision spec
REVS="$1"

if [ "$2" != "-" ]; then
	REVS="${REVS}:$2"
fi

# See if there is any difference between the revisions
FILE=`basename "$TM_FILEPATH"`
SIZE=`svn diff -r "$REVS" "$FILE" | wc -m`

if [ $SIZE -eq 0 ]; then
	echo "No difference"
	exit 206
fi

# Get a random number
RAND=`awk 'BEGIN {srand(); print rand()}' | cut -d . -f 2`

# Save a temporary copy of the old revision
OLDPATH="/tmp/tm-opendiff-$RAND.tmp"
svn cat -r "$1" "$FILE" > "$OLDPATH"

# If the new revision is not the working copy, save a temporary copy
# of it with which to compare.
if [ "$2" != "-" ]; then
	NEWPATH=${OLDPATH}.2
	svn cat -r "$2" "$FILE" > "$NEWPATH"
else
	NEWPATH="$TM_FILEPATH"
fi

opendiff "$OLDPATH" "$NEWPATH" &>/dev/null &