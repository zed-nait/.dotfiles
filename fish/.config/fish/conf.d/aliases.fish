alias s!="sudo"
alias c="clear"
alias g="git"
alias e="exit"
alias v="nvim"
alias r="ranger"

switch (uname)
    case Darwin
        alias lsblk="diskutil list"
end

# shell aliases
alias mkdir="mkdir -p"
alias mv="mv -i"
alias rm="rm -iR"
alias df="df -h"
alias du="du -h"

# youtube-dl
alias yt="youtube-dl"

# misc.
alias ipp="curl ipinfo.io/ip"
alias ww="curl wttr.in/Samara\?format=3"
alias wwl="curl wttr.in/Samara"

alias ixio="curl -F 'f:1=<-' ix.io"
