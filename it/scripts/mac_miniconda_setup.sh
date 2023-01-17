#!/bin/bash

conda install -c conda-forge \
      scipy numpy matplotlib \
      pandas pandas-datareader seaborn \
      openpyxl \
      requests-cache \
      ipywidgets \
    || exit 1

#exit 0


/usr/local/bin/pip3 \
    install \
    pip-search \
    || exit 1

/usr/local/bin/pip3 \
    install \
    scipy numpy matplotlib \
    pandas pandas-datareader seaborn \
    openpyxl \
    requests-cache \
    || exit 1

/usr/local/bin/pip3 \
    install \
    ipywidgets ipywidgets-extended \
    || exit 1

/usr/local/bin/pip3 \
    install \
    bash_kerel \
    && /usr/local/bin/python3 -m bash_kernel.install \
    || exit 1

/usr/local/bin/pip3 \
    list \
    || exit 1
