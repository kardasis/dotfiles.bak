# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/arikardasis/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes


# Working list of themes I think I like 
# xiong-chiamiov.zsh-theme
#
# And themes I know I don't like 
# kolo.zsh-theme
ZSH_THEME="ari"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

plugins=(
  git brew sudo zsh-syntax-highlighting rails python
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='gvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

#
export CLICOLOR=1
export LSCOLORS=Cxfxcxdxbxegedabagacad
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

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
alias sb='source ~/.bash_profile'
alias sz='source ~/.zshrc'
alias dcodb='dco down && dco build'
alias rm=trash
alias hm='hivemind -p 3000 Procfile.dev'
alias cdkk='cd ~/cottageClass/kidsclub'
alias cdt='cd ~/trading'
alias pes='pipenv shell'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

eval "$(pyenv init -)"
export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk


# for cloner : https://pypi.org/project/cloner
export CLONER_PATH="$HOME/repos"

setopt auto_cd
cdpath=($HOME/repos $HOME/repos/kardasis)


export PATH="$PATH:/usr/local/go/bin"
export PATH=/usr/local/bin:$PATH
