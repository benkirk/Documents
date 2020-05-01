#!/bin/bash

#set -x

export PATH=/opt/local/bin:$PATH

ofile=tsp_shareprices.xls

# Make all if ${ofile} does not exist
[ -f ${ofile} ] || make ${ofile}

# If a recent ${ofile} exists, bail
t_min=$((5 * 60))
ffile="$(find . -type f -mmin -${t_min} -name ${ofile} -print)"

#echo $ffile
#echo "x${ffile}" "x./${ofile}"

[ "x${ffile}" == "x./${ofile}" ] &&  { echo -n "Recent ${ffile}: " ; ls -l ${ffile}; exit 0; }

echo "No recent ${ofile}" | tee build.out
rm -f ${ofile}
make ${ofile} | tee -a build.out

exit 0
