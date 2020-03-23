#!/usr/bin/env bash

if [ $# != 2 ]; then
   echo "Usage: ./merge_vcfs.sh <flist> <out_file_name>"
   echo "flist: List containng file names to merge, one per line"

else
   flist=$1; ofile=$2;
   for i in $(cat ${flist}); do echo $i; done | parallel bcftools index -f -t {}
   bcftools merge \
      -m none \
      -Oz \
      -o ${ofile} \
      --threads 30 \
      -l ${flist}
fi
