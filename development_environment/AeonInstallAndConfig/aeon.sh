#!/bin/bash 

 export DEBIAN_FRONTEND=noninteractive

 # create AEON home
 sudo mkdir -p /home/aeon
 
 cd /home/aeon
 
 echo "*******************************"
 echo "*   Configuring Environment   *"
 echo "*******************************"
 # Install puppet
 sudo apt-get update
 sudo apt-get install puppet git -y

 echo "************************************************"
 echo "*   Downloading AEON Cloud Messaging modules   *"
 echo "************************************************"

 # Download the code from the repos
 git clone https://github.com/atos-ari-aeon/fiware-cloud-messaging-platform.git
 git clone https://github.com/atos-ari-aeon/fiware-cloud-messaging-dashboard.git
 git clone https://github.com/atos-ari-aeon/fiware-cloud-messaging-api.git
 git clone https://github.com/atos-ari-aeon/fiware-cloud-messaging-events-manager.git
 
 echo "*******************************"
 echo "*   Configuring Environment   *"
 echo "*******************************"

 # Get the installation and config files
 mv ./fiware-cloud-messaging-platform/development_environment/AeonInstallAndConfig/aeonInstall .
 mv ./fiware-cloud-messaging-platform/development_environment/AeonInstallAndConfig/aeonConfiguration .

 # install AEON
 sudo puppet apply --modulepath /home/aeon/aeonInstall/modules /home/aeon/aeonInstall/manifests/main.pp

 echo "Cleaning temporal files..."

 # Delete useless files
 rm -rf ./fiware-cloud-messaging-platform