#!/usr/bin/env bash

. "$(dirname "$0")/setup.sh"
tm_dialog_read_exec -t "Groovy Test" -e 'groovy -e "System.in.withReader { println it.readLine() }"'