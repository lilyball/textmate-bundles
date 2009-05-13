source "$TM_SUPPORT_PATH/lib/bash_init.sh"
export RUBYLIB="$TM_BUNDLE_SUPPORT/GriffonMate:$TM_SUPPORT_PATH/lib/${RUBYLIB:+:$RUBYLIB}"

TM_RUBY=${TM_RUBY:-ruby}
TM_GRIFFON=${TM_GRIFFON:-griffon}

require_cmd "$TM_GRIFFON" "If you have installed griffon, then you need to either <a href=\"help:anchor='search_path'%20bookID='TextMate%20Help'\">update your <tt>PATH</tt></a> or set the <tt>TM_GRIFFON</tt> shell variable (e.g. in Preferences / Advanced)"

require_cmd "$TM_RUBY" "We need Ruby to proceed."

export TM_GRIFFON=`which $TM_GRIFFON`
export TM_RUBY=`which $TM_RUBY`
script="$1"
shift

"${TM_RUBY}" -r GriffonMate -r ui -- "$TM_BUNDLE_SUPPORT/GriffonMate/$script.rb" $@

rescan_project