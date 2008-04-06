#!/usr/bin/env bash

. "$(dirname "$0")/setup.sh"
TM_INTERACTIVE_INPUT=AUTO ruby -e "puts 'decoy line'
    print 'Enter Something: '
    STDOUT.flush
    puts gets
"