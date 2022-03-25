#!/bin/bash

cd /root/scripts/

RESFILE=/root/scripts/int_report.csv
cat /dev/null > $RESFILE 
echo "IP,INTERFACE_NAME" > $RESFILE

while read ip
do

pingResult=`ping -c 2 -W 1 $ip`

if [[ $pingResult == *"64 bytes from"* ]]; 
then 
	./getInterfaceInformation.sh $ip
	sed -i '/^$/d' interfaceInfo.txt
	sed -i 's/[\x01-\x1F\x7F]//g' interfaceInfo.txt
	sed -i "s/\[42D                                          \[42D//g" interfaceInfo.txt

	INTERFACE=""	

	while read line 
	do
		if [[ $line == "interface "* ]]; 
		then
			INTERFACE=`echo $line | awk -F' ' '{print $2}'`	
        	elif [[ $line == *"authentication dot1x"* ]];
		then
			echo "$ip,$INTERFACE" >> $RESFILE		
			continue
		fi
	done < interfaceInfo.txt
fi

done < interfaceDevice.txt

smtp-cli --server=10.133.133.20:25 --mail-from=test@gmail.com --rcpt-to=abdullahteke@gmail.com --subject=deneme2 --missing-modules-ok --attachment=$RESFILE
