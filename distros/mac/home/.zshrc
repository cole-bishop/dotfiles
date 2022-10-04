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
if [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then
  # Path to your oh-my-zsh installation.
  if [[ -d "$HOME/.oh-my-zsh" ]] then
    export ZSH="$HOME/.oh-my-zsh"
    # To active syntax highlighting, run  
    # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    #
    # To make sure spaceship runs, run
    # git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    # And create the symlink
    # ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    plugins=(git kubectl tmux zsh-syntax-highlighting)
    source $ZSH/oh-my-zsh.sh
  fi
  # presume spaceship theme installed manually with
  # mkdir -p "$HOME/.zsh" && git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git "$HOME/.zsh/spaceship"
  [[ -d "$HOME/.zsh/spaceship" ]] && export SPACESHIP_ROOT="$HOME/.zsh/spaceship"
  [[ -f "$HOME/.zsh/spaceship/spaceship.zsh" ]] && source "$HOME/.zsh/spaceship/spaceship.zsh"

  setopt EXTENDED_HISTORY
  setopt HIST_EXPIRE_DUPS_FIRST
  setopt HIST_IGNORE_DUPS
  setopt HIST_IGNORE_ALL_DUPS
  setopt HIST_IGNORE_SPACE
  setopt HIST_FIND_NO_DUPS
  setopt HIST_SAVE_NO_DUPS
  setopt HIST_BEEP

  setopt interactivecomments

fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

for dotfile in .alias .secrets .export .function .commonrc .kubectl-aliases .work 
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
