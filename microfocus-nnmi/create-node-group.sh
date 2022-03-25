#!/bin/bash

_input="tesisNo.txt"

while IFS='.' read -r name 
do
    echo $il.$ilce >> abc.txt
    /opt/OV/bin/nnmnodegroup.ovpl -create -name $name -addToPerfSPIReports true -addToViewFilterList true -calculateStatus true -parent PARENT_GROUP
done < "$_input"