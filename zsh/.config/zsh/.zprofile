. $ZDOTDIR/functions

export EDITOR=nvim || export EDITOR=vim
export BROWSER="chromium"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export NVM_DIR="$HOME/.local/share/nvm"

if isdarwin && [[ -d /opt/local ]]; then
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    export MANPATH="/opt/local/share/man:$MANPATH"
fi
