#!/bin/bash
# This script show how to work with functions
# file name: function.sh

list_length () {
  echo "~~~~~ 1 ~~~~~~~"
  echo "$1"
  echo "~~~~~ 2 ~~~~~~~"
  echo "$2"
  echo "~~~~~ 3 ~~~~~~~"
  echo "$3"
  echo "~~~~~ 4 ~~~~~~~"
  echo "$4"
  echo "***** All ******"
  #	All arguments as separate words
  echo "$@"
  echo "***** Args num ******"
  # Number of arguments
  echo "$#"
}

LISTA="$(ls)"
list_length "var_1" "var_2" "var_3" "var_4" "$LISTA"