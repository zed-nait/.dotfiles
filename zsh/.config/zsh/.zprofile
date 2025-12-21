. $ZDOTDIR/functions

export EDITOR=nvim || export EDITOR=vim
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Nix
if [[ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
elif [[ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

# Node (N - sync with fish)
export N_PREFIX="$HOME/.local/share/n"
export N_CACHE_PREFIX="$HOME/.local/share/"

# Google Cloud SDK
export GCS="$HOME/.local/share/google-cloud-sdk"

# macOS specific
if isdarwin && [[ -d /opt/local ]]; then
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    export PATH="$HOME/Library/Python/3.11/bin:$PATH"
    export PATH="$N_PREFIX/bin:$PATH"
    export PATH="$HOME/.local/bin:$PATH"
    export MANPATH="/opt/local/share/man:$MANPATH"

    # pnpm
    export PNPM_HOME="$HOME/Library/pnpm"
    [[ -d $PNPM_HOME ]] && export PATH="$PNPM_HOME:$PATH"
fi
