#!/bin/bash

#set -x

ofile=tsp_shareprices.xls

# Make all if ${ofile} does not exist
[ -f ${ofile} ] || make all

# If a recent ${ofile} exists, bail
t_min=$((10 * 1))
ffile="$(find . -type f -mmin -${t_min} -name ${ofile} -print)"

#echo $ffile
#echo "x${ffile}" "x./${ofile}"

[ "x${ffile}" == "x./${ofile}" ] &&  { echo -n "Recent ${ffile}: " ; ls -l ${ffile}; exit 0; }

echo "No recent ${ofile}"
rm -f ${ofile}
make ${ofile}
exit 0
