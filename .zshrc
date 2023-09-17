export PATH=$HOME/bin:$HOME/Developer:/opt/homebrew/anaconda3/bin:$JAVA_HOME/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export EDITOR='/opt/homebrew/opt/neovim/bin/nvim'
export ZSH="/Users/kennyishihara/.oh-my-zsh"
export LANG=en_US.UTF-8

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

export RESTIC_REPOSITORY="/Volumes/Backup/restic-repo"
alias backup='rsync -avP ~/Cryptomator/Vault/SecureKey /Volumes/Secure_USB/'

#mcfly
export MCFLY_RESULTS=50
export MCFLY_INTERFACE_VIEW=BOTTOM

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
alias h="nvim"

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
