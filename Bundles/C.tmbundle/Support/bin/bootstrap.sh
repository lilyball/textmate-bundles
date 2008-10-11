#!/bin/bash

eval last=\$$#;
$@ -o "${last}.out";

if [ $? -eq 0 ]; then
  "${last}.out";
fi
