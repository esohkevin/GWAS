#!/bin/bash

###############################################################################################
##											     ##
##			Script to Run the entire CamGwas Pipeline			     ##
##											     ##
###############################################################################################

############################################ PATHS ############################################
#
base="`pwd`"
analysis="${base}analysis/"
assocResults="${base}assoc_results/"
popstruct="${base}popstruct/eig/"
phase="${base}phase/"
1kgp="${base}1000G/"
images="${base}images/"
michigan="${base}michigan/"
samger="${base}sanger/"
samples="${base}samples/"
#
############################################### QC ############################################
#
cd ${analysis}

./qc-pipline.sh

cd ${popstruct}
#
####################################### Population Structure ##################################
#
./run_eigstruct.sh

cd ${analysis}
#
################################ Prepare Dataset for Imputation ###############################
#
./imputPrep.sh

cd ${phase}
#
##################################### Phasing and Imputation ##################################
#
./run_phasImput.sh

