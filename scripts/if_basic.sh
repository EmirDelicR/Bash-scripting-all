#!/bin/bash
# Basic if statement
# run if_basic.sh 101

if [[ $1 -gt 100 ]]; then
   echo Hey that\'s a large number.
   pwd
fi

date