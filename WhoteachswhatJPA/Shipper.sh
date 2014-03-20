#!/bin/bash
#  Developer Name: Zakeria Hassan <zak.hassan1010@gmail.com>
#  Date: MAR 12, 2014
#  LICENSE: GNU


#BUILD PROJECT
echo "BUILD STARTED"

mvn clean install
echo "BUILD COMPLETE"

#RENAME WAR TO ROOT.war
mv ./target/WhoteachswhatJPA.war  ./target/ROOT.war
echo "BUILD RENAMING TO ROOT.war to display on ROOT context"

#UPLOADING WAR FILE TO SERVER
rsync -av --progress --inplace --rsh='ssh -p9134' target/ROOT.war student@zenit.senecac.on.ca:/home/student/jboss-as-7.1.1.Final/standalone/deployments/
echo "UPLOAD COMPLETE";
if [ "$?" != 0 ]; then
  echo "YOUR NOT CONNECTED TO THE INTERNET!!";
fi


#PROMPT COMPLETE
echo -n "UPLOADED WEBAPP ON: " ; date

