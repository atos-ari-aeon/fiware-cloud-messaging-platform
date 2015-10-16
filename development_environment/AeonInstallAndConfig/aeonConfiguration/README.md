# AEON Configuration.

This is a puppet manifest to configure AEON modules.

## Puppet Manifest will:

Configure and start:
* AEON events-manager
* AEON dashboard
* AEON api



## Configuring and starting AEON modules:

Edit the main.pp file of every module to configure the IPs as needed then run the below commands


```bash
    $ sudo puppet apply --modulepath /home/aeon/aeonConfiguration/aeon_api/modules /home/aeon/aeonConfiguration/aeon_api/manifests/main.pp
```

```bash
    $ sudo puppet apply --modulepath /home/aeon/aeonConfiguration/aeon_events_manager/modules /home/aeon/aeonConfiguration/aeon_events_manager/manifests/main.pp
```

```bash
    $ sudo puppet apply --modulepath /home/aeon/aeonConfiguration/aeon_dashboard/modules /home/aeon/aeonConfiguration/aeon_dashboard/manifests/main.pp
```

## Authors:

Elisa Herrmann <elisa.herrmann@atos.net>
