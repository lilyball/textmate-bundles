#!/usr/bin/env bash

. "$(dirname "$0")/setup.sh"
tm_dialog_read_exec 'echo `bash -c "read x; echo $x"`' "Bash Test"