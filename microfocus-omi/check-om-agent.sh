#!/bin/bash
cd /root/scripts
 
/opt/OV/bin/ovc -status > tmp.txt
 
 
STATUS="OVCSTATUS=OK"
 
RESULT=`find /var/opt/OV/tmp/OpC/ -type f -size +1M`
 
if [[ -n $RESULT ]]
then
        STATUS="OVCSTATUS=NOTOK"
        /opt/OV/bin/ovc -kill
        rm -rf /var/opt/OV/tmp/OpC/*
        /opt/OV/bin/ovc -start
 
fi
 
while read line
do
        ServiceName=`echo $line | awk -F' ' '{print $1}'`
        ServiceStatus=`echo $line | awk 'NF>1{print $NF}'`
 
        if [ $ServiceStatus != "Running" ]
        then
                STATUS="OVCSTATUS=NOTOK"
                /opt/OV/bin/ovc -start
                break
        fi
done <tmp.txt
 
echo $STATUS