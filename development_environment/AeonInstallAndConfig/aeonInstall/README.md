# AEON platform development environment: Puppet script.

## This Puppet Manifest will install:

* RabbitMQ (3.1.2)
* MongoDB (2.4.8)
* nodejs (0.10.38)

* wget
* git
* vim 
* htop
* g++


sudo puppet apply --modulepath /home/aeon/aeonInstall/modules /home/aeon/aeonInstall/manifests/main.pp

## Authors:

Elisa Herrmann <elisa.herrmann@atos.net>
