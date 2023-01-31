export PATH="/usr/local/opt/openjdk@8/bin:$PATH"
export PATH=$HOME/bin:/usr/local/bin:/opt/homebrew/anaconda3/bin:$JAVA_HOME/bin:/opt/homebrew/bin:/Users/kennyishihara/Library/Application\ Support/Coursier/bin:$PATH
export EDITOR='/opt/homebrew/opt/helix/bin/hx'
export ZSH="/Users/kennyishihara/.oh-my-zsh"
export LANG=en_US.UTF-8

alias ibrew="arch -x86_64 /usr/local/bin/brew"
alias abrew="/opt/homebrew/bin/brew"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

#mcfly
export MCFLY_RESULTS=50
export MCFLY_INTERFACE_VIEW=BOTTOM

# exa
if [[ $(command -v exa) ]]; then
 alias e='exa --icons'
 alias l=e
 alias ls=e
 alias ea='exa -a --icons'
 alias la=ea
 alias ee='exa -aal --icons'
 alias ll=ee
 alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
 alias lt=et
 alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
 alias lta=eta
fi

# helix
if [[ $(command -v hx) ]]; then
  alias h="hx"
fi

# felix
if [[ $(command -v fx) ]]; then
  alias f="fx"
fi

# zoxide
eval "$(zoxide init zsh)"
if [[ $(command -v z) ]]; then
  alias cd="z"
fi

# zellij
if [[ $(command -v zellij) ]]; then
  alias ze="zellij"
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

eval "$(starship init zsh)"
eval "$(mcfly init zsh)"

source /Users/kennyishihara/.config/broot/launcher/bash/br
