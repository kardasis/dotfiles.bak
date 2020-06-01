# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# ZSH settings 
export ZSH="/Users/arikardasis/.oh-my-zsh"
ZSH_THEME="ari"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"

plugins=(
  git brew sudo zsh-syntax-highlighting rails python zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

export PATH="$PATH:/usr/local/go/bin"
export PATH=/usr/local/bin:$PATH

# color settings
export CLICOLOR=1
export LSCOLORS=Cxfxcxdxbxegedabagacad

# very large history
HISTFILESIZE=1000000000 HISTSIZE=1000000

gogit()
{
  url_path=$(git remote -v | \
      awk '/git@github.com:/ && /(fetch)/ {print $2}' | \
      awk 'BEGIN  {FS = ":"} {print $2}' | \
      awk '{FS = "."} {print $1}')
  full_url=https://github.com/$url_path
  open -a "/Applications/Google Chrome.app" $full_url
}

cd_to_git_root()
{
if [ ! -d .git ]; then
  dir=$(git rev-parse --git-dir 2> /dev/null);
  if [ -n "$dir" ]; then
    cd $dir && cd ..;
  fi;
fi;
}

# tab completion
if command -v brew && [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# nvm
source $(brew --prefix nvm)/nvm.sh

# run 'nvm use' whenever entering a directory with an nvmrc 
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc



# reduce the scope of git tab completion
__git_files () { 
    _wanted files expl 'local files' _files     
}

# map option left/right arrow on mac keybard to move around by words
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word

# vi bindings
bindkey -v
bindkey '^R' history-incremental-search-backward

export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history


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
alias sz='source ~/.zshrc'
alias dcodb='dco down && dco build'
alias rm=trash
alias hm='hivemind -p 3000 Procfile.dev'
alias cdkk='cd ~/cottageClass/kidsclub'
alias cdt='cd ~/trading'
alias pes='pipenv shell'
alias path='tr ":" "\n" <<< "$PATH"'
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk


# for cloner : https://pypi.org/project/cloner
export CLONER_PATH="$HOME/repos"

setopt auto_cd
cdpath=($HOME/repos $HOME/repos/kardasis)


export EDITOR='vim'
export TERM=xterm-256color
export PGDATA=/usr/local/var/postgres
