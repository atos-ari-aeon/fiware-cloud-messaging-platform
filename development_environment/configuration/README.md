# AEON Configuration.

This is a puppet manifest to configure AEON modules.

## Puppet Manifest will:

Configure and start:
* AEON events-manager
* AEON frontend
* AEON rest

## Requires:

* AEON virtual machine running (see environment/README)

```bash
    $ cd aeon-platform/development_environment/environment/
    $ vagrant up
    $ vagrant ssh
```

* Download AEON code into AEON virtual machine :

```bash
    vagrant@aeon:~$ git clone git@192.168.252.30:ari/aeon-platform.git
```

* Copy configuration manifests to ~/data (~/data is a host folder synced to guest /vagrant_data folder):

```bash
    $ cp -r configuration data
```

## Configuring and starting AEON modules:

```bash
    vagrant@aeon:~$ puppet apply --modulepath /vagrant_data/configuration/modules /vagrant_data/configuration/manifests/main.pp
```

## Using it:
    
    Host browser:
    
```bash
    http://192.168.33.10:8000/
```
    
## TODO:

* Integrate AEON configuration into AEON virtual machine provision.

## Authors:

Elisa Herrmann <elisa.herrmann@atos.net>