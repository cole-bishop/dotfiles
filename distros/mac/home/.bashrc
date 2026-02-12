#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Common shell files.
for dotfile in .alias .secrets .export .function .commonrc
do
    [ -f "$HOME/$dotfile" ] && source "$HOME/$dotfile"
done

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/CBishop/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# zxoide config - needs to be at end or close
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi