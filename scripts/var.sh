#!/bin/bash
# This script show how to work with arraya and strings
# file name: var.sh

# Array

ARRAY=(1 2 3 4)

echo "Output: $ARRAY"
# Output: 1

echo "Output: ${ARRAY[*]}"
# Output: 1 2 3 4

echo "Output: $ARRAY[*]"
# Output: 1[*]

echo "Output: ${ARRAY[2]}"
# Output: 3

ARRAY[4]=5
echo "Output: ${ARRAY[*]}"
# Output: 1 2 3 4 5

unset ARRAY[1]
# 2 3 4 5

unset ARRAY
# no output

# Strings

WORD="this is some word"
echo "$WORD"
# this is some word

echo "${WORD:1}"
# his is some word

echo "${WORD:8:4}"
# some

# Deleting from string / array

ARRAY=(one two one three one four)
# { } Expand elements in list
echo "${ARRAY[*]}"
# one two one three one four

echo "${ARRAY[*]#one}"
# two three four

echo "${ARRAY[*]#t}"
# one wo one hree one four

echo "${ARRAY[*]#t*}"
# one wo one hree one four

echo "${ARRAY[*]##t*}"
# one one one four

echo "${WORD%rd}"
# this is some wo (this only work if removing last part of string)

# ${VAR/PATTERN/STRING}
echo "${WORD/o/?}"
# this is s?me word

# ${VAR//PATTERN/STRING} - replace all matches
echo "${WORD//o/?}"
# this is s?me w?rd