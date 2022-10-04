#
# ~/.bash_profile
#
# if running bash, source it's rc file.
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
else
  # for all other shells
  for dotfile in .alias .secrets .export .function .commonrc
  do
      [ -f "$HOME/$dotfile" ] && source "$HOME/$dotfile"
  done
fi

