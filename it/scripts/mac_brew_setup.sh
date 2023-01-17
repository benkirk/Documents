#!/bin/bash

# for reference
# brew remove --force $(brew list --formula) && brew remove --cask --force $(brew list)

# emacs
brew install --cask emacs --no-quarantine || exit 1

# casks
brew install --cask \
     miniconda \
     gimp \
     docker \
     podman-desktop \
     spotify \
     slack \
     tigervnc-viewer \
     paraview \
     adobe-acrobat-reader \
     google-drive \
     google-earth-pro \
     || exit 1


# autotools, cmake, etc
brew install \
     make \
     autoconf automake libtool m4 \
     cmake cmake-docs \
     gawk gnu-sed \
     git git-extras \
     subversion \
     doxygen graphviz \
     clang-format \
     || exit 1

# llvm
brew install llvm || exit 1

# gcc
brew install gcc || exit 1

export HOMEBREW_CC=gcc-12
export HOMEBREW_CXX=g++-12

# mpi
brew install open-mpi --build-from-source || exit 1

# libraries
brew install \
     boost boost-mpi \
     eigen \
     petsc \
     hdf5 \
     tbb \
     || exit 1

# latex
brew install \
     texlive \
     aspell \
    || exit 1

# graphics tools
brew install \
     svg2pdf svg2png \
    || exit 1

# filesystem utils
brew install \
     rsync \
     gnu-tar \
     dos2unix \
     wget \
     bash bash-completion \
    || exit 1

# developer tools

# container tools

# python
brew install \
     python ipython \
     jupyterlab \
     mpi4py \
    || exit 1

# # miniconnda packages
# # base
# conda install \
#       jupyter \
#       numpy  scipy matplotlib \
#     || exit 1

# conda-forge
#conda install -c conda-forge \
#      numpy scipy \
#      matplotlib \
#      || exit 1
