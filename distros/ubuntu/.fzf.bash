# Setup fzf
# ---------
if [[ ! "$PATH" == */home/xloce/.fzf/bin* ]]; then
  export PATH="$PATH:/home/xloce/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/xloce/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/xloce/.fzf/shell/key-bindings.bash"

