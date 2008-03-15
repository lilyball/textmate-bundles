#!/usr/bin/env bash

. "$(dirname "$0")/setup.sh"
tm_dialog_read_exec -t "Bash Test" -e 'echo `bash -c "read x; echo $x"`'