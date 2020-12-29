#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Common shell files.
for dotfile in .alias .function .export .commonrc .secrets
do
    [ -f "$HOME/$dotfile" ] && source "$HOME/$dotfile"
done
