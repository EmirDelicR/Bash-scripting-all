#!/bin/bash
# Basic case statement
# file name case.sh
# run: bash case.sh 2 

variable=$1

case $variable in
                                                                                                
    [1-2]*)
        echo "Variable that you pass should start with 1 or 2: $variable"
    ;; 3)
    echo "Variable that you pass should be 3: $variable"
        ;;
    *)
        echo "All other variables: $variable"
    ;;
    esac