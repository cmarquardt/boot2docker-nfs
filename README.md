# Boot2Docker-NFS

Boot2Docker is a lightweight Linux distribution made specifically to run
[Docker](https://www.docker.com/) containers. It runs completely from RAM, is a
small ~38MB download and boots in ~5s (YMMV).

This variant of the Boot2Docker ISO image is based on the [official Boot2Docker
ISO image](https://github.com/boot2docker/boot2docker) and adds support for
mounting disks / volumes via NFS. Technically, this means that a virtual machine
using the Boot2docker ISO image also launches the nfs-client daemon(s) upon
startup.

## Features

* Kernel 4.4.89 with AUFS, Docker v17.09.0-ce - using libcontainer
* Container persistence via disk automount on `/var/lib/docker`
* SSH keys persistence via disk automount
* Support for NFS

> **Note:** Boot2Docker uses port **2376**, the [registered IANA Docker TLS
> port](http://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml?search=docker)

## Caveat Emptor

Boot2Docker is currently designed and tuned for development.  Using it for
any kind of production workloads at this time is highly discouraged.

This NFS-enabled variant of Boot2Docker is manually updated to follow releases of
the [official Boot2Docker ISO image](https://github.com/boot2docker/boot2docker).

## Installation

Installation should be performed via [Docker Toolbox](https://www.docker.com/products/docker-toolbox)
which installs [Docker Machine](https://docs.docker.com/machine/overview/),
the Boot2Docker VM, and other necessary tools.

The [NFS-enabled ISO image can be downloaded
here](https://github.com/cmarquardt/boot2docker-nfs/releases).

## How to use

Boot2Docker is used via [Docker Machine](https://docs.docker.com/machine/overview/)
(installed as part of Docker Toolbox) which leverages VirtualBox's `VBoxManage` to
initialise, start, stop and delete the VM right from the command line.

For further information on how to use the Boot2Docker ISO image, please the official
[Boot2Docker GitHub page](https://github.com/boot2docker/boot2docker).
