#!/usr/bin/env bash

. "$(dirname "$0")/setup.sh"
TM_INTERACTIVE_INPUT=AUTO php -r "echo file_get_contents('php://stdin');"