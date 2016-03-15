#!/bin/bash

 export DEBIAN_FRONTEND=noninteractive

 # Install git & puppet
 sudo apt-get update
 sudo apt-get install puppet git -y

 # create AEON home
 sudo mkdir -p /home/aeon

 cp -r aeonInstall /home/aeon
 cp -r aeonConfiguration /home/aeon

 cd /home/aeon

 echo "************************************************"
 echo "*   Downloading AEON Cloud Messaging modules   *"
 echo "************************************************"

 # Download the code from the repos
 git clone https://github.com/atos-ari-aeon/fiware-cloud-messaging-dashboard.git
 git clone https://github.com/atos-ari-aeon/fiware-cloud-messaging-api.git
 git clone https://github.com/atos-ari-aeon/fiware-cloud-messaging-events-manager.git


 echo "*******************************"
 echo "*   Configuring Environment   *"
 echo "*******************************"

 mv fiware-cloud-messaging-dashboard aeon-dashboard
 mv fiware-cloud-messaging-api aeon-api
 mv fiware-cloud-messaging-events-manager aeon-events-manager

 # install AEON
 sudo puppet apply --modulepath /home/aeon/aeonInstall/modules /home/aeon/aeonInstall/manifests/main.pp

 echo "Cleaning temporal files..."

 # Delete useless files
 rm -rf ./fiware-cloud-messaging-platform
