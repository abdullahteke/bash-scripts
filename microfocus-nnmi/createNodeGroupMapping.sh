#!/bin/bash
cd /root

while IFS='|' read bina kat
do 
	GROUPNAME=KAMPUS_"$bina"_KAT-"$kat"
	/opt/OV/bin/nnmnodegroupmapsettings.ovpl create -connType L2 -order 10 -isConnNodeGroups true -isConnNodes true -isL2Conn true -isL2ConnEdit true -isNeighborConn true -isShowIncidents true -nodeGroup $GROUPNAME

done < nodegroup.txt


