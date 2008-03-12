#!/usr/bin/env bash

. `dirname $0`/setup.sh
tm_dialog_read_init -t "Ruby Test"
ruby -e "puts gets"