#! /bin/bash

git clone -b docker https://github.com/atos-ari-aeon/fiware-cloud-messaging-dashboard.git
git clone -b docker https://github.com/atos-ari-aeon/fiware-cloud-messaging-api.git
git clone -b docker https://github.com/atos-ari-aeon/fiware-cloud-messaging-events-manager.git

sudo apt-get update
sudo apt-get install docker.io curl python-pip -y

pip install -U docker-compose


docker-compose -p aeon up
