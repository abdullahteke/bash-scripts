#!/bin/bash
cd /opt/scripts/APManagement
 
./getNeighbours.sh 10.133.128.133 #
 
sed -i 's/[\x01-\x1F\x7F]//g' capture.txt
sed -i "s/\[42D                                          \[42D//g" capture.txt
 
cat capture.txt | awk -F' ' '{print $2,$1,$3}' | grep 0006- > apList.csv
rm capture.txt
 
./getNeighbours.sh 10.133.128.135
 
sed -i 's/[\x01-\x1F\x7F]//g' capture.txt
sed -i "s/\[42D                                          \[42D//g" capture.txt
 
cat capture.txt | awk -F' ' '{print $2,$1,$3}' | grep 0006- >> apList.csv
rm capture.txt
 
sort apList.csv > tmp.txt
mv tmp.txt apList.csv
 
KONTROL=""
 
cat /dev/null > apResultList.csv
 
while IFS=' ' read sw ap ip
do
        if [[ $KONTROL == $sw ]]
        then
                echo -n "#$ap" >> apResultList.csv
        else
                echo "" >> apResultList.csv
                echo -n "$sw,AP,$ap" >> apResultList.csv
                KONTROL=$sw
        fi
done < apList.csv
 
sed -i -e "1d" apResultList.csv