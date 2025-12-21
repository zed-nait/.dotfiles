set fish_greeting

export EDITOR=nvim || export EDITOR=vim

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Nix
if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
else if test -e $HOME/.nix-profile/etc/profile.d/nix.fish
    source $HOME/.nix-profile/etc/profile.d/nix.fish
else if test -e /nix/var/nix/profiles/default/bin
    set -gx PATH /nix/var/nix/profiles/default/bin $PATH
end

export RVM_DIR="$HOME/.rvm"
export GCS="$HOME/.local/share/google-cloud-sdk"

switch (uname)
    case Darwin
        export N_PREFIX="$HOME/.local/share/n"
        export N_CACHE_PREFIX="$HOME/.local/share/"
        export PATH="/opt/local/bin:/opt/local/sbin:$HOME/Library/Python/3.11/bin:$N_PREFIX/bin:$HOME/.local/bin:$PATH"
        export MANPATH="/opt/local/share/man:$MANPATH"
        
        set -gx PNPM_HOME "/Users/zed/Library/pnpm"

        if not string match -q -- $PNPM_HOME $PATH
            set -gx PATH "$PNPM_HOME" $PATH
        end
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

if test -e "$HOME/.orbstack/shell/init2.fish"
    source /.orbstack/shell/init2.fish 2>/dev/null || :
end

