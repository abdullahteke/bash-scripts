#!/bin/bash
cd /root

while IFS='|' read bina kat ip
do 
	GROUPNAME=KAMPUS_"$bina"_KAT-"$kat"
	PARENT=KAMPUS_"$bina"
	/opt/OV/bin/nnmnodegroup.ovpl add -group $GROUPNAME -node $ip 

done < nodes.txt


