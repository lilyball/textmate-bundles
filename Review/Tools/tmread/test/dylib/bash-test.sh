#!/usr/bin/env bash

. `dirname $0`/setup.sh
tm_dialog_read_init -t "Bash Test"
echo `bash -c "read x; echo $x"