#!/bin/bash

####################### CHR 1 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..252000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr1intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

####################### CHR 2 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..246000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr2intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

####################### CHR 3 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..202000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr3intervals.txt
rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

####################### CHR 4 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..194000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr4intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

####################### CHR 5 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..185000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr5intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

####################### CHR 6 #######################
rm intervaltemp.txt; 						# Remove all temporary files
rm interval.txt; 


for i in {1..174000000..2000000}; do 				# Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt			# Delet the first line in one of the temp files

paste interval.txt interval2.txt > chr6intervaltemp.txt		# Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chr6intervaltemp.txt > chrintervaltemp2.txt		# Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr6intervals.txt

rm chr6intervaltemp.txt						# Remove the last temp file created



####################### CHR 7 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..163000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr7intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

####################### CHR 8 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..149000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr8intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt


###################### CHR 9 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..142000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr9intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 10 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..137000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr10intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 11 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..139000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr11intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 12 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..137000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr12intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 13 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..118000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr13intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 14 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..111000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr14intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 15 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..106000000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr15intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 16 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..92200000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr16intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 17 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..85200000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr7intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 18 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..82200000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr19intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 19 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..60200000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr19intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 20 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..66200000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr20intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 21 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..48200000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr21intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

###################### CHR 22 #######################
rm intervaltemp.txt;                                            # Remove all temporary files
rm interval.txt;

for i in {1..52200000..2000000}; do                            # Make two temporary files holding the numbers column-wise
    echo $i >> interval.txt
    echo $(( $i-1 )) >> intervaltemp.txt
done

sed '1d' intervaltemp.txt > interval2.txt                       # Delet the first line in one of the temp files

paste interval.txt interval2.txt > chrintervaltemp1.txt         # Paste the two files, the one with the deleted first line coming second

sed 's/\t/=/g' chrintervaltemp1.txt > chrintervaltemp2.txt         # Replace the 'tab' delimiter in the file with an '=' sign

head -n -1 chrintervaltemp2.txt > chr22intervals.txt

rm chrintervaltemp1.txt; rm chrintervaltemp2.txt

