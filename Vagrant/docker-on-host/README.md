# Run Docker in Windows VMs for ViVirtualBox(Linux) & Parallels(MacOS)

## The problem:

The newer _docker-for-windows_ runs in a _Hyper-V_ VM.
_Hyper-V_ is a  Type-1 hypervisor and cannot nest inside VirtualBox/Parallel VMs,
as explained in [this article](https://medium.com/@peorth/using-docker-with-virtualbox-and-windows-10-b351e7a34adc)
Consequently, a Vagrant Virtualbox image must not install `choco(docker-desktop)`.


## The solution?

Teach the old _docker-cmd_ on the Guest-OS to use the _docker-service_ on the Host-OS:

Install the _old docker_ (`choco(docker-toolbox)`) on the Windows VM
and delegate its docker-client to Host's `dockerd` daemon, through a tcp port.
For that you need to enable `dockerd` listening 2375 port on the Host,
the default for non-TLS connection (default TLS port is 2376).

NOTE:
    Since docker containers will run on the Host, Guest must use NAT's gateway IP address
    (typically 10.0.2.2) to access any containerized services, 
    as explained in [part II of the article](https://medium.com/@peorth/using-docker-with-virtualbox-and-windows-10-part-ii-1071aaea6949).


## File contents

The configuration files contained in this folder are for Debian, 
as proposed in [this ghist](https://gist.github.com/styblope/dc55e0ad2a9848f2cc3307d4819d819f).

Move the files contained here in those places:

    override.conf       --> /etc/systemd/system/docker.service.d/.
    daemone.json        --> /etc/docker/.


## Alternative

For a Windows hosts only, you may enable _Hyper-V_, which supports nested VMs,
and use the newer _docker-for-windows_ inside a hyperv VM.