# build-onie

This Dockerfile creates a Debian build environment for ONIE.
It also clarifies how Docker could be used in a build workflow. 

* It has not been tested yet. I will revisit this image upon a return to the ONIE build process.

Docker allows you to package an entire Linux environment into units called containers. Containers utilise [control groups](https://en.wikipedia.org/wiki/Cgroups "Wikipedia Cgroups"), a resource isolation & management feature of the Linux kernel, to execute their processes with allowances specific to their control group.

## Steps (Container preparation)
> The goal is to access a shell session as the 'build' user within the container environment.

Clone this repository. Then navigate into the directory.
* `git clone https://github.com/bluejumper/build-onie && cd build-onie`

Build the image using Docker.
* `docker build -t debian:build-onie .`

Create a container from this image, and attach your terminal onto it.
You can define any mount options using the alternative command.
* `docker run -it --name debian debian:build-onie`
* `docker run -it -v [a_host_directory]:/mnt/build --name debian debian:build-onie` *to specify a mount*
> Should you find yourself detached from your container instance, you can use `docker attach [name]` to re-attach onto a running container.

## Steps (Build preparation)
As the build user, navigate to the build directory.
* `cd /mnt/build`

Use Git to clone the [ONIE repository](https://github.com/opencomputeproject/onie "opencomputeproject/onie").
* `git clone https://github.com/opencomputeproject/onie`

Navigate into the build-config directory.
* `cd ./build-config`

## Steps (To build)
You are now follow a target's build steps from the ONIE repository.
Please review the 'INSTALL' file within a directory you'll find [here](https://github.com/opencomputeproject/onie/tree/master/machine "onie/machines"). 
* For a KVM build: `make -j2 MACHINE=kvm_x86_64 all recovery-iso`
* For an Accton platform: `make -j4 MACHINEROOT=../machine/accton MACHINE=accton_as7816_64x all`
