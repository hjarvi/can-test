#!/bin/bash

trap interrupt INT

function interrupt() {
  echo .
}

(
  candump -T 1000 any \
    | sed 's/^.*\(can[0-9]\).*$/\1/' \
    | sort | uniq -c \
    | (
     read can0_count x
     read can1_count x
      if [ "$can0_count" != "$can1_count" ]; then
        echo "can0 $can0_count"
        echo "can1 $can1_count"
        echo Test FAIL
        exit 1
      fi
    )
  exit $?
) &
candump_pid=$!

echo Ctrl-C to end test.
sleep 0.1
cangen -e -g 1 can0 & cangen -g 1 can1

wait $candump_pid

cangen -e -g 1 can0 -n 32 \
  && cangen -g 1 can1 -n 32

res=$?

if [ "$res" == "0" ]; then
  echo Test OK
else
  echo Test FAIL
fi

exit $res
