# Env vars
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
export PYENV_ROOT=~/.pyenv
export PATH=$PYENV_ROOT/shims:$PATH
export EDITOR=/usr/bin/nano
export GOPATH=$HOME/Software/go
export PATH=/usr/local/sbin:$PATH
export HISTCONTROL=ignorespace
export NVM_DIR="$HOME/.nvm"
export SDKMAN_DIR=/Users/danew/.sdkman
export PATH=~/.local/bin:$PATH
export PATH=/Users/danew/Software/bin:$PATH
export PATH=/Users/danew/Library/Android/sdk:$PATH
export PATH=/Users/danew/Library/Android/sdk/platform-tools:$PATH
# Alias'
alias ll="ls -FGlAhp"
alias edit="code"
alias f='open -a Finder ./'
alias ~="cd ~"
alias ..='cd ../'
alias ...='cd ../../'
alias which='type -all'
alias cic='set completion-ignore-case On'
alias DT='tee ~/Desktop/terminalOut.txt'
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
alias myip='curl ip.appspot.com'
alias netCons='lsof -i'
alias flushDNS='dscacheutil -flushcache'
alias fp='ps -ef | grep $@'
alias pblocal='ansible-playbook -i ~/ansible-localhost-inventory --connection=local'
alias g='git'
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"
alias lsl="ls -lhFA | less"

# Custom functions

function setjdk() {
  if [ $# -ne 0 ]; then
    removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
    if [ -n "${JAVA_HOME+x}" ]; then
      removeFromPath $JAVA_HOME
    fi
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
    export PATH=$JAVA_HOME/bin:$PATH
  fi
}
function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}
function title {
  echo -ne "\033]0;"$*"\007" # Rename terminal windows
}
function trash() {
  command mv "$@" ~/.Trash ;
}
function pidown() {
  echo "Downloading "~/Downloads/downloads/$1
  scp -rp pi@10.0.1.154:~/Downloads/downloads/$1 ~/Desktop/pi/$1
}
function sp() {
  DIR=
  if [ "${PWD##*/}" == "kernel" ]; then
    git fetch
    git checkout $1
    git pull
    cd kernel
    ant clean setup
    cd ../kernel
    ant clean setup
    cd ../dev
    ant clean setup
    cd ..
    echo "Successfully swtiched project branch to $1"
  else
    echo "Please make sure you are in the kernel project"
  fi
}
function md() {
  mkdir -p "$@" && cd "$@";
}

# Random shit

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -s "/Users/danew/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/danew/.sdkman/bin/sdkman-init.sh"

eval "$(pyenv init -)"
pyenv virtualenvwrapper

# Support for virtualenv 
#PROMPT_COMMAND='prompt'
#function prompt()
#{
#    if [ "$PWD" != "$MYOLDPWD" ]; then
#        MYOLDPWD="$PWD"
#        test -e .venv && workon `cat .venv`
#    fi
#}

function switch_dns {
    INTERFACE=$1
    if [ "$INTERFACE" = "An asterisk (*) denotes that a network service is disabled." ]; then
        exit 1
    else
        DNS=$(networksetup -getdnsservers "$INTERFACE" | tr -d "\n")
        if [ "$DNS" == "8.8.8.88.8.4.4" ]; then
            sudo networksetup -setdnsservers "$INTERFACE" 172.20.1.5 172.20.1.6
            echo "Switched to Orion DNS"
        elif [ "$DNS" == "172.20.1.5172.20.1.6" ]; then
            sudo networksetup -setdnsservers "$INTERFACE" 8.8.8.8 8.8.4.4
            echo "Switched to Google DNS"
        fi
    fi
}
export -f switch_dns

function dns() {
  networksetup listallnetworkservices | xargs -I{} bash -c 'switch_dns "{}"'
}