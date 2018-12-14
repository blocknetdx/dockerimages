# Build via docker:
# docker build --build-arg cores=8 -t blocknetdx/monacoin:0.16.3 .

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

# Build source
RUN mkdir -p /opt/monacoin \
  && mkdir -p /opt/blockchain/config \
  && mkdir -p /opt/blockchain/data \
  && ln -s /opt/blockchain/config /root/.monacoin \
  && cd /opt/monacoin \
  && git clone --depth 1 --branch monacoin-0.16.3 https://github.com/monacoinproject/monacoin.git \
  && cd /opt/monacoin/monacoin \
  && chmod +x ./autogen.sh \
  && ./autogen.sh \
  && ./configure --without-gui --enable-hardening \
  && make -j$ecores \
  && make install \
  && rm -rf /opt/monacoin/

# Write default monacoin.conf (can be overridden on commandline)
RUN echo "datadir=/opt/blockchain/data  \n\
                                        \n\
dbcache=256                             \n\
maxmempool=512                          \n\
                                        \n\
port=9401    # testnet: 19403           \n\
rpcport=9402 # testnet: 19402           \n\
                                        \n\
listen=1                                \n\
server=1                                \n\
maxconnections=16                       \n\
logtimestamps=1                         \n\
logips=1                                \n\
                                        \n\
rpcallowip=127.0.0.1                    \n\
rpctimeout=15                           \n\
rpcclienttimeout=15                     \n" > /opt/blockchain/config/monacoin.conf

WORKDIR /opt/blockchain/
VOLUME ["/opt/blockchain/config", "/opt/blockchain/data"]

# Port, RPC, Test Port, Test RPC
EXPOSE 9401 9402 19403 19402

CMD ["monacoind", "-daemon=0"]

