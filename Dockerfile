FROM debian:9

RUN apt-get install /
	build-essential stgit u-boot-tools util-linux /
	gperf device-tree-compiler python-all-dev xorriso /
	autoconf automake bison flex texinfo libtool libtool-bin /
	realpath gawk libncurses5 libncurses5-dev bc /
	dosfstools mtools pkg-config git wget help2man libexpat1 /
	libexpat1-dev fakeroot python-sphinx rst2pdf /
	libefivar-dev libnss3-tools libnss3-dev libpopt-dev / 
	libssl-dev sbsigntool uuid-runtime /
	curl bsdmainutils

RUN useradd -M build

CMD ["bash"]
