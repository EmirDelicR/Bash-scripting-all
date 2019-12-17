#!/bin/bash
# This script acts upon the exit status given by other
# file name: inner_script.sh
# run: bash inner_script.sh 54

# export variable to use in other script
export data="$1"

# Import other script
feed="./outside_script.sh"

# Execute other script
$feed $data

# $? is returned form exit command of first script

case $? in

  [1-2]*)
    echo "Exit status of other script should be 1 or 2: $?"
  ;; 
  3)
    echo "Exit status of other script should be 3: $?"
  ;;
  *)
    echo "All other exit status: $?"
  ;;
esac
