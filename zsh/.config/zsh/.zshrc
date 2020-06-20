fpath=(~/.dotfiles/zsh/.config/zsh/scripts/zsh-completions/src/ $fpath)

# History
HISTFILE=$ZDOTDIR/histfile
HISTSIZE=20000
SAVEHIST=20000

# Options
# Changing directories
setopt autocd pushdignoredups

# Expansion and globbing
setopt extendedglob globdots nomatch

# History
setopt appendhistory histfcntllock histignorealldups histnofunctions histreduceblanks sharehistory

# Input/Output
setopt correct interactivecomments

# Job control
setopt longlistjobs nohup notify

# Prompting
setopt prompt_subst

# zstyle comletions
zstyle ':completion:*' completer _complete _ignored _match _correct _approximate
zstyle ':completion:*' original false
zstyle ':completion:*:match:*' original only

zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.config/zsh/cache

# Don't complete entry on line multiple times for the following
# commands
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes

# Rehash so that completion doesn't fail when new command added
zstyle ':acceptline:*' rehash true

#Autoloads
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
autoload -Uz compinit
compinit

autoload -U colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr  "*"
zstyle ':vcs_info:git:*' stagedstr  "+"
zstyle ':vcs_info:*' formats "%b%u%c "
zstyle ':vcs_info:*' actionformats "%b|%a%u%c "

zmodload -i zsh/complist


# Additional zfiles
. $ZDOTDIR/aliases
. $ZDOTDIR/functions
. $ZDOTDIR/scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. $ZDOTDIR/scripts/zsh-autosuggestions/zsh-autosuggestions.zsh
. $ZDOTDIR/scripts/zsh-nvm/zsh-nvm.plugin.zsh
check fzf && {
    . $ZDOTDIR/scripts/fzf/fzf.zsh
}

# Keybindings
bindkey -e
bindkey '^R' fzf-history-widget
bindkey '^F' fzf-file-widget

# Prompt
if [[ -z "$SSH_CLIENT" ]]; then
    SSH_PROMPT=""
else
    SSH_PROMPT="[%{$fg[red]%}SSH%{$reset_color%}]"
fi

precmd() {
    vcs_info
}

PROMPT='%{$fg[blue]%}%n %{$reset_color%}» %m%{$reset_color%}$SSH_PROMPT » %{$fg[red]%}%~
%{$fg[cyan]%}${vcs_info_msg_0_}% %{$fg[magenta]%}> '
RPROMPT="%{$(echotc UP 1)%}%{$fg[blue]%}%T%{$reset_color%}%{$(echotc DO 1)%}"
