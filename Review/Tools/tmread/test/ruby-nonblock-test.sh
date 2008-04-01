#!/usr/bin/env bash

# When running this, we are expecting the dialog *not* to appear. 
# We are testing that we don't invoke for non blocking reads.
# 
# The reason for the begin/rescue is that read_nonblock errors if it gets EOF
# which it will.

. "$(dirname "$0")/setup.sh"
TM_INTERACTIVE_INPUT=AUTO ruby -e '
begin 
    puts STDIN.read_nonblock(1)
rescue
    puts "non blocking read done"
end'
