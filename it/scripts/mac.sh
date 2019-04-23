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
     wget gawk glpk gnutar || exit 1

exit 0
