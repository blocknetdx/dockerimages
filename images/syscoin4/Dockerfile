FROM debian:bullseye-slim

LABEL maintainer.0="Jagdeep Sidhu (@realSidhuJag)"

RUN useradd -r syscoin \
  && apt-get update -y \
  && apt-get install -y curl gnupg gosu \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG TARGETPLATFORM=linux/amd64
ENV SYSCOIN_VERSION=4.2.2
ENV SYSCOIN_DATA=/home/syscoin/.syscoin
ENV PATH=/opt/syscoin-${SYSCOIN_VERSION}/bin:$PATH

RUN set -ex \
  && if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then export TARGETPLATFORM=x86_64-linux-gnu; fi \
  && if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then export TARGETPLATFORM=aarch64-linux-gnu; fi \
  && if [ "${TARGETPLATFORM}" = "linux/arm/v7" ]; then export TARGETPLATFORM=arm-linux-gnueabihf; fi \
  && curl -SLO https://github.com/syscoin/syscoin/releases/download/v${SYSCOIN_VERSION}/syscoin-${SYSCOIN_VERSION}-${TARGETPLATFORM}.tar.gz \
  && curl -SLO https://github.com/syscoin/syscoin/releases/download/v${SYSCOIN_VERSION}/SHA256SUMS.asc \
  && sha256sum --ignore-missing --check SHA256SUMS.asc \
  && gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 79D00BAC68B56D422F945A8F8E3A8F3247DBCBBF \
  && gpg --verify SHA256SUMS.asc \
  && grep " syscoin-${SYSCOIN_VERSION}-${TARGETPLATFORM}.tar.gz" SHA256SUMS.asc | sha256sum -c - \
  && tar -xzf *.tar.gz -C /opt \
  && rm *.tar.gz *.asc \
  && rm -rf /opt/syscoin-${SYSCOIN_VERSION}/bin/syscoin-qt

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/home/syscoin/.syscoin"]

EXPOSE 8369 8370 18369 18370 18443 18444 38332 38333


ENTRYPOINT ["/entrypoint.sh"]

RUN syscoind -version | grep "Syscoin Core version v${SYSCOIN_VERSION}"

CMD ["syscoind"]
