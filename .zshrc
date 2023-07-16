export PATH=$HOME/bin:/opt/homebrew/anaconda3/bin:$JAVA_HOME/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/Users/kennyishihara/Library/Application\ Support/Coursier/bin:$PATH
export EDITOR='/opt/homebrew/opt/helix/bin/hx'
export ZSH="/Users/kennyishihara/.oh-my-zsh"
export LANG=en_US.UTF-8
export PATH=/Users/kennyishihara/Developer/zig-nightly/zig/build/stage3/bin:$PATH
export PATH=/Users/kennyishihara/Developer/zls/zig-out/bin:$PATH

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

alias backup='rsync -avP ~/Cryptomator/* /Volumes/Secure_USB/'

#mcfly
export MCFLY_RESULTS=50
export MCFLY_INTERFACE_VIEW=BOTTOM

# lsd
if [[ $(command -v lsd) ]]; then
  alias ls='lsd'
  alias l='ls -l'
  alias la='ls -a'
  alias lla='ls -la'
  alias lt='ls --tree'
fi

# helix
if [[ $(command -v hx) ]]; then
  alias h="hx"
fi

# zoxide
eval "$(zoxide init zsh)"
if [[ $(command -v z) ]]; then
  alias cd="z"
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

source /Users/kennyishihara/.config/broot/launcher/bash/br