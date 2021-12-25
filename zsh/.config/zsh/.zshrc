fpath=($ZDOTDIR/scripts/stripe-completion/ $fpath)
fpath=($ZDOTDIR/scripts/zsh-completions/src/ $fpath)

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
zstyle ':completion:*' cache-path $ZDOTDIR/cache

# Don't complete entry on line multiple times for the following
# commands
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes

# Rehash so that completion doesn't fail when new command added
zstyle ':acceptline:*' rehash true

#Autoloads
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
autoload -Uz compinit && compinit -i
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
. $ZDOTDIR/scripts/zsh-history-substring-search/zsh-history-substring-search.zsh
. $ZDOTDIR/scripts/jsks-plugins/zbk/zbk.zsh

[[ -d $NVM_DIR ]] && {
    . $ZDOTDIR/scripts/zsh-nvm/zsh-nvm.plugin.zsh
}

[[ -d $RVM_DIR ]] && {
    PATH="$PATH:$RVM_DIR/bin"
    [[ -s "$RVM_DIR/scripts/rvm" ]] && source "$RVM_DIR/scripts/rvm" ]]
}

check fzf && {
    . $ZDOTDIR/scripts/fzf/fzf.zsh
}

[[ -d $GCS ]] && {
    . $GCS/path.zsh.inc
    . $GCS/completion.zsh.inc
}

# Keybindings
bindkey -e
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey '^R' fzf-history-widget
bindkey '^F' fzf-file-widget


# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M emacs "${terminfo[khome]}" beginning-of-line
fi

# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M emacs "${terminfo[kend]}"  end-of-line
fi

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char

# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M emacs "${terminfo[kdch1]}" delete-char
else
  bindkey -M emacs "^[[3~" delete-char
  bindkey -M emacs "^[3;5~" delete-char
fi

# # [Ctrl-Delete] - delete whole forward-word
# bindkey -M emacs '^[[3;5~' kill-word
# # [Ctrl-RightArrow] - move forward one word
# bindkey -M emacs '^[[C;5C' forward-word
# # [Ctrl-LeftArrow] - move backward one word
# bindkey -M emacs '^[[D;5D' backward-word



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
%{$fg[cyan]%}${vcs_info_msg_0_}% %{$fg[magenta]%}λ '
RPROMPT="%{$(echotc UP 1)%}%{$fg[blue]%}%T%{$reset_color%}%{$(echotc DO 1)%}"
