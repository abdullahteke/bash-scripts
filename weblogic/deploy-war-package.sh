#!/bin/bash

WAR_URI=http://xxx.xxx.xxx.xxxx/jenkins/job/<project>/job/<project_build>/ws/target/ateke_project.war

DEPLOY_HOME=/home/oracle/deploy/ateke_project
PACKAGE_PATH=$DEPLOY_HOME/deployPackages
DOMAIN_HOME=/u01/app/oracle/config/domains/ateke_domain/
WAR_FILE=ateke_project.war.orig

WLS_USER=abdullahteke
WLS_PASS=test123

WLS_ADMIN_URL=http://10.10.10.10:7001
WLSJAR=/u01/app/oracle/product/12.2.1/wlserver/server/lib/weblogic.jar

DEPLOYMENT_NAME=ateke_project

read -p 'Username: ' userName
read -sp 'Password: ' password

cd $DEPLOY_HOME

echo "========================================================================"

echo "==================== Downloading war file from jenkins ===================="

curl --noproxy -v -u "$userName:$password" $WAR_URI -L -o $WAR_FILE

echo "==========================================================================="

echo "=========================================================================="

cd $DEPLOY_HOME
cp -pr $WAR_FILE ateke_project.war

echo "======================================================================================"

echo "==================== STOPPING $DEPLOYMENT_NAME ===================="

java -cp $WLSJAR weblogic.Deployer -adminurl $WLS_ADMIN_URL  -username $WLS_USER -password $WLS_PASS -stop -name $DEPLOYMENT_NAME

echo "===================================================================="

echo "==================== MOVE & BACKUP Old War File for $DEPLOYMENT_NAME ===================="
cd $DOMAIN_HOME
TIME=`date +"%Y-%m.%d_%H:%M"`
mv ateke_project.war ateke_project-$TIME.war
cp $DEPLOY_HOME/ateke_project.war .
mv  $DEPLOY_HOME/ateke_project.war $PACKAGE_PATH/.
echo "======================================================================================="

echo "====================  UPDATE & START $DEPLOYMENT_NAME ===================="

java -cp $WLSJAR weblogic.Deployer -adminurl $WLS_ADMIN_URL -username $WLS_USER -password $WLS_PASS -redeploy -name $DEPLOYMENT_NAME -source ateke_project.war
java -cp $WLSJAR weblogic.Deployer -adminurl $WLS_ADMIN_URL -username $WLS_USER -password $WLS_PASS -start -name $DEPLOYMENT_NAME