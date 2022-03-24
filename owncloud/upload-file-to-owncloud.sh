#!/bin/bash

FILE_PATH=/home/oracle/deploy/deployPackages
FILE=$FILE_PATH/ateke_project.war

OWNCLOUD_URL="https://10.10.10.10/remote.php/webdav/ateke_dir"

read -p 'Username: ' username
read -sp 'Password: ' password

cd $FILE_PATH

echo "### Uploding $FILE to owncloud"
curl --noproxy -v -k -u $username:$password --upload-file "$FILE" "$OWNCLOUD_URL/$FILE"
echo "### Completed uploding $FILE to owncloud"
