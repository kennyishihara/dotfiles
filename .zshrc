export PATH=$HOME/bin:$HOME/Developer:/opt/homebrew/anaconda3/bin:$JAVA_HOME/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export EDITOR='/opt/homebrew/opt/neovim/bin/nvim'
export ZSH="/Users/kennyishihara/.oh-my-zsh"
export LANG=en_US.UTF-8
export PATH=$HOME/Downloads/zig-macos-aarch64-0.12.0-dev.1583+97e23896a:$PATH

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

export RESTIC_REPOSITORY="/Volumes/Backup/restic-repo"

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

# neovim
alias n="nvim"
alias h="nvim"

# yazi
alias y="yazi"

# zoxide
eval "$(zoxide init zsh)"
if [[ $(command -v z) ]]; then
  alias cd="z"
  alias cdi="zi"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# Run conda config --set changeps1 false to hide the env name
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# AWS SAM disable telemetry
export SAM_CLI_TELEMETRY=0

eval "$(starship init zsh)"
eval "$(mcfly init zsh)"
