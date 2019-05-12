<!-- vi: set sts=4 ts=4 sw=4 : -->
CO2MPAS development environment
===============================

> A replacement for **co2mpas-ALLINONE**...

Ensure a reproducible cross-platform development and deployment infrastructure-as-code,
with Vagrant images & conda packages, as conceived in https://app.clickup.com/t/qgdb2



## Virtualbox & Vagrantr Installation

- Do only once in your Host PC, with AdminRights/Root:
  - Install Virtualbox + GuestAdditions (+optional: extras)
  - Install Vagrant, and then with normal priviledges install these plugins:

        vagrant install plugin winrm winrm-fs winrm-elevated vagrant-vbguest


### Build & Launch VM

Choose which `Vagrantfile` you want, copy that to some folder,
optionally edit it (or use `~/.Vagrantfile`), e.g. to set the CPUs/Memory, 
and then::

    vagrant up

This will take some considerable time to complete
the following these steps:

- Download the base-image ~6GB,
- prepare this base-image for quickly creating clones (children),
  (optional if `config.vm.provider(linked_clone: true)`)
- run Windows 1st-boot actions,
- provision the rest applications with chocolatey, conda, etc.

... and, without downloading base-image, it typically takes::

    real    11m8.834s
    user    0m9.475s
    sys     0m6.488s


### Re-provision VM

To apply any edits to `Vagrantfile`::

    vagrant reload --provision

### Snapshot VMs to speed-up development
It is recommended to save a snapshot of the *base* image before
provisioning it.  To do so, run these commands INSTEAD of
the very first `up` command (timed in my extra-speedy thinkpad)::

```bash
    $ time vagrant destroy        # Erase(!) VM & start all over.
    $ time vagrant up --no-provision
    real    3m29.269s
    user    0m9.296s
    sys     0m7.912s
    $ vagrant snapshot save "base"

    $ time vagrant provision-with=app_install       # or `vagrant up --provision-with=...`
    real    6m48.853s
    user    0m3.083s
    sys     0m0.824s
    $ vagrant snapshot save "app_install"


    $ time vagrant provision-with=conda_base
    $ vagrant snapshot save conda_base              # You may skip any snapshot.

    $ time vagrant provision-with=conda_co2         # Or run all with `vagrant up --provision`.
    $ vagrant snapshot save conda_co2
```

You may then edit `Vagrantfile` and provision it with::

    vagrant snapshots restore Base --provision


## File contents

    Windows/        Vagrant development image
