# zplug (auto-install if not present)
export ZPLUG_HOME=~/.zplug
[[ ! -d $ZPLUG_HOME ]] && git clone https://github.com/zplug/zplug $ZPLUG_HOME
[[ -f $ZPLUG_HOME/init.zsh ]] && {
    source $ZPLUG_HOME/init.zsh

    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-history-substring-search"
    zplug "unixorn/warhol.plugin.zsh"

    if ! zplug check; then
        zplug install
    fi

    zplug load
}

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

# zstyle completions
zstyle ':completion:*' completer _complete _ignored _match _correct _approximate
zstyle ':completion:*' original false
zstyle ':completion:*:match:*' original only

zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZDOTDIR/cache

zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes
zstyle ':acceptline:*' rehash true

# LS_COLORS in completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu yes=long select

# OrbStack completions (must be before compinit)
[[ "$OSTYPE" == darwin* ]] && [[ -d /Applications/OrbStack.app/Contents/Resources/completions/zsh ]] && \
    fpath+=/Applications/OrbStack.app/Contents/Resources/completions/zsh

# Autoloads
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

# Additional files
. $ZDOTDIR/aliases
. $ZDOTDIR/functions

# Modern tools
# pnpm
command -v pnpm &> /dev/null && eval "$(pnpm completion zsh)"

# zoxide (smart cd)
command -v zoxide &> /dev/null && eval "$(zoxide init zsh --cmd cd)"

# direnv (auto .envrc)
command -v direnv &> /dev/null && eval "$(direnv hook zsh)"

# grc (colored output)
[[ -f /opt/local/etc/grc.zsh ]] && source /opt/local/etc/grc.zsh

# fzf (system)
[[ -f /opt/local/share/fzf/shell/key-bindings.zsh ]] && source /opt/local/share/fzf/shell/key-bindings.zsh
[[ -f /opt/local/share/fzf/shell/completion.zsh ]] && source /opt/local/share/fzf/shell/completion.zsh

# Docker
[[ -d $HOME/.docker/bin ]] && export PATH="$HOME/.docker/bin:$PATH"

# OrbStack (macOS)
isdarwin && [[ -f $HOME/.orbstack/shell/init.zsh ]] && source $HOME/.orbstack/shell/init.zsh 2>/dev/null

# Keybindings
bindkey -e
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[Z' reverse-menu-complete  # Shift+Tab - back in completions menu
bindkey '^B' autosuggest-toggle       # Ctrl+B - toggle autosuggestions
WORDCHARS=${WORDCHARS/\/}             # Ctrl+W - remove path segment, not whole path

# [Home] - Go to beginning of line
[[ -n "${terminfo[khome]}" ]] && bindkey -M emacs "${terminfo[khome]}" beginning-of-line

# [End] - Go to end of line
[[ -n "${terminfo[kend]}" ]] && bindkey -M emacs "${terminfo[kend]}" end-of-line

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char

# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
    bindkey -M emacs "${terminfo[kdch1]}" delete-char
else
    bindkey -M emacs "^[[3~" delete-char
    bindkey -M emacs "^[3;5~" delete-char
fi

# Prompt
. $ZDOTDIR/prompt

if command -v motd &> /dev/null
then
    motd
fi
