#!/usr/bin/env bash

source $TM_SUPPORT_PATH/lib/bash_init.sh

export TM_DIALOG_READ_DYLIB="$TM_BUNDLE_SUPPORT/lib/tm_dialog_read.dylib"

TM_RUBY=${TM_RUBY:-ruby}
TM_GROOVY=${TM_GROOVY:-groovy}

require_cmd "$TM_GROOVY" "If you have installed groovy, then you need to either <a href=\"help:anchor='search_path'%20bookID='TextMate%20Help'\">update your <tt>PATH</tt></a> or set the <tt>TM_GROOVY</tt> shell variable (e.g. in Preferences / Advanced)"

require_cmd "$TM_RUBY" "We need Ruby to proceed."

groovymate.rb