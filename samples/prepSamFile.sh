#!/usr/bin/env bash

#--- Test while printing messages
for i in $(awk '{print $2}' sam1244.ids); do 
    if [[ -z "$(grep -w $i malgenCP1_Bu.txt)" ]]; then 
       echo "$i has no corresponding ID in malgenCP1_Bu.txt file"; 
    else 
       echo -e "$i\t$(grep -w $i malgenCP1_Bu.txt)";
    fi; 
done | grep -v " has no corresponding ID" > malgenCP1_Full.txt

#--- Do not print message
for i in $(awk '{print $2}' sam1244.ids); do 
    if [[ ! -z "$(grep -w $i malgenCP1_Bu.txt)" ]]; then 
       echo -e "$i\t$(grep -w $i malgenCP1_Bu.txt)";
    fi; 
done > malgenCP1_Full.txt
