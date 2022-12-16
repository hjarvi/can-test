#!/bin/bash

(
  candump -T 1000 any \
    | sed 's/^.*\(can[0-9]\).*$/\1/' \
    | sort | uniq -c \
    | (
     read can0_count x
     read can1_count x
      if [ "$can0_count" != 100000 ] || [ "$can1_count" != 100000 ]; then
        echo "can0 $can0_count"
        echo "can1 $can1_count"
        echo Test FAIL
        exit 1
      else
        echo Test OK
      fi
    )
  exit $?
) &
candump_pid=$!

sleep 0.1
cangen can0 -g 0.5 -I 100 -L 1 -D i -n 50000 & cangen can1 -g 0.5 -I 101 -L 1 -D i -n 50000 &

wait $candump_pid
exit $?
