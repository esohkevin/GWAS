#!/bin/bash

for i in $(cat add.files)
do
	git add -f ${i}
done

