#!/bin/bash

if [ $TM_GCC_MODE = "c" ]; then
  compiler=${TM_GCC:-gcc};
elif [ $TM_GCC_MODE = "c++" ]; then
  compiler=${TM_GPP:-g++};
fi

for p in $@; do
  if [ p = "--version" ]; then
    $compiler $@;
    exit;
  fi
done

eval last=\$$#;
$compiler $@ -o "${last}.out";

if [ $? -eq 0 ]; then
  "${last}.out";
fi
