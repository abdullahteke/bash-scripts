#!/bin/bash

#_input="upNodeNewList.txt"
_input="tesisNo2.txt"
#_input="test2.txt"

while IFS='.' read -r il ilce
do
	echo $il
	name=$il.$ilce-
	parent=`grep $il iller.txt`
	filter="(customAttrValue like $il.$ilce.* AND customAttrName = TESIS_NO)"
	echo $filter
	
	/opt/OV/bin/nnmnodegroup.ovpl -create -name $name -addToPerfSPIReports true -addToViewFilterList true -calculateStatus true -filter "$filter" -parent $parent 

done < "$_input"
