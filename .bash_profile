# Terminal settings
function generate_pwd {
  pwd | sed s.$HOME.~.g | awk -F"/" '
  BEGIN { ORS="/" }
  END {
  for (i=1; i<= NF; i++) {
      if ((i == 1 && $1 != "") || i == NF-1 || i == NF) {
        print $i
      }
      else if (i == 1 && $1 == "") {
        print "/"$2
        i++
      }
      else {
        print ".."
      }
    }
  }'
}
export PS1="\[\033[38;5;48m\]\@\[\e[m\] \$(generate_pwd) \[\e[32m\]=>\[\e[m\] "
export PS2="| => "
export EDITOR=/usr/bin/nano
export HISTCONTROL=ignorespace

# Application Settings
export PATH=$PATH:~/.local/bin

export PYENV_ROOT=/usr/local/opt/pyenv
eval "$(pyenv init -)"
pyenv virtualenvwrapper

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Helper functions
function title {
  echo -ne "\033]0;"$*"\007" # Rename terminal windows
}
function trash() {
  command mv "$@" ~/.Trash ;
}
function md() {
  mkdir -p "$@" && cd "$@";
}

# Aliases
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
