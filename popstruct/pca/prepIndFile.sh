#!/usr/bin/env bash

if [ $# != 2 ]; then
   echo "Usage prepIndFile.sh [meta_file] [ind_file]"
   echo -e "\ne.g. meta: fst.metadata.txt "
   echo -e "e.g.  ind: world/CONVERTF/world.ind\n"
else
   meta=${1}
   ind=${2}
   
   awk '{print $1}' ${ind} > ${ind}.ids
   ids=${ind}.ids
   grep -f $ids ${meta} > ${ind/.ind/.fst.ind}
   echo "Done!"
fi
