export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

export NODEPATH=/usr/local/Cellar/node/7.10.0/bin
export PATH="/usr/local/bin:$NODEPATH:/bin:$PATH"

ZSH_DISABLE_COMPFIX=true

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
alias clean="git clean -i"

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

chruby 3.0.0

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
