#!/usr/bin/env bash
source $TM_SUPPORT_PATH/lib/bash_init.sh

export RUBYLIB="$TM_BUNDLE_SUPPORT/lib:$RUBYLIB"
TM_RUBY=${TM_RUBY:-ruby}
TM_MVN=${TM_MVN:-mvn}

require_cmd "$TM_MVN" "If you have installed maven, then you need to either <a href=\"help:anchor='search_path'%20bookID='TextMate%20Help'\">update your <tt>PATH</tt></a> or set the <tt>TM_MVN</tt> shell variable (e.g. in Preferences / Advanced)"

require_cmd "$TM_RUBY" "We need Ruby to proceed."

export TM_MVN=`which $TM_MVN`
export TM_RUBY=`which $TM_RUBY`

$TM_RUBY -rMavenMate -e "$1"