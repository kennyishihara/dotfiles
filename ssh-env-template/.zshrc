export PATH=$HOME/bin:$HOME/.local/bin:$HOME/Developer:$HOME/.cargo/bin:$PATH
export LANG=en_US.UTF-8
export TERM=xterm-256color

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

# lsd
if [[ $(command -v lsd) ]]; then
  alias ls='lsd'
  alias l='ls -l'
  alias la='ls -a'
  alias lsa='ls -la'
  alias lt='ls --tree'
fi

# neovim
alias n="nvim"

# tmux
alias t="tmux"
alias tn="tmux new -s"
alias tls="tmux ls"
alias ta="tmux attach -t"
# tmux detach or delete
function _delete_or_detach() {
    if [[ -n "${BUFFER}" ]]
    then
        zle delete-char-or-list
    else
        tmux detach-client
    fi
}
if [[ -n "$TMUX" ]]
then
  setopt ignoreeof
  zle -N _delete_or_detach
  bindkey "^D" _delete_or_detach
fi

# zoxide
eval "$(zoxide init zsh)"
if [[ $(command -v z) ]]; then
  alias cd="z"
  alias cdi="zi"
fi

source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
