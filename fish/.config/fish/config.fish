set fish_greeting

export EDITOR=nvim || export EDITOR=vim

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export RVM_DIR="$HOME/.rvm"
export GCS="$HOME/.local/share/google-cloud-sdk"

switch (uname)
    case Darwin
        export N_PREFIX="$HOME/.local/n"
        export PATH="/opt/local/bin:/opt/local/sbin:$HOME/Library/Python/3.11/bin:$N_PREFIX/bin:$HOME/.local/bin:$PATH"
        export MANPATH="/opt/local/share/man:$MANPATH"
end

if test -e "$HOME/.local/share/google-cloud-sdk/path.fish.inc"
    . "$HOME/.local/share/google-cloud-sdk/path.fish.inc"
end

if test -e "/opt/local/share/fzf/shell/key-bindings.fish"
    source /opt/local/share/fzf/shell/key-bindings.fish
end

if test -e "$HOME/.docker/bin"
    set --export --prepend PATH "/Users/zed/.docker/bin"
end
