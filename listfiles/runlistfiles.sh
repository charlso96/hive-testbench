#!/bin/bash
#
for file in `hadoop classpath | tr ':' ' ' | sort | uniq`
do
  export CLASSPATH=$CLASSPATH:$file
done
./listfiles /data/listfiles/results.txt
