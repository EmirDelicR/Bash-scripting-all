#!/bin/bash
# This script just echo test 4 times.
# file name while.sh
# run: bash while.sh
    
i=0
while [ $i -lt 4 ]; do
  echo "Test $i"
  i=$[$i+1]
  # or
  # ((i++))
done