#!/bin/bash
# This is a program that keeps your address book up to date.
# file name input_address.sh

FILE=firends.txt

# check if file exists
if ! [[ -f "$FILE" ]]; then
    echo "Creating file friends.txt..."
    touch firends.txt
fi

echo "Hello, "$USER". This script will register you in some database."
echo -n "Enter your name and press [ENTER]: "
read name
echo
grep -i "$name" "$FILE"

if [[ $? -eq 0 ]]; then
  echo "You are already registered, quitting."
  exit 1
else
    echo -n "How old are you? "
    read age
    if [[ $age -lt 25 ]]; then
      echo -n "Which colour of hair do you have? "
      read colour
      echo "$name $age $colour" >> "$FILE"
      echo "You are added to database. Thank you so much!"
    else
      echo "You are to old to be in this list."
      exit 1
    fi
fi