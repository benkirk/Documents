#########################################
# Modify environment
#########################################
PS1="\$USER@elfboy(\#)$ "

# Pretty ls colors for light text on dark background
export LSCOLORS="Bxfxcxdxcxegedabagacad"

# Matlab-style history
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward


PATH=/Applications/paraview.app/Contents/MacOS:$PATH


#########################################
# Boost
#########################################
export BOOST_DIR=/opt/local
export BOOST_ROOT=$BOOST_DIR

#########################################
# Tecplot
#########################################
#PATH=/Applications/Tecplot\ 360\ EX\ 2015\ R2/Tecplot\ 360\ EX\ 2015\ R2.app/Contents/MacOS:$PATH
PATH=/Applications/Tecplot\ 360\ EX\ 2017\ R1/Tecplot\ 360\ EX\ 2017\ R1.app/Contents/MacOS:$PATH
alias tec360="/Applications/Tecplot\ 360\ EX\ 2017\ R1/Tecplot\ 360\ EX\ 2017\ R1.app/Contents/MacOS/Tecplot\ 360\ EX\ 2017\ R1"

#########################################
# Intel TBB
#########################################
export TBB_DIR=/opt/local

#########################################
# HDF5
#########################################
export HDF5_DIR=/opt/local

#########################################
# MPI
#########################################
# export libmesh_CXXFLAGS="-DOMPI_SKIP_MPICXX"
# export OMPI_CC=/opt/local/bin/gcc
# export OMPI_CXX=/opt/local/bin/g++
# export OMPI_FC=/opt/local/bin/gfortran
# export OMPI_F77=/opt/local/bin/gfortran

#########################################
# PETSc
#########################################
export PETSC_DIR=/opt/aerolab/petsc/3.10.5
export PETSC_ARCH=macosx
#export SLEPC_DIR=/usr/local/slepc/3.5.2

# #########################################
# # Trilinos
# #########################################
# export TRILINOS_DIR=/usr/local/trilinos/11.10.2
# export DYLD_LIBRARY_PATH=$TRILINOS_DIR/lib:$DYLD_LIBRARY_PATH

#########################################
# # Cantera & friends
# #########################################
# export CANTERA_DIR=/opt/aerolab/cantera/2.2.0
# export DYLD_LIBRARY_PATH=$CANTERA_DIR/lib:$DYLD_LIBRARY_PATH

# export MASA_DIR=/Users/benkirk/codes/fins/contrib/install
# #export ABLATION_DIR=$MASA_DIR
# #export GSI_DIR=/Users/benkirk/codes/install/gsi
# #export GRVY_DIR=$MASA_DIR


###############################################################################
# aliases
###############################################################################
alias ls="ls -G"
alias ll="ls -l"
alias Emacs.Window="/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs"
alias make="make --no-print-directory -s"
export EDITOR="/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs"
alias startsocket="rm -f ~/.ssh/sfe.sock; ssh -fN sfe-master"

export CHAR_ROOT=$HOME/codes/char
export FINS_STABLE_ROOT=$HOME/codes/fins
export FINS_ROOT=$FINS_STABLE_ROOT #$HOME/codes/fins.reorder
export FCCHT_ROOT=$HOME/codes/fccht
export FINS_USER_OPTIONS="-ksp_right_pc -ksp_converged_reason"
# export GRVY_DIR=$FINS_ROOT/contrib/install
export MASA_DIR=$FINS_STABLE_ROOT/contrib/install
# export ABLATION_DIR=$FINS_ROOT/contrib/install
export LIBMESH_ROOT=/opt/aerolab/libmesh/1.2.0
export LIBMESH_DIR=$LIBMESH_ROOT
PATH=$LIBMESH_ROOT/contrib/bin:$PATH

opt()   { export METHOD=opt;    export FINS_BUILD_DIR=$FINS_ROOT/$METHOD; export FCCHT_BUILD_DIR=$FCCHT_ROOT/$METHOD; export CHAR_BUILD_DIR=$CHAR_ROOT/$METHOD; }
dbg()   { export METHOD=dbg;    export FINS_BUILD_DIR=$FINS_ROOT/$METHOD; export FCCHT_BUILD_DIR=$FCCHT_ROOT/$METHOD; export CHAR_BUILD_DIR=$CHAR_ROOT/$METHOD; }
pro()   { export METHOD=pro;    export FINS_BUILD_DIR=$FINS_ROOT/$METHOD; export FCCHT_BUILD_DIR=$FCCHT_ROOT/$METHOD; export CHAR_BUILD_DIR=$CHAR_ROOT/$METHOD; }
devel() { export METHOD=devel;  export FINS_BUILD_DIR=$FINS_ROOT/$METHOD; export FCCHT_BUILD_DIR=$FCCHT_ROOT/$METHOD; export CHAR_BUILD_DIR=$CHAR_ROOT/$METHOD; }
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


function use_xcode_only {
    unset PETSC_DIR
    unset MPI_DIR
    unset TBB_DIR
    unset SLEPC_DIR
    unset TRILINOS_DIR
    unset DYLD_LIBRARY_PATH

    PATH=/Developer/usr/bin:/Applications/Tec360_2012r1/bin:/Applications/Doxygen.app/Contents/Resources:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/usr/X11/bin
}

PATH=/opt/local/bin:/opt/local/sbin:$PATH

if (test -d $HOME/codes); then
    export CODES=$HOME/codes
    if (test -d $CODES/dplr); then
        export DPLR_HOME=$CODES/dplr
    fi
    if (test -f $CODES/libmesh/contrib/autotools/bin/automake); then
        PATH=$CODES/libmesh/contrib/autotools/bin:$PATH
    fi
fi


# Local Variables:
# mode: shell-script
# End:
