#!/bin/zsh

source $HOME/.antigen/antigen.zsh
    
# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle nvm
antigen bundle git
antigen bundle pyenv

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

export EDITOR=nvim

alias sudo='sudo '
alias cd='cd '
alias v='nvim'
alias pm='trizen'

# *rc
alias zshrc='v ~/.zshrc'
alias vimrc='v ~/.config/nvim/init.vim'
alias dunstrc='v ~/.config/dunst/dunstrc'
