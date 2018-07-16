# Build via docker:
# docker build --build-arg cores=8 -t devbuilds/mozilla-rr:5.2.0 .
# docker build --build-arg cores=32 -t devbuilds/mozilla-rr:5.2.0 .
FROM ubuntu:trusty

ARG cores=4
ENV ecores=$cores

RUN apt update \
  && apt install -y --no-install-recommends \
     software-properties-common \
     ca-certificates \
     wget curl git python vim \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt update \
  && apt install -y --no-install-recommends \
     ccache cmake make g++-multilib gdb \
     pkg-config coreutils python-pexpect manpages-dev git \
     ninja-build capnproto libcapnp-dev realpath autoconf \
     automake libtool \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /opt/capnproto \
  && cd /opt \
  && git clone --depth 1 --branch master https://github.com/sandstorm-io/capnproto.git \
  && cd capnproto/c++ \
  && autoreconf -i \
  && ./configure \
  && make -j$ecores check \
  && make install

# Build source
RUN mkdir -p /opt/obj \
  && mkdir -p /opt/rr \
  && cd /opt \
  && git clone --depth 1 --branch 5.2.0 https://github.com/mozilla/rr.git \
  && cd /opt/obj \
  && cmake ../rr \
  && make -j$ecores \
  && make install

WORKDIR /usr/local/bin/
