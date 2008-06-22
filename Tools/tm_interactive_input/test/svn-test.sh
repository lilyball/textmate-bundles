#!/usr/bin/env bash

# In svn 1.5.0 this does not work. It does in < 1.5.0 though.
# It never returns from the log command. It appears to be something to do with the select() impl.

# Note: it's not supposed to bring up an input dialog, it's just supposed to complete.

SVN=svn

. "$(dirname "$0")/setup.sh"
"$SVN" --version | head -1
TM_INTERACTIVE_INPUT=AUTO "$SVN" log http://macromates.com/svn/Bundles --limit 1