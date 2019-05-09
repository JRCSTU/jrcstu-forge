<!-- vi: set sts=4 ts=4 sw=4 : -->
CO2MPAS development environment
===============================

> A replacement for **co2mpas-ALLINONE**...

Ensure a reproducible cross-platform development and deployment infrastructure-as-code,
with Vagrant images & conda packages, as conceived in https://app.clickup.com/t/qgdb2



## Install

- Do only once in your Host PC, with AdminRights/Root:
  - Install Virtualbox + GuestAdditions (+optional: extras)
  - Install Vagrant, and then with normal priviledges install these plugins:

        vagrant install plugin winrm winrm-fs winrm-elevated vagrant-vbguest


### Launch VM

Choose which `Vagrantfile` you want, copy iyt to some folder
and edit it, e.g. to set the CPUs/Memory, and then::

      vagrant up

This will take some considerable time to complete,
roughly this (without downloading base-image)::

    real	6m19.662s
    user	0m10.361s
    sys	0m8.611s

for these steps:

- Download the base-image ~6GB,
- prepare this base-image for quickly creating clones (children),
- run Windows 1st-boot actions (need to click Network visibility),
- provision the rest applications with chocolatey, conda, etc.


### Reload VM

To apply any edits to `Vagrantfile`::

    vagrant reload --provision


## File contents

    Windows/        Vagrant development image
