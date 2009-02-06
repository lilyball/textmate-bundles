#!/bin/bash

# this starts the daemon
cd ~/Rdaemon
export LC_ALL=${TM_RdaemonLC_ALL:-en_US.UTF-8}
export LC_TIME=${TM_RdaemonLC_TIME:-}
export LC_COLLATE=${TM_RdaemonLC_COLLATE:-}
export LC_CTYPE=${TM_RdaemonLC_CTYPE:-en_US.UTF-8}
export LC_MONETARY=${TM_RdaemonLC_MONETARY:-}
export LC_NUMERIC=${TM_RdaemonLC_NUMERIC:-}
export LC_MESSAGES=${TM_RdaemonLC_MESSAGES:-en_US.UTF-8}
export LC_PAPER=${TM_RdaemonLC_PAPER:-}
export LC_MEASUREMENT=${TM_RdaemonLC_MEASUREMENT:-}
ruby ~/Rdaemon/daemon/Rdaemon.rb &> /dev/null &

