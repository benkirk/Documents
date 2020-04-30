#!/bin/bash

nbf=plots.ipynb
[ -f ${nbf} ] && jupyter-3.7 nbconvert \
                             --to=python \
                             --execute \
                             ${nbf} >/dev/null

ls -ltrh
ls -ltrh ~/Downloads/tsp_shareprices.xls
