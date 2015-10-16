#!/bin/bash 

 export DEBIAN_FRONTEND=noninteractive

 # create AEON home
 sudo mkdir -p /home/aeon

 # copy AEON sources to home
 cp aeon.tgz /home/aeon/
 cd /home/aeon
 pwd

 sudo tar -xzf aeon.tgz 

 ls -ltr
 
 # Install puppet
 sudo apt-get update
 sudo apt-get install puppet -y

 sudo apt-get -y install build-essential

 # install AEON
 sudo puppet apply --modulepath /home/aeon/aeonInstall/modules /home/aeon/aeonInstall/manifests/main.pp

 # install Forever
 sudo npm install forever --global


