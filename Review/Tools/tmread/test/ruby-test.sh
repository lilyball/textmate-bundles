#!/usr/bin/env bash

. "$(dirname "$0")/setup.sh"
tm_dialog_read_exec 'ruby -e "puts \"decoy line\"; print \"Enter Something: \"; STDOUT.flush; puts gets"' "Ruby Test"