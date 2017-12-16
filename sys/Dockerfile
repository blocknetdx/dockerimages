# Build via docker:
# docker build --build-arg cores=8 -t blocknetdx/syscoin2:2.1.6 .

FROM ubuntu:trusty

ARG cores=1
ENV ecores=$cores

RUN apt update \
  && apt install -y --no-install-recommends \
     software-properties-common \
     ca-certificates \
     wget curl git python vim \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN add-apt-repository ppa:bitcoin/bitcoin \
  && apt update \
  && apt install -y --no-install-recommends \
     build-essential libtool autotools-dev bsdmainutils \
     libevent-dev autoconf automake pkg-config libssl-dev \
     libboost-system-dev libboost-filesystem-dev libboost-chrono-dev \
     libboost-program-options-dev libboost-test-dev libboost-thread-dev \
     libdb4.8-dev libdb4.8++-dev libgmp-dev libminiupnpc-dev libzmq3-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build berkeleydb4.8
RUN mkdir -p /tmp/berkeley \
  && cd /tmp/berkeley \
  && wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz' \
  && [ "$(printf '12edc0df75bf9abd7f82f821795bcee50f42cb2e5f76a6a281b85732798364ef db-4.8.30.NC.tar.gz' | sha256sum -c)" = "db-4.8.30.NC.tar.gz: OK" ] || $(echo "Berkeley DB 4.8 sha256sum failed"; exit 1) \
  && tar -xzvf db-4.8.30.NC.tar.gz \
  && cd db-4.8.30.NC/build_unix/ \
  && ../dist/configure --enable-cxx --disable-shared --with-pic --prefix=/tmp/berkeley \
  && make install

# Build source
RUN mkdir -p /opt/syscoin2 \
  && mkdir -p /opt/blockchain/config \
  && mkdir -p /opt/blockchain/data \
  && ln -s /opt/blockchain/config /root/.syscoin \
  && cd /opt/syscoin2 \
  && git clone --depth 1 --branch 2.1.6 https://github.com/syscoin/syscoin2.git \
  && cd /opt/syscoin2/syscoin2 \
  && chmod +x ./autogen.sh \
  && ./autogen.sh \
  && ./configure LDFLAGS="-L/tmp/berkeley/lib/" CPPFLAGS="-I/tmp/berkeley/include/" --without-gui --enable-hardening \
  && make -j$ecores \
  && make install \
  && rm -rf /opt/syscoin2/ /tmp/berkeley/*

# Write default syscoin.conf (can be overridden on commandline)
RUN echo "datadir=/opt/blockchain/data  \n\
                                        \n\
dbcache=256                             \n\
maxmempool=512                          \n\
                                        \n\
port=8369    # testnet: 18369           \n\
rpcport=8370 # testnet: 18370           \n\
                                        \n\
listen=1                                \n\
server=1                                \n\
maxconnections=16                       \n\
logtimestamps=1                         \n\
logips=1                                \n\
                                        \n\
rpcallowip=127.0.0.1                    \n\
rpctimeout=15                           \n\
rpcclienttimeout=15                     \n" > /opt/blockchain/config/syscoin.conf

WORKDIR /opt/blockchain/
VOLUME ["/opt/blockchain/config", "/opt/blockchain/data"]

# Port, RPC, Test Port, Test RPC
EXPOSE 8369 8370 18369 18370

CMD ["syscoind", "-daemon=0"]

