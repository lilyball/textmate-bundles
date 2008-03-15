#!/usr/bin/env bash

. "$(dirname "$0")/setup.sh"
tm_dialog_read_exec -t "Ruby Test" -e 'ruby -e "puts gets"'
