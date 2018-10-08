export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

export GOPATH=$HOME/go
export NODEPATH=/usr/local/Cellar/node/7.10.0/bin
export PYPATH=/usr/local/opt/python@2/libexec/bin
export PATH="/usr/local/bin:$PYPATH:$NODEPATH:$(brew --prefix qt@5.5)/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.4/bin:$PATH"

source $ZSH/oh-my-zsh.sh

export EDITOR='mvim -v'
export BUNDLER_EDITOR='mvim -v'

alias ll="ls -l"
alias cl="clear"

alias vim="mvim -v"

alias b="bundle"
alias be="bundle exec"
alias bo="bundle open"

alias glog="git log --oneline --decorate --graph"
alias gc="git switch"

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

chruby 2.5.0

source ~/.bin/tmuxinator.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
