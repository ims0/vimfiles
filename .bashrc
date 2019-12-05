# .bashrc

#red="\e[31m"
#green="\e[32m"
#yellow="\e[33m"
#blue="\e[34m"
#greblue="\e[36m"
#white="\e[37m"
#usr="$yellow\u"
#tim="\t"
#dir=$greblue"\W"

git-br(){
    local branch=`git symbolic-ref --short -q HEAD 2>/dev/null`
    if [ $branch ];then
        printf "[%s]" $branch;
    fi    
}

# User specific aliases and functions
stty -ixon
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias gis='git st'
alias gia='git add'
alias gif='git diff'
alias cd.='cd ..'
alias cd..='cd ../../'
alias cd...='cd ../../../'
alias gitrev='git review `git symbolic-ref --short -q HEAD 2>/dev/null`'
alias gitpush='git push origin HEAD:refs/for/`git symbolic-ref --short -q HEAD 2>/dev/null`'
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

#PS1='\[\e[32m\][\u@\h \W]#\[\e[m\] '
#PS1="$green[$usr$green@$tim>$dir$green]`$(git-branch-prompt)`\\$\e[m"
#PS1='$(git-branch-prompt)\\$\e[m'
PS1='\e[32m[\e[33m\u\e[32m@\t\e[33m\W\e[32m]\e[36m$(git-br)\e[32;1m\$\e[m'
ulimit -c unlimited



