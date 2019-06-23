#!/bin/bash

awk '$7==1 {print $2"\t"$3"\t"$4"\t"$5"\t"$6}' worldHBB.frq.strat > singletons.txt
for pop in cam yri esn msl gwd lwk; do
    grep -i ${pop} singletons.txt > ${pop}Sington.txt
    cut -f1 ${pop}Sington.txt > ${pop}Sington.txt
done

# YRI-only singletons
grep -wv -f gwdSington.txt yriSington.txt > tmp1.txt
grep -wv -f mslSington.txt tmp1.txt > tmp2.txt
grep -wv -f lwkSington.txt tmp2.txt > yriOnlySington.txt

# GWD-only singletons
grep -wv -f yriSington.txt gwdSington.txt > tmp1.txt
grep -wv -f mslSington.txt tmp1.txt > tmp2.txt
grep -wv -f lwkSington.txt tmp2.txt > gwdOnlySington.txt

# MSL-only singletons
grep -wv -f gwdSington.txt mslSington.txt > tmp1.txt
grep -wv -f yriSington.txt tmp1.txt > tmp2.txt
grep -wv -f lwkSington.txt tmp2.txt > mslOnlySington.txt

# LWK-only singletons
grep -wv -f gwdSington.txt lwkSington.txt > tmp1.txt
grep -wv -f mslSington.txt tmp1.txt > tmp2.txt
grep -wv -f yriSington.txt tmp2.txt > lwkOnlySington.txt

rm tmp*

for pop in yri msl gwd lwk; do
    grep -f ${pop}OnlySington.txt ../../analysis/updateName.txt > ${pop}OnlySington.rsid.txt
done

