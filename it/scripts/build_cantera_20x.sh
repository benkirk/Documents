#!/bin/bash

version=2.0.2
cantera_version=cantera-$version

oldcomp=foo

source /etc/bashrc

for compiler in intel/12.1.0 intel/13.0 gcc/4.4.6 gcc/4.5.3 gcc/4.6.2 gcc/4.7.2 ; do

    module unload $oldcomp
    module load $compiler
    oldcomp=$compiler
    
    echo $COMPILER_ID_STRING
    
    case "$COMPILER_ID_STRING" in
	gcc*)
	    export CXX=g++
	    export CC=gcc
	    export F77=gfortran
	    export F90=gfortran
	    export FC=gfortran
	    ;;

	intel*)
	    export CXX=icpc
	    export CC=icc
	    export F77=ifort
	    export F90=ifort
	    export FC=ifort
	    ;;
	
	pgi*)
	    export CC=pgcc
	    export CXX=pgCC
	    export F77=pgf77
	    export F90=pgf90
	    export FC=pgf90
	    ;;

	*)
	    echo "Unknown COMPILER_VENDOR:$COMPILER_VENDOR"
	    exit 1
    esac
    
    cd /tmp ; rm -rf cantera ; wget http://cantera.googlecode.com/files/cantera-$version.tar.gz
    tar zxf cantera-$version.tar.gz
    cd $cantera_version
        
    CANTERA_PREFIX=/software/x86_64/cantera/$version-$COMPILER_ID_STRING
    echo $CANTERA_PREFIX
    scons clean
    scons build CXX=$CXX CC=$CC F90=$F90 optimize=y prefix=$CANTERA_PREFIX python_package=none matlab_toolbox=n env_vars=all
    scons test
    
    rm -rf $CANTERA_PREFIX
    scons install
    
    # Create a module
    mkdir -p $MODULEPATH_ROOT/Compiler/$COMPILER_VENDOR/$COMPILER_VERSION/cantera
    cd $MODULEPATH_ROOT/Compiler/$COMPILER_VENDOR/$COMPILER_VERSION/cantera
    ln -s 2.0.0b1-r1472.lua default
    cd -
    
    cat <<EOF >$MODULEPATH_ROOT/Compiler/$COMPILER_VENDOR/$COMPILER_VERSION/cantera/$version.lua
setenv       ('CANTERA_DIR',     '/software/x86_64/cantera/$version-$COMPILER_ID_STRING')
setenv       ('CANTERA_ROOT',    '/software/x86_64/cantera/$version-$COMPILER_ID_STRING')
prepend_path ('LD_LIBRARY_PATH', '/software/x86_64/cantera/$version-$COMPILER_ID_STRING/lib')
EOF

done

# revert ownership to software
chown -R software:eg3 $MODULEPATH_ROOT /software/x86_64/cantera
