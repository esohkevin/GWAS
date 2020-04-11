#!/bin/bash

for i in $(cat list.txt); do
	wget -c ${i}
done
