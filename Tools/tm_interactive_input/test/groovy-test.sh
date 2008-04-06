#!/usr/bin/env bash

. "$(dirname "$0")/setup.sh"
TM_INTERACTIVE_INPUT=AUTO groovy -e "System.in.withReader { println it.readLine() }"