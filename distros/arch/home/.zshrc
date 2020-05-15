# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/cole/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Path to your oh-my-zsh installation.
if [[ -d "$HOME/.oh-my-zsh" ]] then
  export ZSH="$HOME/.oh-my-zsh"
  plugins=()
  source $ZSH/oh-my-zsh.sh
fi

# Get zplug as universal zsh plugin manager. Can be left uncommented
# if [[ -x "$HOME/.zplug/autoload/zplug" ]] then
# 	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
# fi

if [[ ( -f "$HOME/.zplug/init.zsh" || -f "/usr/share/zsh/scripts/zplug/init.zsh" ) ]] then
    source "$HOME/.zplug/init.zsh" > /dev/null 2>&1 || source "/usr/share/zsh/scripts/zplug/init.zsh"
    zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
    # For spaceship configuration
    source "$HOME/.spaceship-prompt/settings.zsh"
    zplug "plugins/git", from:oh-my-zsh
    zplug "plugins/battery", from:oh-my-zsh
    zplug "plugins/tmux", from:oh-my-zsh
    zplug "plugins/docker", from:oh-my-zsh
    zplug "plugins/docker-compose", from:oh-my-zsh
    zplug 'wfxr/forgit'
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "mafredri/zsh-async", from:github
    zplug load
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"
for dotfile in .alias .function .export .profile .commonrc
do
    [ -f "$HOME/$dotfile" ] && source "$HOME/$dotfile"
done
# tmuxp (install with "pip install --user tmuxp")
[ -d ~/.tmuxp ] && eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/cole/.sdkman"
[[ -s "/home/cole/.sdkman/bin/sdkman-init.sh" ]] && source "/home/cole/.sdkman/bin/sdkman-init.sh"
