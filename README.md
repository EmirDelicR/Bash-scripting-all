## SOME TERMINAL COMMANDS - MOST USED

#### content

- [Intro](#intro) <br/>
- [Find IP Address](#ip) <br/>
- [AWK command](#awk) <br/>
- [Copy/Paste](#cp) <br/>
- [Find File](#find) <br/>
- [Create/Delete File/Directory](#edit) 
- [Change permissions and user for directory/file](#permission)
- [Write in File](#write) 
- [Command grep](#grep)
- [File difference](#diff)

- [Bash Scripting](#bash)
  - [Passing variables](#variables)
  - [IF statement](#if)
  - [CASE statement](#case)
  - [FOR loop](#for)
  - [WHILE loop](#while)
  - [Script in script execution](#scripts)
  - [Ask user for input](#input)
  - [Chron Job](#chron)
  - [Functions](#function)
  - [Variables](#var)
  - [Redirect output](#redirect)
  
 - [Some my useful scripts](#myscripts)
  - [File spliting](#split)
  - [Terminal check](#terminal)
  - [Color output](#color)
  - [xdotool](#xdotool)
  - [My Automation Work](#auto)
  - [Clean app build](#clean)
  
### intro

HINT 

- use: **yelp man:command** OR **man command** OR **command -h** to read command instruction

- run: **bash command.sh** OR **./command.sh** (For this one set file to be executable)

[TOP](#content)

### ip

```console
$ ip addr show enp0s25 | grep inet | head -1 | awk '{ print $2, $4 }'
# OR
$ ip addr show enp0s25 | grep inet -m 1 | awk '{ print $2, $4 }'
```

[TOP](#content)

### awk

with AWK you can read files
```console
$ awk '{ print }' tutorial.txt

# If the line has 4 words, it will be stored in $1, $2, $3 and $4 respectively.
# Also, \$0 represents the whole line.

$ awk '{ print \$1 }' tutorial.txt

# awk split by empty space by default, use -F "[char]" to split exp. -F "|"

$ awk -F "|" '{ print $2 }' tutorial.txt
# Format output (NR - add line number, \t - add tab indentation)
$ awk 'BEGIN { print "Header\n-----------------"} {print NR,"data: \t"$2} END {print "#################"}' tutorial.txt

# Create table ( OFS - separates the fields with char, ORS - separates the output lines)
$ awk 'BEGIN { OFS="|" ; ORS="\n-----------------\n"; print "Table"}
             { total+=$2 }{print NR,"data: \t"\$2} 
       END   { print "Records number: " NR; print "This is total: " total}' tutorial.txt
```

[TOP](#content)

### cp

```console
$ apt-get install xclip
```

Use command

```console
# to copy
$  echo foo | xclip -selection c
# to paste
$  echo foo | xclip -selection c -o
```

OR create aliases:

In ~/.bash_aliases, add:

alias copy="xclip -selection c" <br/>
alias paste="xclip -selection c -o"

```console
$ cd ~
# if the file does not exists create a new one
$ touch .bash_aliases
$ echo 'alias copy="xclip -selection c"' >> .bash_aliases
$ echo 'alias paste="xclip -selection c -o"' >> .bash_aliases
# check all aliases
$ alias

$ echo foo | copy
$ paste
```

[TOP](#content)

### find

```console
# Find all files that are .err in specific folder 
$ find /home/username/ -name "*.err"
# in current directory
$ find -name "*.err"
# Find files that are changed in the last 7 days (change the number to increase/decrease the number of days)
$ find / -name "\*.txt" -mtime -7
$ find -name "*.txt" -mtime -7
```

[TOP](#content)

### edit

```console
# Make directory
$ mkdir directory_name

# Sudo command make directory as root user
$ sudo mkdir directory_name

# Delete directory
$ rm -r directory_name

# Create file
$ touch file_name.ext

# Delete file
$ rm file_name.ext
```


[TOP](#content)

### permission

[Documentation](https://www.linode.com/docs/tools-reference/tools/modify-file-permissions-with-chmod/)

```console
# change file or folder user ( $USER:$GROUP => ed:ed, -R - do it recursively to all files inside)
$ sudo chown -R $USER:$GROUP file.ext
$ sudo chown -R $USER:$GROUP directory

# change mode for file directory
$ chmod 700 file.ext
$ chmod 700 directory

$ ls -la
# This is output example
# -rw-rw-r--   ed ed  
# drwxrwxr-x   ed ed

```

| File type    | User  | Group  | Global |
| -------------|:-----:|:------:| ------:|
| d Directory  | rwx   | r-x    | rwx    |
| - Reg file   | rw-   | rwx    | rwx    |
| l Symb Link  | -w-   | rwx    | rwx    |

```console
$ chmod 700 file.ext
# User = 7, Group = 0, Global = 0
```

| Octal | permission | 
| ------|-----------:|
| 0     | ---        |
| 1     | --x        |
| 2     | -w-        |
| 3     | -wx        |
| 4     | r--        |
| 5     | r-x        |
| 6     | rw-        |
| 7     | rwx        |

[TOP](#content)

### write

Adding text using **echo >** write to file and overwrite, **>>** append text to file

```console
# write
$ echo 'Some text to write to file' >> file.ext
# read
$ cat file.txt
```

Read the content of the file and save to another file
This will find in the current directory all files and then will execute grep command
that will read file content and search lines with test and copy that to clipboard
the copy command is set in [Copy/Paste](#cp) part

```console
$ find . -type f -exec grep "test" '{}' \; | copy

# Past to other file in one line
$ echo $(paste) >> file.ext

# OR in same line order
$ paste >> file.ext

TASK: read content of test.txt | convert to base64 | copy that | and append to file test_sudo.txt
$ cat test.txt | base64 | copy | paste >> test_sudo.txt

# Read using sed command

# Read lines from test.txt that only have errors in
$ sed -n '/errors/p' test.txt

# Read only lines that does not contain specific word (errors)
$ sed '/errors/d' test.txt

# Use regex ^ - starts with .* - can have anything between \$ - end with (add char in front)
# '/^er.*s\$/ - starts with e, followed by r, then can be anything between and finish with s
$ sed -n '/^er.*s\$/p' test.txt

# Replace words 
$ sed 's/errors/err/g' test.txt
# you can also chain | copy and in new line execute paste > file.ext to save new replaced content
$ sed 's/errors/err/g' test.txt | copy
$ paste > test.txt

# Prepends something to lines in file => chain | copy and in new line execute paste > file.ext to save
$ sed 's/^/something /' file.ext

# Append to end
$ sed 's/\$/something/'

```

[TOP](#content)

### grep

```console
# -o - show only matching pattern -w mach exactly the word that is passed
$ cat test.txt | grep -o -w 'dsada'

# Search more then one word
$ cat test.txt | egrep -o -w 'dsada|test'
```

[TOP](#content)

### diff

Check difference between two files

```console
$ diff file.ext file2.ext
$ diff file.ext file2.ext | grep "<" | awk '{$1= ""; print NR,$0 }'
```

[TOP](#content)


## BASH SCRIPTING

### bash

Create a simple bash script

- bash script are with extension **.sh**
- must start with **#!/bin/bash**
- run with **bash name.sh** or with **./name.sh** (the second one depends on permissions)

```console
$ touch info.sh
# copy lines below
# paste is command from part [Copy/Paste](#cp)
$ paste >> info.sh

# run command
$ bash info.sh

# Execute in debug mode
$ bash -x info.sh

# to execute terminal command in bash script use "$(command)" like "$(ls)"
```

```console
#!/bin/bash
# This script shows basic info about user current time ...
# check in scripts/info.sh

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
```

[TOP](#content)

### variables

```console
$ touch variables.sh
# copy lines below
# paste is command from part [Copy/Paste](#cp)
$ paste >> variables.sh

# run command
$ bash variables.sh var_one var_two $USER 
```

```console
#!/bin/bash
# This script reads 3 positional parameters and prints them out.

POSPAR1="$1" # this is what you pass as var_one

echo "Print all $@"
echo "$POSPAR1 is the first positional parameter, $1."
echo "$2 is the second positional parameter, $2."
echo "$3 is the third positional parameter, $3."
printf "The total number of positional parameters is $#. \n"
```

[TOP](#content)

### if

IF statement in bash

syntax:
```console
if [[ <some test> ]]; then
  <commands>
# negation  
elif ! [[ <some test> ]]; then
  <commands>
else
  <commands>
fi
```

some conditions:

```console
if [[ -a FILE ]] # True if FILE exists.
if [[ -b FILE ]] # True if FILE exists and is a block-special file.
if [[ -c FILE ]] # True if FILE exists and is a character-special file.
if [[ -d FILE ]] # True if FILE exists and is a directory.
if [[ -e FILE ]] # True if FILE exists.
if [[ -f FILE ]] # True if FILE exists and is a regular file.
if [[ -g FILE ]] # True if FILE exists and its SGID bit is set.
if [[ -h FILE ]] # True if FILE exists and is a symbolic link.
if [[ -k FILE ]] # True if FILE exists and its sticky bit is set.
if [[ -p FILE ]] # True if FILE exists and is a named pipe (FIFO).
if [[ -r FILE ]] # True if FILE exists and is readable.
if [[ -s FILE ]] # True if FILE exists and has a size greater than zero.
if [[ -t FD ]] # True if file descriptor FD is open and refers to a terminal.
if [[ -u FILE ]] # True if FILE exists and its SUID (set user ID) bit is set.
if [[ -w FILE ]] # True if FILE exists and is writable.
if [[ -x FILE ]] # True if FILE exists and is executable.
if [[ -O FILE ]] # True if FILE exists and is owned by the effective user ID.
if [[ -G FILE ]] # True if FILE exists and is owned by the effective group ID.
if [[ -L FILE ]] # True if FILE exists and is a symbolic link.
if [[ -N FILE ]] # True if FILE exists and has been modified since it was last read.
if [[ -S FILE ]] # True if FILE exists and is a socket.
if [[ FILE1 -nt FILE2 ]] # True if FILE1 has been changed more recently than FILE2, or if FILE1 exists and FILE2 does not.
if [[ FILE1 -ot FILE2 ]] # True if FILE1 is older than FILE2, or is FILE2 exists and FILE1 does not.
if [[ FILE1 -ef FILE2 ]] # True if FILE1 and FILE2 refer to the same device and inode numbers.
if [[ -o OPTIONNAME ]] # True if shell option "OPTIONNAME" is enabled.
if [[ -z STRING ]] # True of the length if "STRING" is zero.
if [[ -n STRING ]] # or if [[ STRING ]] # True if the length of "STRING" is non-zero.
if [[ STRING1 == STRING2 ]] # True if the strings are equal. "=" may be used instead of "==" for strict POSIX compliance.
if [[ STRING1 != STRING2 ]] # True if the strings are not equal.
if [[ STRING1 < STRING2 ]] # True if "STRING1" sorts before "STRING2" lexicographically in the current locale.
if [[ STRING1 > STRING2 ]] # True if "STRING1" sorts after "STRING2" lexicographically in the current locale.
if [[ ARG1 OP ARG2 ]] # "OP" is one of -eq, -ne, -lt, -le, -gt or -ge.
   These arithmetic binary operators return true if "ARG1" is equal to, not equal to, less than, less than or equal to,
   greater than, or greater than or equal to "ARG2", respectively. "ARG1" and "ARG2" are integers
```

Example:

```console
#!/bin/bash
# Basic if statement
# run: bash if_basic.sh 101

if [[ $1 -gt 100 ]]; then
   echo Hey that\'s a large number.
   pwd
fi

date
```
   
Example 2:

```console
#!/bin/bash
# This script gives information about a file.
# run: bash if_file_info.sh if_basic.sh
FILENAME="$1"

echo "Properties for $FILENAME:"

if [[ -f $FILENAME ]]; then
  echo "Size is $(ls -lh $FILENAME | awk '{ print $5 }')"
  echo "Type is $(file $FILENAME | cut -d":" -f2 -)"
  echo "Inode number is $(ls -i $FILENAME | cut -d" " -f1 -)"
  echo "$(df -h $FILENAME | grep -v Mounted | awk '{ print "On",$1", which is mounted as the", $6,"partition."}')"
else
   echo "File does not exist."
fi
```
[TOP](#content)

### case

```console
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
```

[TOP](#content)


### for

```console
#!/bin/bash
# Basic for loop
# file name for.sh
# run: bash for.sh

# String
cities="Tokyo London Paris Dubai Mumbai"

for city in $cities; do
  echo "CITY: $city"
done

# Array
FRUITS=('Apple' 'Mango' 'Strawberry' 'Orange' 'Banana')

for item in "${FRUITS[@]}"; do
  echo "FRUIT: $item"
done

# Range
for i in {5..1}; do
  echo "COUNT: $i"
done

# Normal loop
for (( i=0; i<5; i++ )); do  
  echo "COUNT: $i"
done
```

[TOP](#content)

### while

```console
#!/bin/bash
# This script just echo test 4 times.
# file name while.sh
# run: bash while.sh
    
i=0
while [ $i -lt 4 ]; do
  echo "Test $i"
  i=$[$i+1]
  # or
  # ((i++))
done
```

[TOP](#content)

### scripts

Frst script:

```console
#!/bin/bash
# This script returns exit status
# file name: outside_script.sh

if [[ $data -eq 1 ]]; then
  echo "You pass option 1"
  exit 1
elif [[ $data -eq 2 ]]; then
  echo "You pass option 2"
  exit 2
elif [[ $data -eq 3 ]]; then
  echo "You pass option 3"
  exit 3
else
  echo "You pass option $data"
  exit $data  
fi

```
   
Second script:

```console
#!/bin/bash
# This script acts upon the exit status given by other
# file name: inner_script.sh
# run: bash inner_script.sh 54

# export variable to use in other script
export data="$1"

# Import other script
feed="./outside_script.sh"

# Execute other script
$feed $data

# $? is returned form exit command of first script

case $? in

  [1-2]*)
    echo "Exit status of other script should be 1 or 2: $?"
  ;; 
  3)
    echo "Exit status of other script should be 3: $?"
  ;;
  *)
    echo "All other exit status: $?"
  ;;
esac

```

[TOP](#content)

### input

```console
#!/bin/bash
# This script will test if you have given a leap year or not.
# file name input_leap.sh
# run bash input_leap.sh

echo "Type the year that you want to check (4 digits), followed by [ENTER]:"

# This will store user input to variable year
read year

if (( ("$year" % 400) == "0" )) || (( ("$year" % 4 == "0") && ("$year" % 100 !="0") )); then
  echo "$year is a leap year."
else
  echo "This is not a leap year."
fi
```

```console
#!/bin/bash
# This is a program that keeps your address book up to date.
# file name input_address.sh
# run: bash input_address.sh

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

```

```console
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

echo "---------------------"

for data in $multi_liner; do
  echo "Separate by space: $data"
done

echo "---------------------"

for data in $one_liner; do
  echo "Separate by space: $data"
done

echo "###### END ######"
```

[TOP](#content)

### chron

```console
crontab documentation

# to run a job every month, put * in the Month field.
# 0 0 1 * * /usr/bin/foo  -> this will execute every first day in month

    * * * * * "command to be executed"
    - - - - -
    | | | | |
    | | | | ----- Day of week (0 - 7) (Sunday=0 or 7)
    | | | ------- Month (1 - 12)
    | | --------- Day of month (1 - 31)
    | ----------- Hour (0 - 23)
    ------------- Minute (0 - 59)
```
```console
# First create a bash file that will be executed by chron job
$ touch cron_script.sh

# create an file that will be cron job
$ touch cron_job

# This will create an cron job to execute every minute (change with 0 0 1 * * to execute every first in month)
$ echo "* * * * * $(pwd)/cron_script.sh" > cron_job

# create an cron job from specific file
$ crontab cron_job

# list all cron jobs
$ crontab -l
    
# to remove crontab
$ crontab -r
```

```console
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
```

[TOP](#content)

### function

```console
#!/bin/bash
# This script show how to work with functions
# file name: function.sh

list_length () {
  echo "~~~~~ 1 ~~~~~~~"
  echo "$1"
  echo "~~~~~ 2 ~~~~~~~"
  echo "$2"
  echo "~~~~~ 3 ~~~~~~~"
  echo "$3"
  echo "~~~~~ 4 ~~~~~~~"
  echo "$4"
  echo "***** All ******"
  #	All arguments as separate words
  echo "$@"
  echo "***** Args num ******"
  # Number of arguments
  echo "$#"
}

LISTA="$(ls)"
list_length "var_1" "var_2" "var_3" "var_4" "$LISTA"
```

```console
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
  [ $? -eq 2 ] && echo -e "Please provide an number not an string '$1'!" && exit 1
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

```

[TOP](#content)

### var

```console
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
```

[TOP](#content)

### redirect

```console
# This is ls command will write to /dev/null - This is garbage
# 2>&1 2- are errors and that will go to standard output and in this case that is /dev/null

# ls -la > /dev/null 2>&1
# Better example
# ls file.ext > my_std.log 2>my_error.log
# $?


# Read how remove pictures form server chapter 9.3.2
# http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html#chap_08
```

[TOP](#content)

### myscripts

```console
#!/bin/bash
# This script converts all file names containing upper case characters into file# names containing only lower cases.

LIST="$(ls)"
for name in "$LIST"; do
  if [[ "$name" != _[[:upper:]]_ ]]; then
    continue
  fi

  ORIG="$name"
  NEW=`echo $name | tr 'A-Z' 'a-z'`
  mv "$ORIG" "$NEW"
  echo "new name for $ORIG is $NEW"
done
```

[TOP](#content)

### split

```console
#!/bin/bash
# This script read an file set header split text for 50 lines and create an individual files
# attributes: file to read from, number of lines to split

GREEN="\033[0;32m"
CYAN="\033[0;36m"
RED="\033[0;31m"
NC="\033[0m" # No Color

echo -e "${GREEN}#########################################################################"
echo -e "${GREEN}# ${CYAN}Use this function to split one file into multiple files.              ${GREEN}#"
echo -e "${GREEN}# ${CYAN}It append the first line to every file like the header and            ${GREEN}#"
echo -e "${GREEN}# ${CYAN}append rest split by line numbers that you can pass as an argument.   ${GREEN}#"
echo -e "${GREEN}# ${CYAN}By default is set to 50 lines.                                        ${GREEN}#"
echo -e "${GREEN}# ${CYAN}Script execution ex. function.sh file.ext 10                          ${GREEN}#"
echo -e "${GREEN}#########################################################################${NC}"
echo ""
echo ""

isInteger () {
  test "$1" -ge 0 2>/dev/null
  [ $? -eq 2 ] && echo -e "${RED}Please provide an number of lines not an string '$1'!${NC}" && exit 1
}

# check if file parameter is set
[ -z "$1" ] && echo -e "${RED}Please provide a file name! For ex. 'scriptname.sh file_name.ext'${NC}" && exit 1

FILE=$1

# Check if file that is passed exist in folder
[ ! -f "$FILE" ] && echo -e "${RED}This file does not exist!${NC}" && exit 1
    
isInteger $2

SPLIT_NUM=$2

# Check if other parameter is set, if not set to 49
[ -z "$2" ] && SPLIT_NUM=49

# Create an temporary file
TMPFILE="test_tmp.txt"

# Create file numbers
FILE_NUM=0

# Fetch header as two first lines
header="$(head -n 2 "$FILE")"

# Remove first two lines from file
tail -n +3 "$FILE" > "$TMPFILE"

# Add header to first file
echo $header >> "split_$FILE_NUM.txt"

# Add empty line
echo " " >> "splited_$FILE_NUM.txt"

# use to count lines
start=0

while IFS= read -r line; do
  ((start++))
  # Create and input lines to file
  echo $line >> "split_$FILE_NUM.txt"
  if [ $start -gt $SPLIT_NUM ]; then
    ((FILE_NUM++))
    start=0
    echo $header >> "split_$FILE_NUM.txt"
    # Add empty line
    echo " " >> "split_$FILE_NUM.txt"
  fi
done < "$TMPFILE"

# remove tmpfile
rm $TMPFILE

echo -e "${CYAN} $FILE_NUM was successfully created! Check in folder new files named split_n.txt. :) ${NC}"

```

[TOP](#content) 

### terminal

```console
#!/bin/bash
# This function check the current terminal that is in use bxy user

which_term() {
  term=$(ps -p $(ps -p $$ -o ppid=) -o args=);
  found=0;
  case $term in
    *gnome-terminal*)
      found=1
      echo "gnome-terminal " $(dpkg -l gnome-terminal | awk '/^ii/{print $3}')
    ;;
    *lxterminal*)
      found=1
      echo "lxterminal " $(dpkg -l lxterminal | awk '/^ii/{print $3}')
    ;;
    rxvt*)
      found=1
      echo "rxvt " $(dpkg -l rxvt | awk '/^ii/{print $3}')
    ;;
    ##  Try and guess for any others
    *)
      for v in '-version' '--version' '-V' '-v'; do
        $term "$v" &>/dev/null && eval $term $v && found=1 && break
      done
    ;;
  esac
  ## If none of the version arguments worked, try and get the package version
  [ $found -eq 0 ] && echo "$term " $(dpkg -l $term | awk '/^ii/{print $3}')
}

which_term
```

[TOP](#content)

### color

```console
#!/bin/bash
# This script show how to work with colors in terminal

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

GREEN="\033[0;32m"
CYAN="\033[0;36m"
RED="\033[0;31m"
NC="\033[0m" # No Color

echo -e "${CYAN}This line wiil be in color cyne.${NC} NC make this libne white"
echo "This line will be also white"
echo -e "${GREEN}This line will be green"
echo "This line will be also green"
```

[TOP](#content)

### xdotool 

[Key Codes](https://gitlab.com/cunidev/gestures/-/wikis/xdotool-list-of-key-codes)

```console
#!/bin/bash
# This script show how to work with xdotool 
clear

# open VS code
code ./Desktop/

# open Firefox and some sites
sleep 2
firefox www.test.com

if ! type xdotool > /dev/null; then
  echo "Installing xdotool to emulate keyboard commands!"
  sudo apt-get install xdotool
else
  echo "xdotool is already installed. Now you can emulate keyboard commands!"
fi

# xdotool type setxkbmap de
# This open new tab
xdotool key ctrl+shift+t
# This type in terminal
xdotool type "google-chrome --disable-web-security --user-data-dir"
# Press enter
xdotool key KP_Enter
echo "Google chrome in secure mode is running!"
# Go to previous tab
xdotool key ctrl+Page_Up
```

[TOP](#content)

### auto

```console
#!/bin/bash
# SCRIPT FOR WORK STARTUP AUTOMATIZATION

# Check if app armor is runing
sudo apparmor_status > /dev/null
if ! [[ $? -eq 0 ]]; then
    # Run to start app armor
    systemctl start apparmor

    if ! [[ $? -eq 0 ]]; then
        echo "Please activate AppArmor before the start!"
        exit 1
    fi
fi
clear

# install xdotool
if ! type xdotool > /dev/null; then
    echo "Instaling xdotool to emulate keyboard commands!"
    sudo apt-get install xdotool
else
    echo "xdotool is already instaled. Now you can emulate keyboard commands!"
fi

ACTIV_TERMINAL=$(xdotool getactivewindow)

# CD to Desktop TODO fix relative path here
cd Desktop/

# List all folders in Desktop (only folders)
LIST_OF_FOLDERS="$(ls -d */)"

# make an pause and go back one dir
sleep 1
cd ..

# Convert to array
ARRAY_OF_FOLDERS=($LIST_OF_FOLDERS)
# List all items from array
# echo " ${ARRAY_OF_FOLDERS[@]}"
# list specific elelent
# echo ${ARRAY_OF_FOLDERS[1]}

i=0
for name in $LIST_OF_FOLDERS; do
echo "$i. $name"
((i++))
done

echo "Please input file number: "
read FILE_TO_OPEN

if [[ $FILE_TO_OPEN -lt 0 ]] || [[ $FILE_TO_OPEN -gt $i-1 ]]; then
    echo "Please do not be stupid! Choose a number in the range from 0 to $i"
    exit 1
fi

FOLDER_TO_OPEN=${ARRAY_OF_FOLDERS[$FILE_TO_OPEN]}
DIR_PATH="./Desktop/$FOLDER_TO_OPEN"

# open VS code
code $DIR_PATH
echo "Project is open in VS Code!"
sleep 3
# open Firefox and some sites
sleep 3
firefox some_url
sleep 3
firefox some_url
sleep 3
firefox some_url
sleep 3

echo "All sites are open!"

# set focus to terminal to be activ window
xdotool windowactivate --sync $ACTIV_TERMINAL

# https://gitlab.com/cunidev/gestures/-/wikis/xdotool-list-of-key-codes
# xdotool type setxkbmap de
# open new tab in terminal
xdotool key ctrl+shift+t
# type in new tab in terminal
xdotool type "google-chrome --disable-web-security --user-data-dir"
# Press enter
xdotool key KP_Enter
echo "Google chrome in secure mode is running!"
# go back to previus tab
xdotool key ctrl+Page_Up

sleep 2
# set focus to terminal to be activ window
xdotool windowactivate --sync $ACTIV_TERMINAL

# To open pycharm
xdotool key ctrl+shift+t
# type in new tab in terminal
xdotool type "pycharm-professional $DIR_PATH"
# Press enter
xdotool key KP_Enter
echo "Opening your project in PyCharm!"
# go back to previus tab
xdotool key ctrl+Page_Down

sleep 2
# set focus to terminal to be activ window
xdotool windowactivate --sync $ACTIV_TERMINAL

# To open pycharm
xdotool key ctrl+shift+t
# type in new tab in terminal
CLIENT="${DIR_PATH}client/"
xdotool type "cd $CLIENT"
# Press enter
xdotool key KP_Enter
xdotool type "npm start"
xdotool key KP_Enter

echo "Running Client from project!"
# go back to previus tab
xdotool key ctrl+Page_Down

sleep 3

echo "All command are executed. Have a nice working day!"
```

[TOP](#content)

### clean

SCRIPT FOR CLEAN BUILD APP

```console
#!/bin/bash
# Script to fresh install npm packages and cordova platforms
# call: bash clean.sh [true] # true is optional to invoke cordova platform setup

# Helper function to clean npm module
clean_npm () {
    printf "Cleaning npm module and packages... \n"
    rm -rf node_modules
    printf "Cleaning cache... \n"
    npm cache clear --force
    printf "Installing npm packages... \n"
    npm install
}

# helper function to add platforms
setup_platforms () {
    printf "Removing cordova platforms... \n"
    cordova platform rm ios
    cordova platform rm android
    sleep 2
    printf "Adding cordova platforms... \n"
    cordova platform add ios
    cordova platform add android

    # printf "Preparing cordova platforms... \n"
    # cordova prepare ios
    # cordova prepare android
}

# first clean cordova file
cd cordova
clean_npm

# setup cordova platforms if need
if [[ "$1" == true ]] ; then
    setup_platforms
fi

sleep 2
cd ..
clean_npm

npm start
```
[TOP](#content)
