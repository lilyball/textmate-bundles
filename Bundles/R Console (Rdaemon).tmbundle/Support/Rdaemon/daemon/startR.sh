#!/bin/bash

# this starts the daemon
cd "$HOME/Library/Application Support/Rdaemon"
export LC_ALL=${TM_RdaemonLC_ALL:-}
export LC_LANG=${TM_RdaemonLC_LANG:-en_US.UTF-8}
export LC_TIME=${TM_RdaemonLC_TIME:-}
export LC_COLLATE=${TM_RdaemonLC_COLLATE:-}
export LC_CTYPE=${TM_RdaemonLC_CTYPE:-}
export LC_MONETARY=${TM_RdaemonLC_MONETARY:-}
export LC_NUMERIC=${TM_RdaemonLC_NUMERIC:-}
export LC_MESSAGES=${TM_RdaemonLC_MESSAGES:-}
export LC_PAPER=${TM_RdaemonLC_PAPER:-}
export LC_MEASUREMENT=${TM_RdaemonLC_MEASUREMENT:-}
ruby "$HOME/Library/Application Support/Rdaemon"/daemon/Rdaemon.rb &> /dev/null &

