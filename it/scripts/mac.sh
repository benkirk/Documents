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

port install python27

port install git-core +subversion

port install emacs-app color-theme-mode.el

# compilers, mpi, latex, & development libraries
port install openmpi tbb subversion git-core +svn git-extras gcc_select gmake autoconf automake libtool texlive-latex texlive-latex-extra texlive-latex-recommended bash bash-completion texlive-fonts-recommended texlive-fontutils boost cgal eigen3 scons gsl doxygen graphviz gsed hdf5-18 +fortran +gcc45 clang-3.1 clang_select glpk vtk5 ImageMagick

# set the default gcc and clang
port select gcc mp-gcc45
port select clang mp-clang-3.1

# petsc
port install petsc slepc

# octave and its packages
port install octave octave-general octave-gsl octave-image octave-io octave-linear-algebra octave-missing-functions octave-msh octave-optiminterp octave-optim octave-plot octave-specfun octave-splines octave-statistics octave-strings octave-struct octave-physicalconstants octave-odepkg


# make symbolic links to OpenMPI commands
mkdir -p /opt/local/var/macports/build/_opt_local_var_macports_sources_svn.macports.org_trunk_dports_science_openmpi/openmpi/work/build/opal/mca/hwloc/hwloc132/hwloc/src
cd /opt/local/bin
for file in mpirun mpicc mpicxx mpif77 mpif90 ; do ln -s open$file $file ; ls -l $file ; done
cd -



