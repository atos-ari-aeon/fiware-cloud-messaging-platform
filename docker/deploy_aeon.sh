#! /bin/bash

git clone -b docker https://github.com/atos-ari-aeon/fiware-cloud-messaging-dashboard.git
git clone -b docker https://github.com/atos-ari-aeon/fiware-cloud-messaging-api.git
git clone -b docker https://github.com/atos-ari-aeon/fiware-cloud-messaging-events-manager.git

docker-compose -p aeon up
