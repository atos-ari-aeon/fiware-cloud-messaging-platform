#! /bin/bash

git clone -b docker http://gitlab.atosresearch.eu/ari/aeon-dashboard.git
git clone -b docker http://gitlab.atosresearch.eu/ari/aeon-api.git
git clone -b docker http://gitlab.atosresearch.eu/ari/aeon-events-manager.git

docker-compose -p aeon up
