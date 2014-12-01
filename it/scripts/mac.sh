#!/bin/bash


# # xcodebuild -license

export PATH=/opt/local/bin:/opt/local/sbin:$PATH


# clang first - among other things, seesm to install ld64, and that helps
# some more fragile ports work later
port install clang-3.5 clang_select

port select --set clang mp-clang-3.5
port select --set python python27

port install emacs-app color-theme-mode.el

# set the default gcc
port install gcc49 gcc_select
port select --set gcc mp-gcc49

port install hdf5 +fortran +gcc49

# mpi, latex, & development libraries
port install openmpi-gcc49 mpi_select
port select --set mpi openmpi-gcc49-fortran

port install tbb subversion git +svn  gmake autoconf automake libtool texlive-latex texlive-latex-extra texlive-latex-recommended bash bash-completion texlive-fonts-recommended texlive-fontutils texlive-bin-extra texlive-generic-recommended texlive-math-extra boost eigen3 scons gsl doxygen graphviz gsed dos2unix vtk5 cgal git-extras

# petsc
#port install petsc slepc

# graphics utilities, useful with latex
port install ImageMagick inkscape dia aspell aspell-dict-en

# gnuplot
port install gnuplot

# lua and requisites for lmod
#port install lua lua-luafilesystem luarocks
#luarocks install luaposix

port install libcryptopp
# port install synergy

# octave and its packages
port install atlas +gcc49
port install octave +gcc49
port install octave-general octave-gsl octave-io octave-linear-algebra octave-missing-functions octave-msh octave-optim octave-plot octave-specfun octave-splines octave-statistics octave-strings octave-struct octave-physicalconstants octave-odepkg

# miscellaneous
port install wget gdb

# gimp & friends
port install gimp2 gimp-print macfile-gimp macclipboard-gimp


cd /opt/local/bin
# # make symbolic links to MPI commands
# for file in mpiexec mpicc mpicxx mpif77 mpif90 ; do
#     ln -sf $file-openmpi-mp $file ; ls -l $file
# done
# ln -sf mpiexec mpirun

# prefer some macports commands
ln -s gmake make && ls -l make
ln -s ggdb gdb   && ls -l gdb
cd -

# octave installs liblapack.a, which breaks petsc
# get the system ones here too
cd /opt/local/lib
ln -s /usr/lib/libblas.dylib   && ls -l libblas.dylib
ln -s /usr/lib/liblapack.dylib && ls -l liblapack.dylib
cd -
