### use cases:monitoring, data backup, alert system, user  administration, security auditing  and many more

## one line  and  order base size
```bash
alias lt='ls -hSF --size -1'
```



## 
```bash
cat /etc/shells
```
##
```bash
chsh -s /bin/bash

chsh -s /bin/sh <user>
```
# user add   with  home  and email spool
```bash
useradd -m <userName> 

gpasswd -a <userName> <groupName> - adds the user to the group.
gpasswd -d <userName> <groupName> - removes the user from the group.
gpasswd -M <userName1>,<userName2>,<userName3> <groupName> - adds multiple users to the group and removes the existing ones of the group.

find <dirName> -name <fileName> - finds the mentioned file in the directory.

scp - Securely Copy Files: Copy files between local and remote systems using SSH.
Example: scp file.txt user@remote_host:/path

rsync - Remote Sync: Synchronize files and directories between systems.
Example: rsync -avz local_folder/ user@remote_host:remote_folder/

nc — Simple tcp proxy, network daemon testing

Example: nc -vz google.com 443

dig <domainName> - Shows DNS information of the domain.

Example: dig medium.com

netstat -antp- shows all tcp open ports (-a all, t-tcp, n-active, p protocol).

ps -ef - Displays all the processes of the system.

tar -cvf <fileName> <directory> - creates the tar file with the fileName for the directory mentioned (-c create, -v verbose, -f output file name).
tar -xvf <sourceTarFileName> -C <destinationDir> - puts the extracted files into the destination directory (-x extract, -v verbose, -f source tar file name, -C change the folder and download to destination dir).

apt search <packageName> - searches and shows the list of packages.

cd - - changes to the last working directory.

awk - A powerful programming language for text processing.

stat <fileName/dirName> - shows detailed information about the file or directory.

cut -d: -f1 /etc/passwd

```
```bash
echo ~+ # same as "echo $PWD"
echo ~- # same as "echo $OLDPWD"

# If `username` is not set
echo ${username:-$(whoami)}
# Output: The result of `whoami` command

# If `username` is set
username="John"
echo ${username:-$(whoami)}
# Output: John


# If `path` is set
path="/some/path"
path=${path:+/some/alternative/path}
echo $path
# Output: /some/alternative/path

# If `path` is not set
unset path
path=${path:+/some/alternative/path}
echo $path
# Output: (empty)

```



last_arg=${!#}
echo $last_arg
# ./script.sh 1 2 3 4
# 4

##
```bash
vim  ~/.bashrc #he . bashrc file is executed every time you open a new terminal window or start a new Bash shell, the . bash_profile file is executed when you log in to your system

alias now='date +%F\ %T'
export PATH='PATH:~/scripts'
```
## multiline comment
```bash
#!/bin/bash

: '
This is a multi-line comment using a colon (:) followed by a single-quote ('), 
and ending with another single-quote ('). Write your comment here.
'

<<COMMENT
This is another way to create a multi-line comment using a here document.
Simply start with "<<COMMENT" and end with "COMMENT". Write your comment here.
COMMENT
```
## adding numberline to vim or vimrc
```bash
set nu #@vimrc
```
## for seeing var and set
###  env and printenv essentially provide the same output, showing only the environment variables and their values. On the other hand, set provides a more comprehensive listing that includes environment variables, shell variables, and other shell attribute
```bash
set
env
printenv #It functions similarly to "env" but focuses solely on displaying the values without any additional information.
```
## PATH
```bash
cat /etc/environment
# PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
```
## declare command is used to declare variables
```bash
declare variable_name="value"
declare -i num_var=10      # integer variable
declare -x ENV_VAR="myvalue" # expose
declare -r READ_ONLY_VAR="constant value" # read_only
```

## get an input
```bash
read var_name
read -p "enter name:" name
read -s # silent mode that don't show anything in screen
```
## 
```bash
$0 #name of script
```
## {} for vars and have feature like appending
```bash
name="John"
echo $name  # see below
echo "$name"
echo "${name}!"
wget http://docs.example.com/documentation/slides_part{1,2,3,4,5,6}.html
```
## $@ and $* must be quoted in order to perform as described. Otherwise, they do exactly the same thing (arguments as separate strings)
```bash

$#	Number of arguments
$*	All positional arguments (as a single word)
$@	All positional arguments (as separate strings)
#eg: $@ word splitting is performed and $@ = "$1 $2 $3"
#eg: "$@" word splitting is performed and $@ = "$1 $2 $3"
$_	Last argument of the previous command
$?  most recent foreground command exit status
$$  the process ID of shell
```
## 
```bash

```
## 
```bash
array=(one two three four five six)
echo "${#array[@]}" # => "6"
# Print the number of characters in third element
```
## 
```bash
from=1
to=10
echo {$from..$to} # => {$from..$to}
```

## The set -e option instructs bash to immediately exit if any command [1] has a non-zero exit status
## set -u affects variables. When set, a reference to any variable you haven't previously defined - with the exceptions of $* and $@ - is an error, and causes the program to immediately exit. 
## set -o pipefail This setting prevents errors in a pipeline from being masked. If any command in a pipeline fails, that return code will be used as the return code of the whole pipeline.
```bash
#!/bin/bash
set -euo pipefail
IFS=$'\n\t' #Internal Field Separator
I call this the unofficial bash strict mode. This causes bash to behave in a way that makes many classes of subtle bugs impossible. You'll spend much less time debugging
```
## ${VARNAME:-DEFAULT_VALUE} evals to DEFAULT_VALUE if VARNAME undefined.
## So here, $bar is set to "alpha":
```bash

bar=${foo:-alpha}
```
##  arithmetic expansion.
```bash
$( (COMMAND) )

```
## 
```bash
name="John"
echo "${name}"
echo "${name/J/j}"    #=> "john" (substitution)

# substitute all occurances of word "cool with "awesome"
echo ${str//cool/awesome}

echo "${name:0:2}"    #=> "Jo" (slicing)
echo "${name::2}"     #=> "Jo" (slicing)
echo "${name::-1}"    #=> "Joh" (slicing)
echo "${name:(-1)}"   #=> "n" (slicing from right)
echo "${name:(-2):1}" #=> "h" (slicing from right)
echo "${food:-Cake}"  #=> $food or "Cake"
```
## substitution
```bash
${foo%suffix}	Remove suffix
${foo#prefix}	Remove prefix
${foo%%suffix}	Remove long suffix
${foo/%suffix}	Remove long suffix
${foo##prefix}	Remove long prefix
${foo/#prefix}	Remove long prefix
${foo/from/to}	Replace first match
${foo//from/to}	Replace all
${foo/%from/to}	Replace suffix
${foo/#from/to}	Replace prefix
```
## length
```bash
${#foo}	Length of $foo
```
## Manipulation
```bash
str="HELLO WORLD!"
echo "${str,}"   #=> "hELLO WORLD!" (lowercase 1st letter)
echo "${str,,}"  #=> "hello world!" (all lowercase)

str="hello world!"
echo "${str^}"   #=> "Hello world!" (uppercase 1st letter)
echo "${str^^}"  #=> "HELLO WORLD!" (all uppercase)
```
## 
```bash
man test #-z -f ,... eg [[ -z  ]]
```
VSZ: This field tells us how much virtual memory the process uses. -->ps auwwx

The result is that it's not visible in the jobs table for the current
shell. We can achieve something similar by using the **disown** command

renice an already running process. But clearly, we can't
use that to set the niceness level before we start the process. That's why we have the nice
command
NI (niceness field): The process priority that it should have, assigned in user space
(not kernel space) by default or by additional commands (nice and renice). The
lower the number, the higher the priority, on a scale from -20 to +19.

## 
```bash
    file_name=${file%%.*}
    extension=${file##*.}
```
## 
```bash
# set `range` variable to output of for-loop
range=$(for i in seq 1..9; do
  echo -n "$i"
done)
# 123456789
```

##  Trap
```bash
#!/bin/bash

# Script 1: Basic Signal Handling
echo "Script 1: Basic Signal Handling"
trap 'echo "Ctrl+C pressed. Exiting."; exit 1' SIGINT

counter=0
while [ $counter -lt 5 ]; do
    echo "Counter: $counter"
    sleep 1
    ((counter++))
done

# Script 2: Cleanup on Exit
echo -e "\nScript 2: Cleanup on Exit"
cleanup() {
    echo "Cleaning up temporary files..."
    rm -f /tmp/tempfile_$$
}

trap cleanup EXIT

echo "Creating a temporary file..."
touch /tmp/tempfile_$$
echo "Temporary file created. Press Ctrl+C to exit."
sleep 10

# Script 3: Ignoring Signals
echo -e "\nScript 3: Ignoring Signals"
trap '' SIGINT SIGTERM

echo "This script will ignore Ctrl+C and SIGTERM for 10 seconds."
sleep 10
echo "10 seconds passed. Restoring default signal handling."

trap - SIGINT SIGTERM

# Script 4: Reloading Configuration
echo -e "\nScript 4: Reloading Configuration"
config_file="/tmp/config_$$.txt"

create_config() {
    echo "sleep_duration=2" > "$config_file"
}

read_config() {
    source "$config_file"
    echo "Configuration reloaded. Sleep duration: $sleep_duration"
}

trap read_config SIGHUP

create_config
read_config

echo "Running main loop. Use 'kill -SIGHUP $$' to reload config."
counter=0
while [ $counter -lt 5 ]; do
    echo "Iteration $counter"
    sleep "$sleep_duration"
    ((counter++))
done

rm "$config_file"

# Script 5: Handling Multiple Signals
echo -e "\nScript 5: Handling Multiple Signals"
handle_signal() {
    echo "Received signal: $1"
}

trap 'handle_signal SIGINT' SIGINT
trap 'handle_signal SIGTERM' SIGTERM
trap 'handle_signal SIGHUP' SIGHUP

echo "This script will handle multiple signals. Try sending SIGINT, SIGTERM, or SIGHUP."
echo "Process ID: $$"
echo "Run for 30 seconds..."
sleep 30
```
Basic Signal Handling:

Shows how to catch Ctrl+C (SIGINT) and exit gracefully.
Run it and try pressing Ctrl+C before it completes.


Cleanup on Exit:

Demonstrates how to perform cleanup actions when the script exits.
The cleanup function will run whether the script exits normally or is interrupted.


Ignoring Signals:

Shows how to temporarily ignore certain signals.
Try using Ctrl+C while it's running - it won't stop the script.


Reloading Configuration:

Demonstrates how to reload a configuration file using SIGHUP.
While it's running, in another terminal, use kill -SIGHUP <PID> to reload the config.


Handling Multiple Signals:

Shows how to handle different signals with different actions.
While it's running, try sending different signals using kill -SIGINT <PID>, kill -SIGTERM <PID>, etc.

The most common use of the trap command though is to trap the bash-generated psuedo-signal named EXIT. Say, for example, that you have a script that creates a temporary file. Rather than deleting it at each place where you exit your script, you just put a trap command at the start of your script that deletes the file on exit:
```bash
tempfile=/tmp/tmpdata
trap "rm -f $tempfile" EXIT
```
