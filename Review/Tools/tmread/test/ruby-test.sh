#!/usr/bin/env bash

. "$(dirname "$0")/setup.sh"
tm_dialog_read_exec 'ruby -e "puts gets"' "Ruby Test"
