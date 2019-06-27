# dotfiles
```
 bspwm      > tiling window manager
 dunst      > notification daemon
 git        > git config and aliases
 nvim       > text editor config
 polybar    > status bar
 ranger     > file manager
 rofi       > application launcher
 scripts    > some automation scripts
 sxhkd      > simple X hotkey daemon
 zsh        > antigen plugins and themes
```

# Usage
I use [stow](https://www.gnu.org/software/stow/) to manage my dotfiles
```
git clone https://github.com/ZedNait/.dotfiles
cd ~/.dotfiles
stow bspwm dunst feh git nvim polybar rofi screenlayout scripts sxhkd xresources zsh
```
