# Build Geth in a stock Go builder container
FROM golang:1.16-alpine as go-ethereum

ARG GETH_REPO=https://github.com/syscoin/go-ethereum.git
ARG GETH_BRANCH=master

RUN set -xe; \
  apk add --no-cache --virtual .build-deps \
  make gcc musl-dev linux-headers git; \
  mkdir -p go-ethereum; \
  git clone ${GETH_REPO} --branch ${GETH_BRANCH} --depth 1 --single-branch go-ethereum; \
  cd go-ethereum; \
  make geth -j$(nproc) all; \
  apk del .build-deps;

# Build stage for Syscoin Core
FROM alpine as syscoin-core

RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories
RUN apk --no-cache add autoconf
RUN apk --no-cache add automake
RUN apk --no-cache add build-base
RUN apk --no-cache add chrpath
RUN apk --no-cache add file
RUN apk --no-cache add gnupg
RUN apk --no-cache add libtool
RUN apk --no-cache add linux-headers
RUN apk --no-cache add cmake
RUN apk --no-cache add libc-dev
RUN apk --no-cache add make
RUN apk --no-cache add git
RUN apk --no-cache add python3
RUN apk --no-cache add xz
RUN apk --no-cache add bison
RUN apk --no-cache add curl
RUN apk --no-cache add pkgconf
RUN apk --no-cache add bash
RUN apk --no-cache add clang

RUN set -ex \
  && for key in \
    90C8019E36C2E964 \
  ; do \
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key" || \
    gpg --batch --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --batch --keyserver keyserver.pgp.com --recv-keys "$key" || \
    gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
  done

ENV SYSCOIN_VERSION=4.2.2
ENV SYSCOIN_PREFIX=/opt/syscoin-${SYSCOIN_VERSION}

RUN wget https://github.com/syscoin/syscoin/archive/refs/heads/dev-4.x-nevm.tar.gz
RUN tar -xzf *.tar.gz

WORKDIR /syscoin-dev-4.x-nevm

RUN sed -i '/AC_PREREQ/a\AR_FLAGS=cr' src/univalue/configure.ac
RUN sed -i '/AX_PROG_CC_FOR_BUILD/a\AR_FLAGS=cr' src/secp256k1/configure.ac
RUN sed -i s:sys/fcntl.h:fcntl.h: src/compat.h
RUN make -C depends -j $(nproc)
RUN ./autogen.sh
RUN CONFIG_SITE=$PWD/depends/x86_64-pc-linux-musl/share/config.site  ./configure \  
    --prefix=${SYSCOIN_PREFIX} \
    --mandir=/usr/share/man \
    --disable-tests \
    --disable-bench \
    --disable-ccache \
    --disable-maintainer-mode \
    --disable-dependency-tracking \
    --enable-reduce-exports \
    --with-gui=no \
    --with-utils \
    --with-libs \
    --with-daemon \
    CC=clang CXX=clang++ \
    CFLAGS="-O2 -g0 --static -static -fPIC" \
    CXXFLAGS="-O2 -g0 --static -static -fPIC" \
    LDFLAGS="-s -static-libgcc -static-libstdc++ -Wl,-O2"

RUN make install -j $(nproc)
RUN strip ${SYSCOIN_PREFIX}/bin/syscoin-cli
RUN strip ${SYSCOIN_PREFIX}/bin/syscoin-tx
RUN strip ${SYSCOIN_PREFIX}/bin/syscoind


# Build stage for compiled artifacts
FROM alpine

LABEL maintainer.0="Jagdeep Sidhu (@realSidhuJag)"

RUN adduser -S syscoin
RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories
RUN apk --no-cache add wget su-exec

ENV SYSCOIN_DATA=/home/syscoin/.syscoin
ENV SYSCOIN_VERSION=4.3.99
ENV SYSCOIN_PREFIX=/opt/syscoin-${SYSCOIN_VERSION}
ENV PATH=${SYSCOIN_PREFIX}/bin:$PATH

# Copy NEVM binary to the container
COPY --from=go-ethereum /go/go-ethereum/build/bin/geth ${SYSCOIN_DATA}/sysgeth
COPY --from=go-ethereum /go/go-ethereum/build/bin/faucet ${SYSCOIN_DATA}/faucet
RUN wget https://raw.githubusercontent.com/syscoin/descriptors/master/gethdescriptor.json -O ${SYSCOIN_DATA}/gethdescriptor.json

COPY --from=syscoin-core /opt /opt
COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/home/syscoin/.syscoin"]

EXPOSE 8369 8370 18369 18370 18443 18444 38332 38333

ENTRYPOINT ["/entrypoint.sh"]

RUN syscoind -version | grep "Syscoin Core version v${SYSCOIN_VERSION}"

CMD ["syscoind"]
