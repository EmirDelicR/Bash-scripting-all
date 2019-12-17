#!/bin/bash
# This script count length of files and add user to pick option
# file name: function_list_pick_file.sh

list_length () {
  local length_result=$(wc -w <<< "$@")
  # Shorter
  # echo "$#"
  echo "$length_result"
}

isInteger () {
  test "$1" -ge 0 2>/dev/null
  [ $? -eq 2 ] && echo -e "Please provide an number of lines not an string '$1'!" && exit 1
}

LISTA="$(ls)"

OPTIONS="$(list_length "$LISTA")"

select FILENAME in *; do
  isInteger $REPLY
  if [[ $REPLY -gt $OPTIONS ]]; then
    echo "Do not be an plonker!"
    exit 1
  elif [[ $REPLY -eq 0 ]]; then
    echo "By :)"
    exit 1
  fi
  echo "You picked $FILENAME ($REPLY). To exit input 0"
done
