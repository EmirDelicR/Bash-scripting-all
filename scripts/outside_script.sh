#!/bin/bash
# This script returns exit status
# file name: outside_script.sh

if [[ $data -eq 1 ]]; then
  echo "You pass option 1"
  exit 1
elif [[ $data -eq 2 ]]; then
  echo "You pass option 2"
  exit 2
elif [[ $data -eq 3 ]]; then
  echo "You pass option 3"
  exit 3
else
  echo "You pass option $data"
  exit $data  
fi
