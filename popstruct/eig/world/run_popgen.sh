
####################################### EIGEN ANALYSIS #######################################
read -p 'Do you really want to run ./prepWorldPops.sh and ./prepMergedData.sh scripts all over? [y|n]: ' response
if [[ $response == [Yy] ]]; then
   if [[ $# == 0 ]]; then
      echo """Usage: ./run_popgen.sh <maf> 
		Please enter at least one MAF value"""
   else
      for maf in $@; do
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
   fi
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

else    echo "Sorry I did not understand your choice!"
	echo "Usage: 'y' (yes) 'n' (no)"
fi
