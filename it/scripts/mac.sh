#!/bin/bash

port install python27

port install git-core +subversion

port install emacs-app color-theme-mode.el

port install openmpi tbb subversion git-core +svn git-extras gcc_select gmake autoconf automake libtool texlive-latex texlive-latex-extra texlive-latex-recommended bash bash-completion texlive-fonts-recommended boost cgal eigen3 scons gsl doxygen graphviz gsed hdf5-18 +fortran +gcc45 clang-3.1 clang_select glpk vtk5

port install petsc slepc

port select gcc mp-gcc45
port select clang mp-clang-3.1

# make symbolic links to OpenMPI commands
mkdir -p /opt/local/var/macports/build/_opt_local_var_macports_sources_svn.macports.org_trunk_dports_science_openmpi/openmpi/work/build/opal/mca/hwloc/hwloc132/hwloc/src
cd /opt/local/bin
for file in mpirun mpicc mpicxx mpif77 mpif90 ; do ln -s open$file $file ; ls -l $file ; done
cd -



