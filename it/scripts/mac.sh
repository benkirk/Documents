#!/bin/bash


#xcodebuild -license
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# # Setup macports to use a local port config instead of rsync'ing
# # the source, so it works on site
# cd /opt/local/var/macports/sources
# mkdir -p svn.macports.org/trunk/dports
# cd svn.macports.org/trunk/dports 
# svn co http://svn.macports.org/repository/macports/trunk/dports/ .
# 
# cp /opt/local/etc/macports/sources.conf /opt/local/etc/macports/sources.conf.orig 
# cat << EOF >/opt/local/etc/macports/sources.conf
# #  MacPorts system wide sources configuration file
# #  $Id: sources.conf 79599 2011-06-19 21:18:18Z jmr@macports.org $
# 
# #  To setup a local ports repository, insert a "file://" entry following
# #  the example below that points to your local ports directory:
# #  Example: file:///Users/landonf/misc/MacPorts/ports
# 
# #  The default MacPorts repository should always be tagged [default]
# #  for proper functionality of various resources (port groups, mirror
# #  sites, etc).  If you switch it from the rsync:// URL, be sure to keep
# #  it tagged [default].
# 
# #  To prevent a source from synchronizing when `port sync` is used,
# #  append [nosync] at the end as shown in this example:
# #  Example: file:///Users/landonf/misc/MacPorts/ports [nosync]
# 
# #  NOTE: The port command parses source URLs in order and installs the
# #        first occurrance when a port appears in multiple repositories.
# #        So keep "file://" URLs above other URL types.
# 
# 
# #  To get the ports tree from the master MacPorts server in California, USA use:
# #      rsync://rsync.macports.org/release/ports/
# #  To get it from the mirror in Trondheim, Norway use:
# #      rsync://trd.no.rsync.macports.org/release/ports/
# #  A current list of mirrors is available at https://trac.macports.org/wiki/Mirrors
# 
# # If an rsync URL points to a .tar file, a signed .rmd160 must exist next to
# # it on the server and will be used to verify its integrity.
# 
# #rsync://rsync.macports.org/release/tarballs/ports.tar [default]
# file:///opt/local/var/macports/sources/svn.macports.org/trunk/dports/ [default]
# 
# EOF
# 
# port -d sync 

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
port install clang-3.1 clang-3.2 clang_select
port select clang mp-clang-3.1

port install emacs-app color-theme-mode.el

# mpi, latex, & development libraries
port install openmpi tbb subversion git-core +svn git-extras gmake autoconf automake libtool texlive-latex texlive-latex-extra texlive-latex-recommended bash bash-completion texlive-fonts-recommended texlive-fontutils texlive-bin-extra texlive-generic-recommended boost cgal eigen3 scons gsl doxygen graphviz gsed vtk5 dos2unix valgrind

# set the default gcc
port install gcc45 gcc_select 
port select gcc mp-gcc45

port install hdf5-18 +fortran +gcc45

# graphics utilities, useful with latex
port install ImageMagick inkscape dia aspell aspell-dict-en

# petsc
port install petsc slepc

# gnuplot
port install gnuplot

# lua and requisites for lmod
port install lua lua-luafilesystem luarocks
luarocks install luaposix

port install synergy

# octave and its packages
port install octave octave-general octave-gsl octave-io octave-linear-algebra octave-missing-functions octave-msh octave-optim octave-plot octave-specfun octave-splines octave-statistics octave-strings octave-struct octave-physicalconstants octave-odepkg

# gimp & friends
port install gimp2 gimp-print macfile-gimp macclipboard-gimp

# make symbolic links to OpenMPI commands
mkdir -p /opt/local/var/macports/build/_opt_local_var_macports_sources_svn.macports.org_trunk_dports_science_openmpi/openmpi/work/build/opal/mca/hwloc/hwloc132/hwloc/src
cd /opt/local/bin
for file in mpirun mpicc mpicxx mpif77 mpif90 ; do 
    ln -s open$file $file ; ls -l $file 
done
# prefer some macports commands
ln -s gln ln && ls -l ln
cd -

# octave installs liblapack.a, which breaks petsc
# get the system ones here too
cd /opt/local/lib
ln -s /usr/lib/libblas.dylib   && ls -l libblas.dylib
ln -s /usr/lib/liblapack.dylib && ls -l liblapack.dylib
cd -






