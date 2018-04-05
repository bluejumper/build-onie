FROM debian:9

# Install predependencies.
RUN apt-get update && apt-get install -y apt-utils wget git

# Get current Makefile from repository.
# Isolate Dependencies.
# Export as environment file.
# apt install exported dependencies.

RUN wget -qO- https://raw.githubusercontent.com/opencomputeproject/onie/master/build-config/Makefile | \
	sed -n '/^DEBIAN_BUILD_HOST_PACKAGES/ { :feed H; n; /^$/!b feed; g; p }' | \
	sed 's/DEBIAN_BUILD_HOST_PACKAGES.*\= /export DEBIAN_BUILD_HOST_PACKAGES=\x22/; s/\x09*//; s/\x0a*/\x0a/; /^$/d; $s/$/\x22/;' && \
	apt-get install -y $DEBIAN_BUILD_HOST_PACKAGES
	
# Create build user
RUN useradd -m -s /bin/sh build  && \
	adduser build sudo && \
	echo "build:build" | chpasswd && \
	echo export PATH="/sbin:/usr/sbin:$PATH" >> /home/build/.bashrc

# Create /mnt/build as a mount point for sharing files with the host
# system.
RUN mkdir /mnt/build; chown build:build /mnt/build

# As the build user, navigate to the build directory.
USER build

CMD ["/bin/sh"]
