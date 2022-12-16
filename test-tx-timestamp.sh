#!/bin/bash

(
  candump -t d -T 1000 can0 \
    | sed '1d; s/^ (\([0-9.]*\).*$/\1'/ \
    | grep '000\.0000'
  res=$?
  if [ "$res" == "0" ]; then
    echo Test FAIL
    exit 1
  else
    echo Test OK
  fi
) &
candump_pid=$!
sleep 0.1

cangen -g 0.0 -I 100 -L 8 -n 8 can0

wait $candump_pid
exit $?
