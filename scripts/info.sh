#!/bin/bash

clear
echo "####### This is information provided by mysystem.sh #######"
printf "Program starts now. \n\n"
printf "Hello, $USER \n\n"
printf "Today's date is `date`, this is week `date +"%V"`. \n\n"
echo "These users are currently connected:"
w | cut -d " " -f 1 - | grep -v USER | sort -u
echo ""
printf "This is `uname -s` running on a `uname -m` processor. \n\n"
echo "This is the uptime information:"
uptime
echo ""
printf "############## That's all folks! ############## \n"