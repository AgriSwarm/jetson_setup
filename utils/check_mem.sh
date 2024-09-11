#!/bin/bash

THRESHOLD=97

used=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

echo $used
echo "$used > $THRESHOLD"
if (( $(echo "$used > $THRESHOLD" | bc -l) )); then
  echo "Memory usage is above ${THRESHOLD}%. Rebooting!"
  /sbin/shutdown -r now
fi