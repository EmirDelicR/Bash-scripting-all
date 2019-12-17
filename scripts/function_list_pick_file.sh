#!/bin/bash
# This script count length of files and add user to pick option
# file name: function_list_pick_file.sh

list_length () {
  local length_result=$(wc -w <<< "$@")
  # Shorter
  # echo "$#"
  echo "$length_result"
}

LISTA="$(ls)"

OPTIONS="$(list_length "$LISTA")"

select FILENAME in *; do
  if [[ $REPLY -gt $OPTIONS ]]; then
    echo "Do not be an plonker!"
    exit 1
  elif [[ $REPLY == "E" ]]; then
    echo "By :)"
    exit 1
  fi
  echo "You picked $FILENAME ($REPLY). To exit input E"
done