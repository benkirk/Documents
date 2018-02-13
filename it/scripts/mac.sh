#!/bin/bash

# accept the xcode license if required
#xcodebuild -license

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# by default macports uses rsync to get its port definition, which
# is blocked by the JSC firewall.  This will use https instead.
cat <<EOF >/opt/local/etc/macports/sources.conf
# \$Id: sources.conf 106803 2013-06-08 16:22:39Z larryv@macports.org \$

# MacPorts system-wide configuration file for ports tree sources.
#
# To change how MacPorts fetches base, see rsync_server and rsync_dir in
# macports.conf.

# To add a local source, add a "file://" entry.
#
#   Example: file:///Users/landonf/misc/MacPorts/ports
#
# To prevent a source from synchronizing when \`port sync\` is used,
# append "[nosync]" at the end.
#
#   Example: file:///Users/landonf/misc/MacPorts/ports [nosync]
#
# Note that MacPorts parses source URLs in order; when a port appears in
# multiple sources, it installs the first occurrence. For local sources
# to shadow remote ones, "file://" URLs must come before other URLs.

# A list of rsync mirrors is available at
# https://trac.macports.org/wiki/Mirrors#Portfiles.
#
# If an "rsync://" URL points to a .tar file, a signed .rmd160 file must
# exist in the same directory on the server and will be used to verify
# its integrity.
#
# For proper functionality of various resources (port groups, mirror
# sites, etc.), the primary MacPorts source must always be tagged
# "[default]", even if switched from the default "rsync://" URL.

#rsync://rsync.macports.org/release/tarballs/ports.tar [default]
https://distfiles.macports.org/ports.tar.gz [default]
EOF

#port -d sync

# clean any installed ports
#port -fp clean installed

# clang first - among other things, seesm to install ld64, and that helps
# some more fragile ports work later
port install clang-3.9 clang_select || exit 1

port select --set clang mp-clang-3.9 || exit 1
port select --set python python27 || exit 1

port install emacs-app color-theme-mode.el || exit 1

# set the default gcc
port install gcc6 gcc5 gcc49 gcc_select || exit 1
port select --set gcc mp-gcc5 || exit 1

port install hdf5 +fortran +gcc5 || exit 1

port install openmpi-gcc5 mpi_select || exit 1
port select --set mpi openmpi-gcc5-fortran || exit 1

#port install mpich-gcc5 mpi_select || exit 1
#port select --set mpi mpich-gcc5-fortran || exit 1

port install tbb subversion git +svn  gmake autoconf automake libtool texlive-latex texlive-latex-extra texlive-latex-recommended bash bash-completion texlive-fonts-recommended texlive-fontutils texlive-bin-extra texlive-generic-recommended texlive-math-extra boost eigen3 scons gsl doxygen graphviz gsed dos2unix git-extras vtk || exit 1 # cgal vtk5


# graphics utilities, useful with latex
port install ImageMagick inkscape dia aspell aspell-dict-en || exit 1

# gnuplot
port install gnuplot || exit 1

# cmake - required for lots of new packages (metis, trilinos, etc...)
port install cmake m4 || exit 1

# lua and requisites for lmod
#port install lua lua-luafilesystem luarocks
#luarocks install luaposix

port install libcryptopp || exit 1
#port install synergy

# miscellaneous
port install wget gdb || exit 1

# sshfs
port install sshfs sshfs-gui || exit 1

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# TODO: not working for 10.10 & XCode 6.4 & macports 2.3.3

# gimp & friends
port install gimp gimp-print macfile-gimp macclipboard-gimp || exit 1

# octave and its packages
port install octave +accelerate || exit 1
port install octave-io octave-linear-algebra octave-missing-functions octave-msh octave-optim octave-plot octave-specfun octave-splines octave-statistics octave-strings octave-struct octave-miscellaneous octave-odepkg || exit 1

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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

# # octave installs liblapack.a, which breaks petsc
# # get the system ones here too
# cd /opt/local/lib
# ln -s /usr/lib/libblas.dylib   && ls -l libblas.dylib
# ln -s /usr/lib/liblapack.dylib && ls -l liblapack.dylib
# cd -
