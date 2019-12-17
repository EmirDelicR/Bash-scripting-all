### SOME TERMINAL COMMANDS - MOST USED

#### content

- [Intro](#intro) <br/>
- [Find IP Address](#ip) <br/>
- [AWK command](#awk) <br/>
- [Find IP Address](#ip) <br/>
- [Find IP Address](#ip) <br/>
- [Find IP Address](#ip) <br/>


- [Django with REST](#django)
  - [URLs](#urls)
  - [Create view](#view)
  
- [Client setup](#client)
- [Links](#links)

### intro

HINT 

- use: **yelp man:command** OR **man command** OR **command -h** to read command instruction

- run: **bash command.sh** OR **./command.sh** (For this one set file to be executable)

### ip

```console
$ ip addr show enp0s25 | grep inet | head -1 | awk '{ print $2, $4 }'
# OR
$ ip addr show enp0s25 | grep inet -m 1 | awk '{ print $2, $4 }'
```

### awk

with AWK you can read files
```console
$ awk '{ print }' tutorial.txt

# If the line has 4 words, it will be stored in $1, $2, $3 and $4 respectively.
# Also, \$0 represents the whole line.

$ awk '{ print \$1 }' tutorial.txt
```

