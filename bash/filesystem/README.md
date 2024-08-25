$ printf "%s\n" "${BASH_VERSINFO[*]}"
4 3 30 1 release i686-pc-linux-gnuoldld
$ printf "%s\n" "${BASH_VERSINFO[@]}"
4
3
30
1
release
i686-pc-linux-gnu

$ printf "%s\n" "${#BASH_VERSINFO[*]}"
6

$ province=( Quebec Ontario Manitoba )
$ printf "%s\n" "${province[@]}"
Quebec
Ontario
Manitoba

declare -i num=5  # Declares an integer variable num and assigns it the value 5
declare -a arr   # Declares an indexed array variable arr


shopt -s nocaseglob  # Sets the nocaseglob option, making filename expansion case-insensitive

unset num  # Removes the variable num entirely

case $1 in
"" | *[!0-9.]* | *[!0-9]) return 1 ;;
esac


"" | *[!0-9.]* | *[!0-9]): This line checks three conditions separated by | (OR).
"": Matches an empty string.
*[!0-9.]*: Matches any string that contains characters other than digits (0-9) or dots (.).
*[!0-9]): Matches any string that ends with a character other than a digit (0-9).


$ echo touchdown | tr 'a-z' 'A-Z'
TOUCHDOWN


to_upper()
case $1 in
a*) _UPR=A ;; b*) _UPR=B ;; c*) _UPR=C ;; d*) _UPR=D ;;
e*) _UPR=E ;; f*) _UPR=F ;; g*) _UPR=G ;; h*) _UPR=H ;;
i*) _UPR=I ;; j*) _UPR=J ;; k*) _UPR=K ;; l*) _UPR=L ;;
m*) _UPR=M ;; n*) _UPR=N ;; o*) _UPR=O ;; p*) _UPR=P ;;
q*) _UPR=Q ;; r*) _UPR=R ;; s*) _UPR=S ;; t*) _UPR=T ;;
u*) _UPR=U ;; v*) _UPR=V ;; w*) _UPR=W ;; x*) _UPR=X ;;
y*) _UPR=Y ;; z*) _UPR=Z ;; *) _UPR=${1%${1#?}} ;;
esac


If the nullglob option is set and there is no match, an empty string is returned:
$ shopt -s nullglob

failglob
If the failglob option is set and no files match a wildcard pattern, an error message is printed:

$ shopt -s failglob


$ sa .* | wc -l ## dot files; includes . and ..
62

$ sa * | wc -l
 ## not dot files
420
$ shopt -s dotglob
$ printf "%s\n" * | wc -l
480

?(pattern-list)
This pattern-list matches zero or one occurrence of the given patterns.
*(pattern-list)
This is like the previous form, but it matches zero or more occurrences of the given patterns
@(pattern-list)
The pattern @(john|paul)2 matches files that have a single instance of either pattern
+(pattern-list)
The pattern +(john|paul)2 matches files that begin with one or more instances
nocaseglob
When the nocaseglob option is set, lowercase letters match uppercase letters,
•
 globstar: Searches file hierarchy for matching files

 -a, Read Words into an Array
 > read -a array

 Sanity checking is testing input for the correct type and a reasonable value.

 PS1
The value of this parameter is expanded (see “Prompting” in the bash man page) and used as the primary
prompt string. The default value is "\s-\v\$ ".
PS2
The value of this parameter is expanded as with PS1 and used as the secondary prompt string.
The default is "> ".
PS3
The value of this parameter is used as the prompt for the select command (see “SHELL GRAMMAR” earlier).
PS4
The value of this parameter is expanded as with PS1, and the value is printed before each command bash
displays during an execution trace. The first character of PS4 is replicated multiple times, as necessary, to
indicate multiple levels of indirection. The defauسیبlt is "+ ".