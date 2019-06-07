
####################################### EIGEN ANALYSIS #######################################
read -p 'Do you really want to run ./prepWorldPops.sh and ./prepMergedData.sh scripts all over? [y|n]: ' response
if [[ $response == [Yy] ]]; then
#	./prepWorldPops.sh
	
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
	cd EIGENSTRAT/
	
	./run_eigCorrPCA.perl
	
	cd ../

else    echo "Sorry I did not understand your response!"
	echo "Usage: 'y' (yes) 'n' (no)"
fi
