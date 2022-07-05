#
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# this is for tmux
export TERM=screen-256color

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# SSH alias
alias sshrobo='ssh support@10.2.145.37'
alias colo='ssh -t cohesity@10.2.223.24'
alias sshrt='ssh cohesity@rt.cohesity.com'

function trt () {
  ssh -fN -L $1:rt.cohesity.com:$2 cohesity@rt.cohesity.com
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


export TOP_DIR=~/workspace/main
export PATH=$PATH:~/software/toolchain/x86_64-linux/6.1/bin
export PATH=$PATH:$TOP_DIR
export TEST_OUTPUT_DIR=/tmp/test_dir

# search over the source code in main
function glimpse {
  echo Searching $TOP_DIR/builds/ for $1
  grep -inR --exclude-dir=.go $1 $TOP_DIR/builds/*
}

export -f glimpse

## Colors?  Used for the prompt.
#Regular text color
BLACK='\[\e[0;30m\]'
#Bold text color
BBLACK='\[\e[1;30m\]'
#background color
BGBLACK='\[\e[40m\]'
RED='\[\e[0;31m\]'
BRED='\[\e[1;31m\]'
BGRED='\[\e[41m\]'
GREEN='\[\e[0;32m\]'
BGREEN='\[\e[1;32m\]'
BGGREEN='\[\e[1;32m\]'
YELLOW='\[\e[0;33m\]'
BYELLOW='\[\e[1;33m\]'
BGYELLOW='\[\e[1;33m\]'
BLUE='\[\e[0;34m\]'
BBLUE='\[\e[1;34m\]'
BGBLUE='\[\e[1;34m\]'
MAGENTA='\[\e[0;35m\]'
BMAGENTA='\[\e[1;35m\]'
BGMAGENTA='\[\e[1;35m\]'
CYAN='\[\e[0;36m\]'
BCYAN='\[\e[1;36m\]'
BGCYAN='\[\e[1;36m\]'
WHITE='\[\e[0;37m\]'
BWHITE='\[\e[1;37m\]'
BGWHITE='\[\e[1;37m\]'

PROMPT_COMMAND=smile_prompt

function smile_prompt
{
  if [ "$?" -eq "0" ]
  then
    #smiley
    SC="😎"
  else
    #frowney
    SC="😱"
  fi
  if [ $UID -eq 0 ]
  then
    #root user color
    UC="${BRED}"
  else
    #normal user color
    UC="${BRED}"
  fi
  #hostname color
  HC="${BRED}"
  #regular color
  RC="${BBLACK}"
  #default color
  DF='\[\e[0m\]'
  TIME=$(date +%H:%M)
  PS1="[${HC}\h ${TIME} ${RC}\W${DF}] ${SC}${DF} "
}

# Quickly run the make command from the top directory
function maketarget {
  cd $TOP_DIR && \
  make -j 50 $1 && \
  cd -
}

function gettarget {
  TARGET=$1

  if [ -z "$TARGET" ]
  then
    TARGET="magneto"
  fi
}

function getcluster {
  CLUSTER=$*

  if [ -z "$CLUSTER" ]
  then
    CLUSTER="10.2.37.110"
  fi

  if [[ "$CLUSTER" == "cloud" ]]
  then
    CLUSTER="10.2.32.183 10.2.32.185 10.2.32.187"
  fi
}

function copyid {
  USER="cohesity"
  NODE=$1

  echo "Copying ssh id to "${USER}@${NODE}
  sshpass -p 'Cohe$1ty' ssh-copy-id ${USER}@${NODE} || \
    sshpass -p 'fr8shst8rt' ssh-copy-id ${USER}@${NODE}
 }

function publish {
  gettarget $1
  getcluster $2
  USER="cohesity"

  maketarget ${TARGET}_exec && \
  for NODE in ${CLUSTER}
  do
    echo "Publishing "${TARGET}" to "${NODE}
    copyid ${NODE}
    scp ${TOP_DIR}/build/${TARGET}/${TARGET}_exec ${USER}@${NODE}:~ && \
    ssh ${USER}@${NODE} 'iris_cli cluster stop service-names='${TARGET} \
      ' && mv ~/'${TARGET}'_exec ~/bin/' \
      ' && iris_cli cluster start service-names='${TARGET}
  done
}

function clearwal {
  gettarget $1
  getcluster $2
  USER="cohesity"

  for NODE in ${CLUSTER}
  do
    echo "Clearing WAL on "${NODE}
    copyid ${NODE}
    ssh ${USER}@${NODE} 'iris_cli cluster stop service-names='${TARGET} \
      ' && mkdir -p /tmp/wal/ && rm -rf /tmp/wal/*' \
      ' && ~/bin/scribe_wal_tool.sh inject '${TARGET}'_master' \
      ' --cluster_endpt='${NODE}' --record_store_dir=/tmp/wal' \
      ' && iris_cli cluster start service-names='${TARGET}
    break
  done
}

function swap() {
  mv $1 $1._tmp && mv $2 $1 && mv $1._tmp $2
}

function sshc() {
  copyid $1 && \
  ssh -v $1
}

function upload() {
  COMMIT=$1
  if [ -z "$COMMIT" ]
  then
    COMMIT="HEAD"
  else
    COMMIT="HEAD~"$1
  fi

  ./open_tools/codereview/upload.py --no_oauth2_webbrowser --commit $COMMIT -y
}

export -f maketarget
export -f publish
export -f swap
export -f copyid
export -f sshc
export -f upload
export VISUAL=vim
export EDITOR=$VISUAL
