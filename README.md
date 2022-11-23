# dotfiles
```
 git        > git config and aliases
 nvim       > text editor config
 scripts    > some automation scripts
 zsh        > antigen plugins and themes
```

# Usage
I use [stow](https://www.gnu.org/software/stow/) to manage my dotfiles
```
git clone --recurse-submodules https://github.com/zed-nait/.dotfiles
cd ~/.dotfiles
stow -R *(/)
```
