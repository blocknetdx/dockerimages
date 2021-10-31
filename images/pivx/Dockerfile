# Build via docker:
# docker build --build-arg cores=8 -t blocknetdx/pivx:5.3.2.1 .

FROM ubuntu:xenial

ARG cores=1
ENV ecores=$cores

RUN apt update \
  && apt install -y --no-install-recommends \
     software-properties-common \
     ca-certificates \
     wget curl git python vim \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN add-apt-repository ppa:pivx/pivx \
  && apt update \
  && apt install -y --no-install-recommends \
     build-essential libtool autotools-dev automake pkg-config \
     libssl-dev libevent-dev bsdmainutils python3 autoconf \
     libboost-all-dev libsodium-dev cargo \
     libdb4.8-dev libdb4.8++-dev libgmp-dev libminiupnpc-dev libzmq3-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build source
RUN mkdir -p /opt/pivx \
  && mkdir -p /opt/blockchain/config \
  && mkdir -p /opt/blockchain/data \
  && ln -s /opt/blockchain/config /root/.pivx \
  && cd /opt/pivx \
  && git clone --depth 1 --branch v5.3.2.1 https://github.com/PIVX-Project/PIVX.git \
  && cd /opt/pivx/PIVX \
  && chmod +x ./autogen.sh \
  && ./autogen.sh \
  && ./configure --with-boot-libdir="/usr/local/lib" --without-gui --enable-hardening \
  && make -j$ecores \
  && make install \
  && rm -rf /opt/pivx/

# Write default pivx.conf (can be overridden on commandline)
RUN echo "datadir=/opt/blockchain/data  \n\
                                        \n\
port=51472      # testnet 51474         \n\
rpcport=51473   # testnet 51475         \n\
                                        \n\
listen=1                                \n\
server=1                                \n\
maxconnections=16                       \n\
logtimestamps=1                         \n\
logips=1                                \n\
txindex=1                               \n\
                                        \n\
rpcallowip=0.0.0.0/0                    \n\
rpcbind=0.0.0.0/0                       \n\
rpcbindtimeout=30                       \n\
rpcclienttimeout=30                     \n" > /opt/blockchain/config/pivx.conf

WORKDIR /opt/blockchain/
VOLUME ["/opt/blockchain/config", "/opt/blockchain/data"]

# Port, RPC, Test Port, Test RPC
EXPOSE 51472 51473 51474 51475

CMD ["pivxd", "-daemon=0"]
