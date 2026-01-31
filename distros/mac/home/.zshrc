# Add this to the TOP of your .zshrc
# to profile what's taking up time as
# per https://scottspence.com/posts/speeding-up-my-zsh-shell
# Shell improvements - disable auto updates for oh-my-zsh.
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Uncomment to see what might be making
# zsh slower:
# zmodload zsh/zprof

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
# zstyle :compinstall filename '/home/cole/.zshrc'
# autoload -Uz compinit
# compinit
#
# 
# Smarter completion initialization - rebuild cache once a day.
autoload -Uz compinit
if [[ -n $(find ~/.zcompdump -mtime +1 2>/dev/null) ]]; then
  compinit
else
  compinit -C
fi

# End of lines added by compinstall

# Added as per:
# https://intellij-support.jetbrains.com/hc/en-us/articles/15268184143890-Shell-Environment-Loading
# so they are removed when intellij uses a shell.
# Treat as though the if brance wasn't here for regular configuration.
if [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then
  # Path to your oh-my-zsh installation.
  if [[ -d "$HOME/.oh-my-zsh" ]] then
    export ZSH="$HOME/.oh-my-zsh"
    # To active syntax highlighting, run  
    # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    #
    # For manual installation of zsh-autosuggestions, run
    # git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    #
    # Load nvm completion lazily to speed up shell loading.
    # https://dev.to/thraizz/fix-slow-zsh-startup-due-to-nvm-408k
    zstyle ':omz:plugins:nvm' lazy yes

    # echo "Sourcing oh-my-zsh plugins..."
    plugins=(
		git
		# You may need to install first with:
		# curl -sS https://starship.rs/install.sh | sh
		starship
		# See all git aliases: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git#aliases
		kubectl
		tmux
		zsh-256color
		deno
		nvm
		# sdkman auto complete
		sdk
		fzf
		zsh-autosuggestions
		# Needs to be last!
		# https://scottspence.com/posts/speeding-up-my-zsh-shell
		zsh-syntax-highlighting
    )

	# Tragically, this must go here instead of near the 
	# history config in .export as bash doesn't recognize it.
	setopt EXTENDED_HISTORY
	setopt HIST_EXPIRE_DUPS_FIRST
	setopt HIST_IGNORE_DUPS
	setopt HIST_IGNORE_ALL_DUPS
	setopt HIST_IGNORE_SPACE
	setopt HIST_FIND_NO_DUPS
	setopt HIST_SAVE_NO_DUPS
	setopt HIST_BEEP

	# echo "oh-my-zsh starting..."
	source $ZSH/oh-my-zsh.sh
  fi

  # echo "spaceship starting..."
  # presume spaceship theme installed manually with
  # mkdir -p "$HOME/.zsh" && git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git "$HOME/.zsh/spaceship"
  #[[ -d "$HOME/.zsh/spaceship" ]] && export SPACESHIP_ROOT="$HOME/.zsh/spaceship"
  #[[ -f "$HOME/.zsh/spaceship/spaceship.zsh" ]] && source "$HOME/.zsh/spaceship/spaceship.zsh"

  setopt interactivecomments

fi

# Performance tweak:
# https://scottspence.com/posts/speeding-up-my-zsh-shell
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# set terminal to line cursor
# echo -ne '\e[5 q'

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
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

# might not need this from the sdk oh my zsh plugin above
# export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun" # bun completions
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/CBishop/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
# Add this to the BOTTOM of your .zshrc

# Uncomment to see what might be making
# zsh slower.
# zprof
