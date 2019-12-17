#!/bin/bash
# This script will test if you have given a leap year or not.
# file name input_leap.sh
# run bash input_leap.sh

echo "Type the year that you want to check (4 digits), followed by [ENTER]:"

# This will store user input to variable year
read year

if (( ("$year" % 400) == "0" )) || (( ("$year" % 4 == "0") && ("$year" % 100 !="0") )); then
  echo "$year is a leap year."
else
  echo "This is not a leap year."
fi