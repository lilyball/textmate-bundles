source "$TM_SUPPORT_PATH/lib/bash_init.sh"
export RUBYLIB="$TM_BUNDLE_SUPPORT/GrailsMate:$TM_SUPPORT_PATH/lib/${RUBYLIB:+:$RUBYLIB}"

TM_RUBY=${TM_RUBY:-ruby}
TM_GRAILS=${TM_GRAILS:-grails}

require_cmd "$TM_GRAILS" "If you have installed grails, then you need to either <a href=\"help:anchor='search_path'%20bookID='TextMate%20Help'\">update your <tt>PATH</tt></a> or set the <tt>TM_GRAILS</tt> shell variable (e.g. in Preferences / Advanced)"

require_cmd "$TM_RUBY" "We need Ruby to proceed."

export TM_GRAILS=`which $TM_GRAILS`
export TM_RUBY=`which $TM_RUBY`

"${TM_RUBY}" -r GrailsMate -r ui -- "$TM_BUNDLE_SUPPORT/GrailsMate/$1.rb"

rescan_project