FROM ubuntu:focal

ARG DEF_FACTORY=default

ENV DEBIAN_FRONTEND noninteractive
ENV OSTREE_SYSROOT=/sysroot
ENV OSTREE_REPO=/sysroot/ostree/repo

# ostree deps
RUN apt-get update && apt-get -y install --no-install-suggests --no-install-recommends \
  git apt-transport-https ca-certificates autoconf automake make cmake libglib2.0-dev libtool bison \
  libssl-dev libcurl4-openssl-dev \
  libgpgme11-dev libarchive-dev libcurl4-openssl-dev e2fslibs-dev libfuse-dev libp11-dev liblzma-dev

# build and install ostree/libostree
WORKDIR /ostree
RUN git init && git remote add origin https://github.com/ostreedev/ostree \
  && git fetch origin v2020.7 && git checkout FETCH_HEAD

RUN ./autogen.sh CFLAGS='-Wno-error=missing-prototypes' --with-libarchive --disable-man --with-builtin-grub2-mkconfig --with-curl --without-soup --disable-glibtest --prefix=/usr && make install -j4


# lmp-device-register deps
RUN  apt-get install -y \
  g++ libboost-program-options-dev libboost-filesystem-dev

# Debug tools
RUN apt-get install -y dnsutils uuid-runtime

WORKDIR /dev-reg
RUN git init && git remote add origin https://github.com/foundriesio/lmp-device-register \
  && git fetch origin master && git checkout master
RUN cmake -S . -B build -DHARDWARE_ID=intel-corei7-64 -DDEVICE_FACTORY=${DEF_FACTORY} \
  && cmake --build build --target install

RUN mkdir /var/sota && chmod 700 /var/sota

COPY pull /usr/bin/
