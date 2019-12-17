#!/bin/bash
# This script creates a subdirectory in the current directory, to which old
# files are moved.
# file name: cron_script.sh

# create date in format 20191212
DIRNAMEEXT=`date +%Y%m%d`

# create like $PWD for this current file if this is called from some other place
DIRECTORY="$(dirname "$0")"

DESTDIRPATH="$DIRECTORY/archive-$DIRNAMEEXT"
# This create directory
mkdir "$DESTDIRPATH"

while read file; do
  echo "File: $file"
  gzip "$file"
  mv "$file".gz "$DESTDIRPATH"
  echo "$file archived"
done < <(find "$PWD" -type f)

# This line is piping result from find to while function
# find in current directory ($PWD) all files (-type f) and data was last modified n*24 hours ago (-mtime +5)
# done < <(find "$PWD" -type f -mtime +5)