#!/bin/bash


for i in `ls -al seeds/*.txt | awk '{print $9}' | gawk -F/ '{ print $2}'`;
do
	echo $i
	/opt/OV/bin/nnmloadseeds.ovpl -f seeds/$i 
	echo "$i file processed " >> log.txt
	rm -rf seeds/$i
	sleep 1200
done  
