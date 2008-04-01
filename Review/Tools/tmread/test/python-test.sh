#!/usr/bin/env bash

. "$(dirname "$0")/setup.sh"
TM_INTERACTIVE_INPUT=AUTO python -c "import sys ; sys.stdout.write(sys.stdin.readline())"