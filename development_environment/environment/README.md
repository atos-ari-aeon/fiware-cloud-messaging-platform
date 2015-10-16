# AEON platform development environment.

This is a vagrant box for developing AEON platform.


## Puppet Manifest will install:

* RabbitMQ (3.1.2)
* MongoDB (2.4.8)
* nodejs (0.10.38)

* wget
* git
* vim 
* htop
* g++


## Requires:

* [Virtual Box](http://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/)
  Create ~/Projects and ~/data folders for sharing files with guest environment. 
* Git


## Setting up the environment

* Download this project:

```bash
    $ git clone -b development_environment git@192.168.252.30:ari/aeon-platform.git
```

## Using it:

* Running:

```bash
    $ cd aeon-platform/development_environment/environment/
    $ vagrant up
```

* Connecting:

```bash
    $ vagrant ssh
```

* Stoping:

```bash
    $ vagrant halt
```

* Others:

```bash
    $ vagrant provision
    $ vagrant destroy
```

* Accessing mongo from your machine:

    **localhost 27017**

    *attention: you may have this ports occupied by your mongodb installation in your machine*

* Accessing rabbitmq from your machine:

    http://localhost:15672/ 

    *attention: you may have this ports occupied by your rabbitmqadmin installation in your machine*


* Development:

    by default this vagrantfile have this configuration for shared folder between the host and the VM

    *[config.vm.synced_folder "~/Projects", "/vagrant"]*<br>
    *[config.vm.synced_folder "~/data", "/vagrant_data"]*
    
## TODO:

* Integrate AEON configuration into this provision.

## Authors:

Elisa Herrmann <elisa.herrmann@atos.net>