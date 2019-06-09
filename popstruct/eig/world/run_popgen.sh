
####################################### EIGEN ANALYSIS #######################################
read -p 'Do you really want to run ./prepWorldPops.sh and ./prepMergedData.sh scripts all over? [y|n]: ' response
if [[ $response == [Yy] ]]; then
   for maf in `(seq 0.2 0.04 0.5)`; do
#	./prepWorldPops.sh
	
	./prepMergedData.sh $maf

#	./prepFile.sh $maf
	
	# Convert File Formats
	cd CONVERTF/
	./run_convertf.sh
	
	cd ../
	
	# Compute Population Genetic Statistics
	cd POPGEN/
	./run_popgenstats.sh $maf
	
#	Rscript fstHeatMap.R
	
#	mv *.png ../
	
	cd ../
	
	# Compute PCA
#	cd EIGENSTRAT/
	
#	./run_eigCorrPCA.perl
	
#	cd ../
   done
elif [[ $response == [Nn] ]]; then

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
#	cd EIGENSTRAT/
	
#	./run_eigCorrPCA.perl
	
#	cd ../

else    echo "Sorry I did not understand your response!"
	echo "Usage: 'y' (yes) 'n' (no)"
fi
