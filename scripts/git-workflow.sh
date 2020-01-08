#!/bin/bash
# This script clean untracked files in git repo

function git_clean_untracked_safely {
  TO_REMOVE=`git clean -f -d -n`;

  if [[ -n "$TO_REMOVE" ]]; then
    echo "Cleaning...";
    printf "\n$TO_REMOVE\n\n";
    echo "Proceed?";

    select result in Yes No; do
      if [[ "$result" == "Yes" ]]; then
        echo "Cleaning in progress...";
        echo "";
        git clean -f -d;
        echo "";
        echo "All files and directories removed!";
      fi
      break;
    done;
  else
    echo "Everything is clean";
  fi;
}

# create alias
# alias gcl='git_clean_untracked_safely'
# call:  glc


function git_clean_local_branches {
  OPTION="-d";
  if [[ "$1" == "-f" ]]; then
    echo "WARNING! Removing with force";
    OPTION="-D";
  fi;

  TO_REMOVE=`git branch -r | awk "{print \\$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \\$1}"`;
  if [[ -n "$TO_REMOVE" ]]; then
    echo "Removing branches...";
    echo "";
    printf "\n$TO_REMOVE\n\n";
    echo "Proceed?";

    select result in Yes No; do
      if [[ "$result" == "Yes" ]]; then
        echo "Removing in progress...";
        echo "$TO_REMOVE" | xargs git branch "$OPTION";
        if [[ "$?" -ne "0" ]]; then
          echo ""
          echo "Some branches was not removed, you have to do it manually!";
        else
          echo "All branches removed!";
        fi
      fi

      break;
    done;
  else
    echo "You have nothing to clean";
  fi
}

# create alias same as above
# alias glpo='git_clean_local_branches'
# run: glpo 
# This will force clean up but be careful
# run: glpo -f 


# This is counting lines of code in files
alias sloc="git ls-files \"*.js*\" \"*.scss\" | xargs wc -l"

