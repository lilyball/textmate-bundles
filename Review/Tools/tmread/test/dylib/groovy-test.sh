#!/usr/bin/env bash

. `dirname $0`/setup.sh
tm_dialog_read_init -t "Groovy Test"
groovy -e "System.in.withReader { println it.readLine() }"