#!/bin/zsh

source /home/zed/.config/antigen/antigen.zsh
    
# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle nvm
antigen bundle pyenv
antigen bundle git

# Load the theme
antigen theme avit 

# Tell antigen that you're done
antigen apply

export HISTSIZE=9999
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

setopt hist_ignore_all_dups

setopt autocd
setopt extendedglob


#if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
#    exec startx
#fi

export EDITOR=nvim

alias sudo='sudo '
alias cd='cd '
alias sv='systemctl'
alias v='nvim'
alias pm='trizen'

# *rc
alias zshrc='v ~/.zshrc'
alias vimrc='v ~/.config/nvim/init.vim'
alias polybarrc='v ~/.config/polybar/config'
alias dunstrc='v ~/.config/dunst/dunstrc'
alias bspwmrc='v ~/.config/bspwm/bspwmrc'
alias sxhkdrc='v ~/.config/sxhkd/sxhkdrc'
# alias rangerrc='v ~/.config/ranger/rc.conf'
