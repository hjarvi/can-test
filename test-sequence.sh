#!/bin/bash
# Copyright 2022, Harri Järvi
# LICENSE: BSD-3-Clause
err=0

bitrate=$(ip -det link show can0 | awk '/bitrate/ {print $2}')

echo "bitrate=$bitrate"

script=$(cat <<EOF
from signal import signal, SIGPIPE, SIG_DFL
signal(SIGPIPE,SIG_DFL)
bitrate=$bitrate
step = 170/bitrate*2
t=0.0
i=0
while t < 120:
  t = step * i
  print("({:.6f}) can0 15555550#cccccccccccccccc".format(t))
  print("({:.6f}) can1 15555551#cccccccccccccccc".format(t))
  i = i + 1
EOF
)

time python3 -c "$script" \
  | chrt -r 10 canplayer || err=1

sleep 1
cansend can0 080#00 || err=2
cansend can1 080#01 || err=3

if [ "$err" == "1" ]; then
  echo "Test inconclusive"
elif [ "$err" == "0" ]; then
  echo "Test OK"
else
  echo "Test FAILED"
  echo "Error=$err"
fi
