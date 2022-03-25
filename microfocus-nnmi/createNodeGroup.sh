#!/bin/bash
cd /root

while IFS='|' read bina kat
do 
	GROUPNAME=KAMPUS_"$bina"_KAT-"$kat"
	PARENT=KAMPUS_"$bina"
	CMD="/opt/OV/bin/nnmnodegroup.ovpl create -name $GROUPNAME -parent $PARENT -expand false -addToPerfSPIReports true -calculateStatus true -addToViewFilterList true "
	$CMD
done < nodegroup.txt


