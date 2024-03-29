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

# Get zplug as universal zsh plugin manager. Don't uncomment - run as regular command.
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
if [[ ( -f "$HOME/.zplug/init.zsh" || -f "/usr/share/zsh/scripts/zplug/init.zsh" ) ]] then
    source "$HOME/.zplug/init.zsh" > /dev/null 2>&1 || source "/usr/share/zsh/scripts/zplug/init.zsh"
    zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
    # For spaceship configuration
    source "$HOME/.spaceship-prompt/settings.zsh"
    zplug "plugins/docker", from:oh-my-zsh
    zplug "plugins/git", from:oh-my-zsh
    zplug "plugins/battery", from:oh-my-zsh
    zplug "plugins/tmux", from:oh-my-zsh
    zplug "plugins/docker-compose", from:oh-my-zsh
    zplug 'wfxr/forgit'
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "mafredri/zsh-async", from:github
    zplug load
fi

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

setopt interactivecomments

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
for dotfile in .alias .function .export .profile .commonrc .secrets
do
    [ -f "$HOME/$dotfile" ] && source "$HOME/$dotfile"
done
# tmuxp (install with "pip install --user tmuxp")
which tmuxp &> /dev/null
if [[ $? -eq 0 ]] then
	[[ -d ~/.tmuxp ]] && eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
