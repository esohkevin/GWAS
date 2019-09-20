#!/bin/bash

#hapflk

for chr in {1..22}; do

    if [[ -f "flkout/cam-${chr}chr${chr}flk.flk" ]]; then

        echo -e "\e[38;5;40mflkout/cam-${chr}chr${chr}flk.flk already exists! Skipping!\e[0m"

    else

        seq 10 | parallel echo --file boot/cam-{}chr${chr}flk -K 30 --nfit=10 --ncpu=15 -p flkout/cam-{}chr${chr}flk | xargs -P5 -n8 hapflk

    #else
    #   echo -e "\e[38;5;40mflkout/cam-${chr}chr${chr}flk.flk already exists! Skipping!\e[0m"
    fi

done
