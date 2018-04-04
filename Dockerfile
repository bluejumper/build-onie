FROM debian:9

# Compare with $(DEBIAN_BUILD_HOST_PACKAGES) variable from
# onie/build-config/Makefile.

RUN apt-get update && apt-get install -y \
	build-essential stgit u-boot-tools util-linux \
	gperf device-tree-compiler python-all-dev xorriso \
	autoconf automake bison flex texinfo libtool libtool-bin \
	realpath gawk libncurses5 libncurses5-dev bc \
	dosfstools mtools pkg-config git wget help2man libexpat1 \
	libexpat1-dev fakeroot python-sphinx rst2pdf \
	libefivar-dev libnss3-tools libnss3-dev libpopt-dev \
	libssl-dev sbsigntool uuid-runtime uuid-dev cpio \
	curl bsdmainutils sudo

# Create build user

RUN useradd -m -s /bin/bash build
RUN adduser build sudo
RUN echo "build:build" | chpasswd

# Add /sbin and /usr/sbin to build user's path

RUN echo export PATH="/sbin:/usr/sbin:$PATH" >> /home/build/.bashrc

# Create /mnt/build as a mount point for sharing files with the host
# system.

RUN mkdir /mnt/build && chown build:build /mnt/build

USER build

CMD ["bash"]
