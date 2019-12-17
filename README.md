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
  
  
  - [Create view](#view)
  
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
$ touch test.sh
# copy lines below
# paste is command from part [Copy/Paste](#cp)
$ paste >> test.sh

# run command
$ bash test.sh

# Execute in debug mode
$ bash -x test.sh

# to execute terminal command in bash script use "$(command)" like "$(ls)"
```

```text
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



[TOP](#content)
