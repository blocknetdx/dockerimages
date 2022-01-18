# Build via docker:
# docker build --build-arg cores=8 -t blocknetdx/dogec:latest .

FROM ubuntu:bionic

ARG cores=6
ENV ecores=$cores

LABEL wallet=dogecash
LABEL version=5.4.4

RUN apt update \
  && apt install -y --no-install-recommends \
     software-properties-common \
     ca-certificates \
     wget curl git python vim \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN add-apt-repository ppa:bitcoin/bitcoin \
  && apt update \
  && apt install -y --no-install-recommends \
     gcc-8 g++-8 \
     curl build-essential libtool autotools-dev automake \
     python3 bsdmainutils cmake libevent-dev autoconf automake \
     pkg-config libssl-dev libboost-system-dev libboost-filesystem-dev \
     libboost-chrono-dev libboost-program-options-dev libboost-test-dev \
     libboost-thread-dev libdb4.8-dev libdb4.8++-dev libgmp-dev \
     libminiupnpc-dev libzmq3-dev libattr1-dev zlib1g-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DISTDIR=/opt/blockchain/dist

# Build source
RUN mkdir -p /opt/dogecash \
  && mkdir -p /opt/blockchain/config \
  && mkdir -p /opt/blockchain/data \
  && ln -s /opt/blockchain/config /root/.dogecash \
  && cd /opt/dogecash \
  && git clone https://github.com/dogecash/dogecash dogecash \
  && cd /opt/dogecash/dogecash/ \
  && git checkout 9c83bb764d05b18225a43fc977fededa074cf7b1 \
  && cd depends \
  && make -j$ecores NO_QT=1 \
  && cd .. \
  && chmod +x ./autogen.sh \
  && ./autogen.sh \
  && ./configure CC="gcc-8" CXX="g++-8" CXXFLAGS="-Wno-error=return-type" --disable-tests --disable-bench --without-miniupnpc --with-gui=no --enable-hardening --prefix=`pwd`/depends/x86_64-pc-linux-gnu \
  && make -j$ecores \
  && make install DESTDIR=$DISTDIR \
  && cp -r $DISTDIR/opt/dogecash/dogecash/depends/x86_64-pc-linux-gnu/bin/* /usr/bin/ \
  && cp -r $DISTDIR/opt/dogecash/dogecash/depends/x86_64-pc-linux-gnu/share/* /usr/share/ \
  && rm -rf /opt/dogecash/

# Write default dogecash.conf (can be overridden on commandline)
RUN echo "datadir=/opt/blockchain/data  \n\
                                        \n\
dbcache=256                             \n\
maxmempool=512                          \n\
                                        \n\
port=6740                               \n\
rpcport=6783                            \n\
                                        \n\
listen=1                                \n\
txindex=1                               \n\
server=1                                \n\
maxconnections=16                       \n\
logtimestamps=1                         \n\
logips=1                                \n\
                                        \n\
rpcallowip=127.0.0.1                    \n\
rpctimeout=30                           \n\
rpcclienttimeout=30                     \n" > /opt/blockchain/config/dogecash.conf

WORKDIR /opt/blockchain/
VOLUME ["/opt/blockchain/config", "/opt/blockchain/data"]

# Port, RPC, Test Port, Test RPC
EXPOSE 6740 6783  18332  19332

CMD ["/usr/bin/dogecashd", "-daemon=0"]