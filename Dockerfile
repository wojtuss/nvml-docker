#
# Ubuntu 16.04
# + git, gcc, clang
# + valgrind
# + libfabric
#

# Pull base image
FROM ubuntu:16.04
MAINTAINER wojciech.uss@intel.com

# Define variables which can be received at build-time
ARG http_proxy
ARG https_proxy

ENV NOTTY=1

# Update the Apt cache and install basic tools
RUN apt-get update
RUN apt-get install -y software-properties-common libunwind8-dev autoconf devscripts pkg-config ssh git gcc clang debhelper

# Install valgrind
RUN git clone https://github.com/wojtuss/valgrind.git \
	&& cd valgrind \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make install

# Install libfabric
ENV libfabric_ver 1.2.0
ENV libfabric_url https://github.com/ofiwg/libfabric/releases/download
ENV libfabric_dir libfabric-$libfabric_ver
ENV libfabric_tarball ${libfabric_dir}.tar.bz2
RUN wget "${libfabric_url}/v${libfabric_ver}/${libfabric_tarball}"
RUN tar -xf $libfabric_tarball
RUN cd $libfabric_dir \
	&& ./configure --prefix=/usr --enable-sockets \
	&& make -j2 \
	&& make install

# Copy scripts into the image
COPY make.sh ./make.sh
COPY make_dpkg.sh make_dpkg.sh
COPY configure_tests.sh configure_tests.sh

WORKDIR /
