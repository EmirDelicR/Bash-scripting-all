#!/bin/bash
# This program convert multi line file to one liner 
# file name: input_conversion.sh
# run bash input_conversion.sh

FILE=firends.txt
multi_liner="$(cat "$FILE")"
one_liner="$(tr '\n' ' ' < "$FILE")"

echo "This is file with multi lines:"
echo "$multi_liner"
echo "Same file only in one line"
echo "$one_liner"

for data in $multi_liner; do
  echo "Separate by space: $data"
done

echo "---------------------"

for data in $one_liner; do
  echo "Separate by space: $data"
done

echo "###### END ######"