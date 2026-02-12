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
# At the moment, source $ZSH/oh-my-zsh.sh
# performs this.
autoload -Uz compinit
if [[ -n $(find ~/.zcompdump -mtime +1 2>/dev/null) ]]; then
  compinit
else
  compinit -C
fi

# fpath=(${(uo)fpath})

# Added as per:
# https://intellij-support.jetbrains.com/hc/en-us/articles/15268184143890-Shell-Environment-Loading
# so they are removed when intellij uses a shell.
# Treat as though the if brance wasn't here for regular configuration.
# if [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then
# fi

# History options
unsetopt EXTENDED_HISTORY      # Don't append timestamp to zsh history
setopt APPEND_HISTORY          # Append history to the file (rather than replace it)
setopt INC_APPEND_HISTORY      # Add new history lines incrementally, as soon as they are entered
# setopt SHARE_HISTORY           # Share history between all sessions (implies INC_APPEND_HISTORY) - note adds history timestamp!
# setopt EXTENDED_HISTORY        # Write history in the ":start:elapsed;command" format (adds timestamps)
setopt HIST_IGNORE_DUPS        # Do not record an event that was just recorded again
setopt HIST_SAVE_NO_DUPS       # Do not write duplicate events to the history file
setopt HIST_IGNORE_SPACE       # Do not record an event that starts with a space

setopt interactivecomments     # Allow comments in interactive shell

# set terminal to line cursor
echo -ne '\e[5 q'

for dotfile in .alias .secrets .export .function .commonrc .kubectl-aliases .work 
do
   [ -f "$HOME/$dotfile" ] && source "$HOME/$dotfile"
done

# tmuxp (install with "pip install --user tmuxp")
if command -v tmuxp >/dev/null 2>&1; then
	[[ -d ~/.tmuxp ]] && eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"
fi

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# zxoide config - needs to be at end or close
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi
brew_prefix=$(brew --prefix 2>/dev/null)

# brew install zsh-syntax-highligting
[ -f "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# brew install zsh-autosuggestions
#
# Performance tweak:
# https://scottspence.com/posts/speeding-up-my-zsh-shell
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff"
[ -f "$brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/CBishop/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
# Add this to the BOTTOM of your .zshrc

# Uncomment to see what might be making
# zsh slower.
# zprof