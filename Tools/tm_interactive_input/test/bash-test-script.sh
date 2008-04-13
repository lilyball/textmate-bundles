#!/usr/bin/env bash

echo -n "Enter Username: "
read x
echo -n "Enter Password: "
read x

# This should not bring up the dialog…
# this tests dialog only comes up when stdin
# is owned by TM
{ sleep .1; echo; } | cat

