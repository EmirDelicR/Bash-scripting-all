#!/bin/bash
# This script reads 3 positional parameters and prints them out.

POSPAR1="$1" # this is what you pass as var_one

echo "Print all $@"
echo "$POSPAR1 is the first positional parameter, $1."
echo "$2 is the second positional parameter, $2."
echo "$3 is the third positional parameter, $3."
printf "The total number of positional parameters is $#. \n"