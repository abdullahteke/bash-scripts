#!/bin/bash
cd /root/scripts

/opt/OV/bin/ovstatus -c > nnmtmp.txt
sed -i -e "1d" nnmtmp.txt


STATUS="NNMSTATUS=OK"

while read line 
do
	ServiceName=`echo $line | awk -F' ' '{print $1}'` 
	ServiceStatus=`echo $line | awk -F' ' '{print $3}'`
	echo $ServiceName:$ServiceStatus
	
        if [ $ServiceStatus != "RUNNING" ] 
	then
		STATUS="NNMSTATUS=NOTOK"
 		#break	
	fi
done <nnmtmp.txt

echo $STATUS
