export PATH=$HOME/bin:$HOME/.local/bin:$HOME/Developer:$JAVA_HOME/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.cargo/bin:$PATH:$HOME/Developer/flutter/bin
export EDITOR='/opt/homebrew/opt/neovim/bin/nvim'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export RESTIC_REPOSITORY="Restic/restic-repo"

# Use vi binding for CLI
export KEYTIMEOUT=1
bindkey -v

setopt autocd

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

# git shortcuts
alias rmgitignored="git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached"

# Check that the function `starship_zle-keymap-select()` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null || \
  {
    eval "$(starship init zsh)"
  }
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/kennyishihara/.cache/lm-studio/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kennyishihara/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kennyishihara/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kennyishihara/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kennyishihara/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
