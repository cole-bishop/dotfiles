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

eval "$(starship init bash)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/cole/.sdkman"
[[ -s "/home/cole/.sdkman/bin/sdkman-init.sh" ]] && source "/home/cole/.sdkman/bin/sdkman-init.sh"
