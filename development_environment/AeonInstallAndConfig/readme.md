## Deploy AEON using Image

To deploy the AEON using the image recipes, it is necessary to download them from the repo:

```bash
$ git clone http://gitlab.atosresearch.eu/ari/aeon-platform.git
```

Navigate to the development environment folder:

```bash
$ cd ./aeon-platform/development_environment/AeonInstallAndConfig
```

Execute the script aeon.sh:

```bash
$ ./aeon.sh
```
When the script finishes, navigate to the aeonConfiguration folder:

```bash
$ cd /home/aeon/aeonConfiguration
```

Once here, it is necessary to configure the puppet files with your external and internal IPs. The files that need to be edited are:

```bash
$ vim /home/aeon/aeonConfiguration/aeon_dashboard/manifests/main.pp
$ vim /home/aeon/aeonConfiguration/aeon_api/manifests/main.pp
$ vim /home/aeon/aeonConfiguration/aeon_events_manager/manifests/main.pp
```

and the varibles to be set are $internalIP and $externalIP.

Finally, execute the puppet apply commands:

```bash
$ sudo puppet apply --modulepath /home/aeon/aeonConfiguration/aeon_api/modules /home/aeon/aeonConfiguration/aeon_api/manifests/main.pp
$ sudo puppet apply --modulepath /home/aeon/aeonConfiguration/aeon_events_manager/modules /home/aeon/aeonConfiguration/aeon_events_manager/manifests/main.pp
$ sudo puppet apply --modulepath /home/aeon/aeonConfiguration/aeon_dashboard/modules /home/aeon/aeonConfiguration/aeon_dashboard/manifests/main.pp
```

After finishing, AEON will be accesible. 