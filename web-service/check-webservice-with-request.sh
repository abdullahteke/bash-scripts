#!/bin/bash

URL="https://10.10.10.10:8443/ws/ateke_service?wsdl"

SOAP_USER='ateke'
PASSWORD='test123'
AUTHENTICATION="$SOAP_USER:$PASSWORD"

#write request to xml file 
SOAPFILE=request.xml
TIMEOUT=5


http_code=$(curl --insecure --silent --header 'Content-Type: text/xml;charset=UTF-8' --write-out "%{http_code}\n"  --data @"${SOAPFILE}" "${URL}" --connect-timeout $TIMEOUT --output /dev/null)

echo $http_code
