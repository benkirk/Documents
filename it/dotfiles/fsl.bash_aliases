########################################################################
#  Aliases
########################################################################
alias bye='             logout'
# alias cdt='             cd `targ`'
# alias cqd='             cvs -q up -Pd'
alias ls='              ls --color'
alias la='              ls -la'
alias lo='              exit'
alias ll='              ls -l'
alias lt='              ls -ltrh'
alias make='            make --no-print-directory -s'
#alias startsocket='rm -f ~/.ssh/sfe.sock; /usr/bin/ssh -p 24 -fN sfe-master'
alias startsocket='rm -f ~/.ssh/sfe.sock; /usr/bin/ssh -fN sfe-master'
alias startsocket_ls='rm -f ~/.ssh/sfe.sock.ls; /usr/bin/ssh -fN ls-master'
alias moudle='module'
alias open='xdg-open'

LS_COLORS="no=00:fi=00:di=01;31:ln=01;34:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;35:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:"

########################################################################
# Shell Routines
########################################################################
check_aerolab()
{
  for i in $AEROLAB_WORKSTATIONS ; do
      echo ">>>>>>>>>>>>>>>>>>>>>>>>>>> $i <<<<<<<<<<<<<<<<<<<<<<<<<<"
      ssh $i w 2>/dev/null
      echo " "
      echo " "
  done
}



psg() {
  STRING=`ps $PS_FLAGS | egrep "$*" | egrep -v " egrep $*"`
  echo "$STRING"
}



psgkill() {
  STRING=`ps $PS_FLAGS | egrep "$*" | egrep -v " egrep $*"`
  echo "$STRING"
  PID=`echo "$STRING" | awk '{print $2}' `
  echo deleting these processes: $PID
  echo -n "Y or N? "
  read ans
  if [ "$ans" = "Y" -o "$ans" = "y" -o "$ans" = "Yes" -o "$ans" = "yes" ]; then    kill -9 $PID
  fi
}



setenv () {
  export $1="$2"
}



unsetenv () {
  unset $*
}

set_builddirs() {

  if (test "x$AEROLAB_SYSTEM_CLASS" != "x"); then
      BUILD_CLASS=$AEROLAB_SYSTEM_CLASS
      if (test "x$MPI_ID_STRING" != "x"); then
	  BUILD_CLASS="$BUILD_CLASS-$MPI_ID_STRING"
      fi
      if (test "x$COMPILER_ID_STRING" != "x"); then
	  BUILD_CLASS="$BUILD_CLASS-$COMPILER_ID_STRING"
      fi
  else
      echo "Unrecognized BUILD_CLASS!!"
  fi

  if (test -d $FINS_ROOT); then
      export FINS_BUILD_DIR=$FINS_ROOT/$METHOD-$BUILD_CLASS
  fi

  if (test -d $CHAR_ROOT); then
      export CHAR_BUILD_DIR=$CHAR_ROOT/$METHOD-$BUILD_CLASS
  fi

  # if (test -d $FCCHT_ROOT); then
  #     export FCCHT_BUILD_DIR=$FCCHT_ROOT/$METHOD-$BUILD_CLASS
  # fi

  BUILD_DIR=$METHOD-$BUILD_CLASS
}

opt() {
  export METHOD=opt
  METHOD_TITLE=O

  set_builddirs
}
oprofile() {
  export METHOD=oprof
  METHOD_TITLE=OP

  set_builddirs
}
devel() {
  export METHOD=devel
  METHOD_TITLE=D

  set_builddirs
}
dbg() {
  export METHOD=dbg
  METHOD_TITLE=G

  set_builddirs
}
pro() {
  export METHOD=pro
  METHOD_TITLE=P

  set_builddirs
}


set_finsroot() {
    export FINS_ROOT=`pwd`
    if (test $# -eq 1); then
	export FINS_ROOT=$1
    fi
    echo "Setting FINS_ROOT=$FINS_ROOT"
    set_builddirs
}

# opt mode by default
opt


# Working directory in Xterm title bar stuff
cd() {
  OLDERPWD="$OLDPWD"
  builtin cd "$@"
  APWD=`$PWD_CMMD`
  CWD=`echo $APWD | sed -e "s;^$HOME_DIR;~;" \
                        -e 's;^~/[^/][^/]*/..*/\(..*/\);\.\.\./\1;' \
                        -e 's;^/[^/][^/]*/..*/\(..*/\);\.\.\./\1;'`
}

xsettitle() {
    builtin echo -n -e "\033]2;$1\007";
}



restart_synergy() {
    psgkill synergys
    synergys --name benkirk.jsc.nasa.gov
}

# Local Variables:
# mode: shell-script
# End:
