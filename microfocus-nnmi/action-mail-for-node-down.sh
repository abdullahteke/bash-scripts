#!/bin/bash

ID=$(/usr/bin/uuidgen -r)
touch /var/opt/OV/shared/nnm/actions/tmp/$ID.email
touch /var/opt/OV/shared/nnm/actions/tmp/$ID.sms

EMAIL="/var/opt/OV/shared/nnm/actions/tmp/$ID.email"

FROM="hp-nnmi-fw@gmail.com"
TO="BTAgGuvenlik@gmail.com"

#INCTIME=$1
INCTIME=`date +"%d.%m.%Y %H:%M"`
INCNAME=$2
NODEUUID=$3
LIFECYCLE=$4
NODENAME=$5
NODEIP=$6
NODELOCATION=$7
MSG=$8
#SEV=$9


echo "<html>" >> $EMAIL

if [ "$LIFECYCLE" == com.hp.nms.incident.lifecycle.Registered ]; then 
	echo "<table bgcolor=red>" >> $EMAIL
	SUBJ=$MSG."  : ".$NODENAME  
	MSG="$MSG  "
	SEV=$9
else 
	echo "<table bgcolor='green'>" >> $EMAIL
	SUBJ=$MSG."  : ".$NODENAME 
	MSG="$MSG  ."
	SEV="Normal"
fi

echo "<tr>" >> $EMAIL
echo "<td><font color=white>Tarih</font></td>" >> $EMAIL
echo "<td><font color=white>: "$INCTIME"</font></td>" >> $EMAIL
echo "</tr>" >> $EMAIL

echo "<tr>" >> $EMAIL
echo "<td><font color=white>Severity</font></td>" >> $EMAIL
echo "<td><font color=white>: "$SEV"</font></td>" >> $EMAIL
echo "</tr>" >> $EMAIL

echo "<tr>" >> $EMAIL
echo "<td><font color=white>Cihaz Adi</font></td>" >> $EMAIL
echo "<td><font color=white>: "$NODENAME"</font></td>" >> $EMAIL
echo "</tr>" >> $EMAIL

echo "<tr>" >> $EMAIL
echo "<td><font color=white>Cihaz IP</font></td>" >> $EMAIL
echo "<td><font color=white>: "$NODEIP"</font></td>" >> $EMAIL
echo "</tr>" >> $EMAIL

echo "<tr>" >> $EMAIL
echo "<td><font color=white>Cihaz Lokasyon</font></td>" >> $EMAIL
echo "<td><font color=white>: "$NODELOCATION"</font></td>" >> $EMAIL
echo "</tr>" >> $EMAIL

echo "<tr>" >> $EMAIL
echo "<td><font color=white>Alarm</font></td>" >> $EMAIL
echo "<td><font color=white>:"$MSG"</font></td>" >> $EMAIL
echo "</tr>" >> $EMAIL


echo "</table>" >> $EMAIL

echo "</html>" >> $EMAIL


cd /var/opt/OV/shared/nnm/actions/


mutt -e 'set content_type="text/html"' $TO -s $SUBJ <  $EMAIL


rm -f $EMAIL
exit;
