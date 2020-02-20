#!/bin/bash

#--- Run fastPhase with only 1 EM run and assess cross-validation error (K-parameter)

seq 1 5 | parallel echo -T1 -F -KL10 -KU30 -Ki5 -oMyresults mydata.chr-{}.recode.phase.inp | xargs -P5 -n7 fastPHASE
