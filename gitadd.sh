#!/bin/bash

cut -f2 -d':' files.txt | sed 's/ //g' > add.files

for i in $(cat add.files)
do
	git add -f ${i}
done

