#!/bin/bash
cd /root/scripts

RESULT=`find /var/opt/OV/tmp/OpC/ -type f -size +1M`
 
if [[ -n $RESULT ]]
then
        echo "NOTOK"
        /opt/OV/bin/ovc -kill
        rm -rf /var/opt/OV/tmp/OpC/*
fi
 
/opt/OV/bin/ovc -start
exit 0