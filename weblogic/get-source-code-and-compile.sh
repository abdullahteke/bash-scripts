#!/bin/bash

REACT_HOME=/home/oracle/deploy/atek_project/ateke_ui
DEPLOY_HOME=/home/oracle/deploy/ateke_project

echo "==================== Downloading latest ReactUI from Bitbucket  ===================="

cd $REACT_HOME

# if need define proxy settings
export http_proxy=http://1.1.1.1:3128
export https_proxy=http://1.1.1.1:3128

git checkout <branch_name>
git pull https://${userName}:${password}@github.com/abdullahteke/ateke_ui.git
npm run-script build

cp -pr build/* $DEPLOY_HOME/ui/.

cd $DEPLOY_HOME 
zip -r ateke_project.war ui