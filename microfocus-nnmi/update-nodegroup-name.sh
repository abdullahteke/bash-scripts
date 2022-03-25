#!/bin/bash

_input="ilceson.txt"

while IFS='.' read -r city town name 
do
	old_name=$city.$town-
	new_name=$city.$town-$name

	/opt/OV/bin/nnmnodegroup.ovpl -update -group $old_name -name $new_name

done < "$_input"
