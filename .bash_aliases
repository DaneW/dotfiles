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
server() { echo "http://localhost:${1}"; python -m SimpleHTTPServer $1 > /dev/null 2>&1; }
alias serve='server'
#gocd() { cd `go list -f '{{.Dir}}' $1` }