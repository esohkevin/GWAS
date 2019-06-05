
####################################### EIGEN ANALYSIS #######################################
./prepWorldPops.sh

./prepMergedData.sh

# Convert File Formats
cd CONVERTF/
./run_convertf.sh

cd ../

# Compute Population Genetic Statistics
cd POPGEN/
./run_popgenstats.sh

Rscript fstHeatMap.R

mv *.png ../

cd ../

# Compute PCA
cd EIGENSTRAT/

./run_eigCorrPCA.perl

cd ../


