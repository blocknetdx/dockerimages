# Build via docker:
# docker build --build-arg cores=8 -t blocknetdx/blocknet:latest .
FROM blocknetdx/devbuilds:gitlab-linux

ARG cores=8
ENV ecores=$cores

LABEL wallet=blocknet
LABEL version=4.3.3

ENV PROJECTDIR=/opt/blocknetdx/blocknet
ENV BASEPREFIX=$PROJECTDIR/depends
ENV BASEPREFIX_CACHE=/proj/depends-cache
ENV DISTDIR=$PROJECTDIR/dist

ENV HOST=x86_64-pc-linux-gnu

# Copy source files
RUN mkdir -p /opt/blocknetdx \
  && cd /opt/blocknetdx \
  && git clone --single-branch --branch 4.3.3-dev-18decimal https://github.com/blocknetdx/blocknet.git

RUN mkdir -p /opt/blockchain/config \
    && mkdir -p /opt/blockchain/data \
    && ln -s /opt/blockchain/config /root/.blocknet \
    && rm -rf $BASEPREFIX \
    && mv $BASEPREFIX_CACHE $BASEPREFIX \
    && chmod +x ./autogen.sh; sync \
    && ./autogen.sh \
    && CONFIG_SITE=$BASEPREFIX/$HOST/share/config.site ./configure CC=gcc-8 CXX=g++-8 CFLAGS='-Wno-deprecated' CXXFLAGS='-Wno-deprecated' --disable-ccache --disable-maintainer-mode --disable-dependency-tracking --without-gui --enable-hardening --prefix=/ \
    && echo "Building with cores: $ecores" \
    && make -j$ecores \
    && make install

# Write default blocknet.conf (can be overridden on commandline)
RUN echo "datadir=/opt/blockchain/data    \n\
                                          \n\
maxmempoolxbridge=128                     \n\
                                          \n\
port=41412    # testnet: 41474            \n\
rpcport=41414 # testnet: 41419            \n\
                                          \n\
server=1                                  \n\
logtimestamps=1                           \n\
logips=1                                  \n\
                                          \n\
rpcbind=0.0.0.0                           \n\
rpcallowip=127.0.0.1                      \n\
rpctimeout=60                             \n\
rpcclienttimeout=30" > /opt/blockchain/config/blocknet.conf

WORKDIR /opt/blockchain/
VOLUME ["/opt/blockchain/config", "/opt/blockchain/data"]

# Port, RPC, Test Port, Test RPC
EXPOSE 41412 41414 41474 41419

CMD ["blocknetd", "-daemon=0"]
