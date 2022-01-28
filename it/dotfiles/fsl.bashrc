# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


# Files you make look like -rw-r-----
umask 0027



# load local config
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

# load aliases before local config
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi



if [ "$PS1" ]; then

  # Set auto_resume if you want TWENEX style behaviour for command names.
  auto_resume=

  # Set notify if you want to be asynchronously notified about background
  # job completion.
  notify=

  # Set command_oriented_history to save multi-line history as one line
  command_oriented_history=

  # Make it so that failed `exec' commands don't flush this shell.
  no_exit_on_failed_exec=

  if [ ! "$LOGIN_SHELL" ]; then
    PS1="\h(\#)$ "
  fi

  # export HISTSIZE=4096
  # export HISTCONTROL=ignoreboth
fi

# [ "$GROUPS" == "3000" ] || exec newgrp - eg3
