#!/usr/bin/env bash

. "$(dirname "$0")/setup.sh"
tm_dialog_read_init -t "Python Test"
python -c "import sys ; sys.stdout.write(sys.stdin.readline())"