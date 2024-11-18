export PATH=$HOME/bin:$HOME/Developer:$JAVA_HOME/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$HOME/.cargo/bin:$PATH
export EDITOR='/home/linuxbrew/.linuxbrew/bin/nvim'
export LANG=en_US.UTF-8

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

#mcfly
export MCFLY_RESULTS=20
export MCFLY_INTERFACE_VIEW=BOTTOM
export MCFLY_KEY_SCHEME=vim
export MCFLY_RESULTS_SORT=LAST_RUN
export MCFLY_HISTORY_LIMIT=10000

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

# yazi
alias y="yazi"

# zoxide
eval "$(zoxide init zsh)"
if [[ $(command -v z) ]]; then
  alias cd="z"
  alias cdi="zi"
fi

eval "$(starship init zsh)"
eval "$(mcfly init zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh