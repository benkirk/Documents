#!/bin/bash

# First install:
# --------------
#
#
#

# To update:
# ----------
#  cd /opt/local/var/macports/sources/svn.macports.org/trunk/dports/
#  sudo svn up
#  sudo port sync -d
#  sudo port upgrade outdated


# clang first - among other things, seesm to install ld64, and that helps
# some more fragile ports work later
port install clang-3.1 clang_select
port select clang mp-clang-3.1

port install emacs-app color-theme-mode.el

# compilers, mpi, latex, & development libraries
port install gcc45 gcc_select 

port install openmpi tbb subversion git-core +svn git-extras gmake autoconf automake libtool texlive-latex texlive-latex-extra texlive-latex-recommended bash bash-completion texlive-fonts-recommended texlive-fontutils texlive-bin-extra texlive-generic-recommended boost cgal eigen3 scons gsl doxygen graphviz gsed vtk5 dos2unix

# set the default gcc
port select gcc mp-gcc45

port install hdf5-18 +fortran +gcc45

# graphics utilities, useful with latex
port install ImageMagick inkscape dia aspell aspell-dict-en

# petsc
port install petsc slepc

# gnuplot
port install gnuplot

# octave and its packages
#port install octave octave-general octave-gsl octave-io octave-linear-algebra octave-missing-functions octave-msh octave-optim octave-plot octave-specfun octave-splines octave-statistics octave-strings octave-struct octave-physicalconstants octave-odepkg

# make symbolic links to OpenMPI commands
mkdir -p /opt/local/var/macports/build/_opt_local_var_macports_sources_svn.macports.org_trunk_dports_science_openmpi/openmpi/work/build/opal/mca/hwloc/hwloc132/hwloc/src
cd /opt/local/bin
for file in mpirun mpicc mpicxx mpif77 mpif90 ; do 
    ln -s open$file $file ; ls -l $file 
done
# prefer some macports commands
ln -s gln ln && ls -l ln
cd -




