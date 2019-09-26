source ~/dev-tools/git-prompt.sh
source ~/dev-tools/git-completion.bash

# prompt
export PS1="\[\e[0;37m\]\n\t  \u@\h    \[\e[1;36m\] \w    \$(__git_ps1)  \[\e[1;92m\]  \n\$ \[\e[0m\] "
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

HISTFILESIZE=1000000000 HISTSIZE=1000000

# Setting PATH for Python 2.7
PATH="~/.local/bin":$PATH
export PATH=/usr/local/bin:$PATH

## Postgres data directory
export PGDATA=/usr/local/var/postgres

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NPM_DIR=/usr/local/Cellar/node/7.10.0/libexec/npm/bin
export PATH=$NPM_DIR:$PATH

export PATH=~/Library/Python/3.6/bin:$PATH

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

export EDITOR='vim'

# tab completion
if command -v brew && [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

complete -C '~/.local/bin/aws_completer' aws

cd_to_git_root()
{
if [ ! -d .git ]; then
  dir=$(git rev-parse --git-dir 2> /dev/null);
  if [ -n "$dir" ]; then
    cd $dir && cd ..;
  fi;
fi;
}

alias cdg='cd_to_git_root'
alias h='history'
alias ls='ls -G'
alias lx='ls -lxB'        						 # sort by extension
alias ll='ls -l'
alias la='ls -Al'         						 # show hidden files
alias gitdelmerged='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
alias dco='docker-compose'
alias gsur='/usr/bin/git submodule update --recursive'
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias sb='source ~/.bash_profile'
alias dcodb='dco down && dco build'
# added by Anaconda3 5.3.1 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
