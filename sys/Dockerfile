# Build via docker:
# docker build --build-arg cores=8 -t blocknetdx/syscoin4:4.0.3 .

FROM ubuntu:xenial

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
     build-essential libtool autotools-dev automake pkg-config \
     libssl-dev libevent-dev bsdmainutils python3 \
     libboost-system-dev libboost-filesystem-dev libboost-chrono-dev \
     libboost-program-options-dev libboost-test-dev libboost-thread-dev \
     libboost-graph-dev libboost-regex-dev \
     libdb4.8-dev libdb4.8++-dev libgmp-dev libminiupnpc-dev libzmq3-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build source
RUN mkdir -p /opt/syscoin \
  && mkdir -p /opt/blockchain/config \
  && mkdir -p /opt/blockchain/data \
  && ln -s /opt/blockchain/config /root/.syscoin \
  && cd /opt/syscoin \
  && git clone --depth 1 --branch v4.0.3 https://github.com/syscoin/syscoin.git \
  && cd /opt/syscoin/syscoin \
  && chmod +x ./autogen.sh \
  && ./autogen.sh \
  && ./configure --with-boot-libdir="/usr/local/lib" --without-gui --enable-hardening \
  && make -j$ecores \
  && make install \
  && rm -rf /opt/syscoin/

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
