set fish_greeting

export EDITOR=nvim || export EDITOR=vim

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export NVM_DIR="$HOME/.local/share/nvm"
export RVM_DIR="$HOME/.rvm"
export GCS="$HOME/.local/share/google-cloud-sdk"

switch (uname)
    case Darwin
        export PATH="/opt/local/bin:/opt/local/sbin:$HOME/Library/Python/3.10/bin:$PATH"
        export MANPATH="/opt/local/share/man:$MANPATH"
end

if test -e "$HOME/.local/share/google-cloud-sdk/path.fish.inc"
    . "$HOME/.local/share/google-cloud-sdk/path.fish.inc"
end

source /opt/local/share/fzf/shell/key-bindings.fish
