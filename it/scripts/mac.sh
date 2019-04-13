#!/bin/bash

# accept the xcode license if required
#xcodebuild -license

export PATH=/opt/local/bin:/opt/local/sbin:$PATH


port install emacs-app color-theme-mode.el || exit 1

port install clang-8.0 clang-7.0 clang_select || exit 1

port select --set clang mp-clang-8.0
port select --set python2 python27

port install gcc8 gcc7 gcc_select || exit 1
port select --set gcc mp-gcc8

port install hdf5 +gcc8 +fortran || exit 1

# mpi4py, will bring in python37 and mpi-default
port install py27-mpi4py py37-mpi4py || exit 1
port select --set python3 python37
port select --set python python27

port install \
     py27-numpy py27-matplotlib \
     py37-numpy py37-matplotlib  \
     py27-requests py37-requests \
    || exit 1

port install \
     openmpi-default mpich-default \
     openmpi-gcc8 mpich-gcc8 mpi_select || exit 1


port install \
     tbb subversion git +svn  gmake autoconf automake libtool \
     bash bash-completion \
     texlive-latex texlive-latex-extra texlive-latex-recommended \
     texlive-fonts-recommended texlive-fontutils texlive-bin-extra texlive-plain-generic \
     texlive-math-science \
     boost eigen3 scons gsl doxygen graphviz gsed dos2unix git-extras || exit 1 # cgal vtk5


# cmake - required for lots of new packages (metis, trilinos, etc...)
port install cmake m4 || exit 1

# graphics utilities, useful with latex
port install ImageMagick inkscape dia aspell aspell-dict-en || exit 1

# gnuplot
port install gnuplot || exit 1

# misc catchall
port install \
     wget gawk glpk || exit 1

exit 0

# #port -d sync




# # lua and requisites for lmod
# #port install lua lua-luafilesystem luarocks
# #luarocks install luaposix

# port install libcryptopp || exit 1
# #port install synergy

# # miscellaneous
# port install wget gdb || exit 1

# # sshfs
# port install sshfs sshfs-gui || exit 1

# #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# # TODO: not working for 10.10 & XCode 6.4 & macports 2.3.3

# # gimp & friends
# port install gimp gimp-print macfile-gimp macclipboard-gimp || exit 1

# # octave and its packages
# port install octave +accelerate || exit 1
# port install octave-io octave-linear-algebra octave-missing-functions octave-msh octave-optim octave-plot octave-specfun octave-splines octave-statistics octave-strings octave-struct octave-miscellaneous octave-odepkg || exit 1

# #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# cd /opt/local/bin
# # # make symbolic links to MPI commands
# # for file in mpiexec mpicc mpicxx mpif77 mpif90 ; do
# #     ln -sf $file-openmpi-mp $file ; ls -l $file
# # done
# # ln -sf mpiexec mpirun

# # prefer some macports commands
# ln -s gmake make && ls -l make
# ln -s ggdb gdb   && ls -l gdb
# cd -

# # # octave installs liblapack.a, which breaks petsc
# # # get the system ones here too
# # cd /opt/local/lib
# # ln -s /usr/lib/libblas.dylib   && ls -l libblas.dylib
# # ln -s /usr/lib/liblapack.dylib && ls -l liblapack.dylib
# # cd -
