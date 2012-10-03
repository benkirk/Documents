#########################################
# Modify environment
#########################################
PS1="elfboy(\#)$ "

# Pretty ls colors for light text on dark background
export LSCOLORS="Bxfxcxdxcxegedabagacad"

# Matlab-style history
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# #########################################
# # Boost
# #########################################
export BOOST_DIR=/opt/local
export BOOST_ROOT=$BOOST_DIR

#########################################
# Tecplot
#########################################
PATH=/Applications/Tec360_2010/bin:$PATH

# #########################################
# # Intel TBB
# #########################################
export TBB_DIR=/opt/local
# export TBB_DIR=/usr/local/tbb/tbb30_035oss
# export TBB_LIB_PATH=$TBB_DIR/build/macos_intel64_gcc_cc4.5.0_os10.6.4_release
# export DYLD_LIBRARY_PATH=$TBB_LIB_PATH:$DYLD_LIBRARY_PATH

# #########################################
# # MPI
# #########################################
# export MPI_DIR=/usr/local/mpi/openmpi/1.4.5-gcc-4.5
# export DYLD_LIBRARY_PATH=$MPI_DIR/lib:$DYLD_LIBRARY_PATH
# export           MANPATH=$MPI_DIR/man:$MANPATH
#                     PATH=$MPI_DIR/bin:$PATH
export libmesh_CXXFLAGS="-DOMPI_SKIP_MPICXX"
export OMPI_CC=/opt/local/bin/gcc
export OMPI_CXX=/opt/local/bin/g++
export OMPI_FC=/opt/local/bin/gfortran
export OMPI_F77=/opt/local/bin/gfortran

# #########################################
# # PETSc
# #########################################
export PETSC_DIR=/opt/local/lib/petsc
# export PETSC_DIR=/usr/local/petsc/3.1-p8
# export PETSC_ARCH=macosx
export SLEPC_DIR=$PETSC_DIR

#########################################
# Cantera & friends
#########################################
#export CANTERA_DIR=/usr/local/cantera/1.8.x
export CANTERA_DIR=/usr/local/cantera/2.0.x-r1472
export DYLD_LIBRARY_PATH=$CANTERA_DIR/lib:$DYLD_LIBRARY_PATH

export MASA_DIR=/Users/benkirk/codes/fins/contrib/install
export ABLATION_DIR=$MASA_DIR
#export GRVY_DIR=$MASA_DIR

#########################################
# GMV
#########################################
PATH=/usr/local/gmv:$PATH


###############################################################################
# aliases 
###############################################################################
alias ls="ls -G"
alias ll="ls -l"
alias Emacs.Window="/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs"
export EDITOR="/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs"
alias startsocket="rm -f ~/.ssh/sfe.sock; ssh -p 24 -fN sfe-master"

export CHAR_ROOT=$HOME/codes/char
export FINS_ROOT=$HOME/codes/fins
export FINS_USER_OPTIONS="-ksp_monitor_draw -display :0.0 -ksp_right_pc"
# export GRVY_DIR=$FINS_ROOT/contrib/install
export MASA_DIR=$FINS_ROOT/contrib/install
# export ABLATION_DIR=$FINS_ROOT/contrib/install
export LIBMESH_ROOT=$HOME/codes/libmesh
export LIBMESH_DIR=$LIBMESH_ROOT
PATH=$LIBMESH_ROOT/contrib/bin:$PATH
 
opt()   { export METHOD=opt;    export FINS_BUILD_DIR=$FINS_ROOT/$METHOD; export CHAR_BUILD_DIR=$CHAR_ROOT/$METHOD; }
dbg()   { export METHOD=dbg;    export FINS_BUILD_DIR=$FINS_ROOT/$METHOD; export CHAR_BUILD_DIR=$CHAR_ROOT/$METHOD; }
pro()   { export METHOD=pro;    export FINS_BUILD_DIR=$FINS_ROOT/$METHOD; export CHAR_BUILD_DIR=$CHAR_ROOT/$METHOD; }
devel() { export METHOD=devel;  export FINS_BUILD_DIR=$FINS_ROOT/$METHOD; export CHAR_BUILD_DIR=$CHAR_ROOT/$METHOD; }
devel;

# Working directory in Xterm title bar stuff
cd() {
  OLDERPWD="$OLDPWD"
  builtin cd "$@"
  APWD=`pwd`
  CWD=`echo $APWD | sed -e "s;^$HOME;~;" \
                        -e 's;^~/[^/][^/]*/..*/\(..*/\);\.\.\./\1;' \
                        -e 's;^/[^/][^/]*/..*/\(..*/\);\.\.\./\1;'`
}

# mklibmesh() {
#     sourcename=$1
#     filename=`basename $sourcename .C` 
#     echo \`/Users/benkirk/codes/libmesh/contrib/bin/libmesh-config --cxx\` \`/Users/benkirk/codes/libmesh/contrib/bin/libmesh-config --cxxflags --include\` $sourcename -o $filename \`/Users/benkirk/codes/libmesh/contrib/bin/libmesh-config --ldflags\`
#     `/Users/benkirk/codes/libmesh/contrib/bin/libmesh-config --cxx` `/Users/benkirk/codes/libmesh/contrib/bin/libmesh-config --cxxflags --include` $sourcename -o $filename `/Users/benkirk/codes/libmesh/contrib/bin/libmesh-config --ldflags`
# }
 
xsettitle() { 
  builtin echo -n -e "\033]2;$1\007"; 
}

export HISTSIZE=1024
export HISTCONTROL=ignoreboth
 
APWD=`pwd`
CWD=`echo $APWD | sed -e "s;^$HOME_DIR;~;"`
PROMPT_COMMAND='xsettitle "($METHOD) $USER@elfboy: $CWD"'

function cleantime {
    elapsed=$((`date +%s` - 1282740919))
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    #printf "| % 5.f %s\n" $((elapsed / 3600)) hours
    printf "| % 5.f %s\n" $((elapsed / 3600 / 24)) days
    printf "| % 5.f %s\n" $((elapsed / 3600 / 24 / 30)) months
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}


function use_xcode_ony {
    unset PETSC_DIR
    unset MPI_DIR
    unset TBB_DIR
    unset SLEPC_DIR
    unset DYLD_LIBRARY_PATH

    PATH=/Developer/usr/bin:/Applications/Tec360_2010/bin:/Applications/Doxygen.app/Contents/Resources:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/usr/X11/bin
}

PATH=/opt/local/bin:$PATH

# Local Variables:
# mode: shell-script
# End:
