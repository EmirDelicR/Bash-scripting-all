### SOME TERMINAL COMMANDS - MOST USED

#### content

- [Intro](#intro) <br/>
- [Find IP Address](#ip) <br/>
- [AWK command](#awk) <br/>
- [Copy/Paste](#cp) <br/>
- [Find File](#find) <br/>
- [Create/Delete File/Directory](#edit) <br/>
- [Change permissions and user for directory/file](#permission) <br/>

- [Django with REST](#django)
  - [URLs](#urls)
  - [Create view](#view)
  
- [Client setup](#client)
- [Links](#links)

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

[Dock](https://www.linode.com/docs/tools-reference/tools/modify-file-permissions-with-chmod/)

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




[TOP](#content)


