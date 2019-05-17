#!/bin/bash

####################################### EIGEN ANALYSIS #######################################
# Convert File Formats
cd CONVERTF/
./run_convertf.sh

cd ../

# Compute Eigenvectors
cd EIGENSTRAT/
./run_eigenstrat.sh

cd ../

# Compute Population Genetic Statistics
cd POPGEN/
#./run_popgen.sh

cd ../
