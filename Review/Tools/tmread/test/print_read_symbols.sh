#!/usr/bin/env bash

. "$(dirname "$0")/setup.sh"

nm -m "$TM_DIALOG_READ_DYLIB" | grep _read
