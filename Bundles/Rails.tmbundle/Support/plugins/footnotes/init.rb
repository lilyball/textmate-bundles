# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Version: 1.6
# License: MIT
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Creates clickable footnotes on each rendered page, as well as clickable
#   links in the backtrace should an error occur in your Rails app.  Links take
#   you to the right place inside TextMate.

# Enable only the TextMate on Macs in development mode
if (ENV['RAILS_ENV'] == 'development')
  # Windows doesn't have 'uname', so rescue false
  ::MAC_OS_X = (`uname`.chomp == "Darwin") rescue false
  require 'textmate_footnotes'
  require 'textmate_backtracer' if ::MAC_OS_X
end
