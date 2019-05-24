# Virtualbox & Vagrant

## Installation

- Do only once in your Host PC (Linux, MacOS, Windows), with AdminRights/Root:
  - Install Virtualbox + GuestAdditions (+optional: extras)
  - Install Vagrant
    The 2st time you launch the win10 image, it will install these plugins:

        winrm winrm-fs winrm-elevated vagrant-vbguest vagrant-reload


## Build & Launch VM

Copy the `Vagrantfile` to some folder, optionally edit it
(or use `~/.Vagrantfile`), e.g. to set the CPUs/Memory,
and then::

    vagrant up

This will take some considerable time to complete
these steps:

- Download the base-image ~6GB,
- prepare this base-image for quickly creating clones (children),
  (optional if `config.vm.provider(linked_clone: true)`)
- run Windows 1st-boot actions,
- provision the rest applications with chocolatey, conda, etc.

... and, without downloading base-image, it typically takes::

    real    20m2.404s
    user    0m18.010s
    sys     0m10.250s


## Re-provision VM

To apply any edits to `Vagrantfile`::

    vagrant reload --provision


## Snapshot VMs to speed-up development
It is recommended to save a snapshot of the *base* image before
provisioning it.  To do so, run these commands INSTEAD of
the very first `up` command (timed in my extra-speedy thinkpad)::

```bash
    # Erase(!) VM & start all over.
    $ time vagrant destroy

    $ time vagrant up --no-provision
    real    3m29.269s
    user    0m9.296s
    sys     0m7.912s
    $ vagrant snapshot save "base"

    $ time vagrant provision --provision-with=app_install       # or `vagrant up --provision-with=...`
    real    6m48.853s
    user    0m3.083s
    sys     0m0.824s
    $ vagrant snapshot save "app_install"                       # You may skip this or any snapshot.


    $ time vagrant provision --provision-with=1st_reboot,regedit,conda_base
    real    1m11.795s
    user    0m2.244s
    sys     0m0.757s
    $ vagrant snapshot save conda_base

    $ time vagrant provision --provision-with=conda_co2,last_reboot   # Or run all with `vagrant up --provision`.
    real    4m27.198s
    user    0m2.589s
    sys     0m0.735s
    $ vagrant snapshot save conda_co2
```

You may then edit `Vagrantfile` and re-provision it with one command::

    vagrant snapshots restore base --provision
