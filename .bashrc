
export LANG=C

alias c=clear
#alias ls='ls -F --color'

#alias xterm='xterm -sl 20000 -geometry 100x30'
alias xterm='xterm -sl 20000 -geometry 70×30+100+40 -fn 9x15'
#*-fixed-*-*-*-20-*'
alias tree=~/bin/tree.linux



gitdiffroot() {
if [ -z "$1" ]
  then
    sb repo forall -p -c 'git diff' > root.diff
  else
    sb repo forall -p -c 'git diff' > $1
fi
}
alias gitdiffroot_fun=gitdiffroot


tmux_create() {
    #tmux new -s  $1
    tmux -S /tmp/$1 new
}

tmux_attach() {
   #tmux attach-session -t $1
   tmux -S /tmp/$1 attach
}

tmux_list() {
    #tmux ls
    ps -Af | grep tmux | grep -v grep
}


function start_ssh()
{
    if [ ! -z $SSH_AGENT_PID ] 
    then
	echo "ssh-agent looks like running, let's check ..."
    fi
    if [ `ps -eaf | grep ssh-agent | wc -l` -ge 2 ] 
    then 
	eval `cat /tmp/$HOSTNAME-ssh-agent`
	echo ssh-agent running...PID=$SSH_AGENT_PID
    else 
	echo -n ssh-agent is not running...
	eval `ssh-agent -s | tee /tmp/$HOSTNAME-ssh-agent` > /dev/null
	echo started... pid = $SSH_AGENT_PID
    fi
#
# add key for the ssh-agent
#
    if [ `ssh-add -l | grep ssh | wc -l` -lt 1 ] 
    then 
	ssh-add ~/.ssh/id_rsa
    fi
}

if [[ "`uname -s`" == "FreeBSD" ]]; then
    alias ls='ls -F -G'
else
    alias ls='ls -F --color'
fi

function make_cscope()
{
    if [ -e ./cscope.files ] ; then
	echo "cscope.files exists, using it."
    else
	echo -n "cscope.files does not exist..."
	find . -type f -and \( -name "*.[chesCHES]" -o -name "*.mk" -o -name "*akefile" -o -name "*.inc" -o -name "*.conf" -o -name "*.dd" -o -name "*.sh" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.cc" -o -name "*.hh" -o -name "*.cxx" -o -name "*.hxx" -o -name "*.evl" -o -name "*.d2e" \) > cscope.files
	echo "Created!"
    fi
    \rm ./cscope*.out > /dev/null 2>&1
    echo -n "Creating cscope database.. be patient.. it takes a looooong time..."
    cscope -b -R > /dev/null 2>&1
    echo "Done!"
}

