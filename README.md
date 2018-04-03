# build-onie

This Dockerfile creates a Debian build environment for ONIE.
It also clarifies how Docker could be used in a build workflow. 

* It has not been tested yet. I will revisit this image upon a return to the ONIE build process.
* A user called **build** is used after creating the build directory.

Steps:

Build the image using Docker.
* You might use a command similar to `docker build -t debian:onie_build .`

Run a container using this image.
* You might use `docker run -it --name debian debian:onie_build`

Determine and create a build directory.
* You might consider using `/mnt/build`

Give ownership of this directory to the `build` user, then su into the `build` user.
* `chown build:build /mnt/build && su build`

Use Git to clone the [ONIE repository](https://github.com/opencomputeproject/onie "opencomputeproject/onie") to a build directory.
* `cd /mnt/build && git clone https://github.com/opencomputeproject/onie`
* I used Docker to mount an external HDD partition, connected to my host machine. This was mounted within the container as the build directory.

You should now be able to follow the build steps from the ONIE repository.
* For a KVM build: `cd build-config && make -j2 MACHINE=kvm_x86_64 all recovery-iso`
