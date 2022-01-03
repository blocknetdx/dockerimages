Official Blocknet btc Images
=================================

These btc docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/btc/

btc
========

These btc images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the btc project (https://github.com/bitcoin/bitcoin).


Simple
======

Run a simple btc node on port 8333:
```
docker run -d --name=btc -p 8333:8333 blocknetdx/btc:v0.22.0
```


Persist blockchain w/ volumes
=============================

Run a btc node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=btc -p 8333:8333 -v=/crypto/btc/config:/opt/blockchain/config -v=/crypto/btc/data:/opt/blockchain/data blocknetdx/btc:v0.22.0
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|unless-stopped|always`

```
docker run -d --restart=no --name=btc -p 8333:8333 blocknetdx/btc:v0.22.0 bitcoind -daemon=0 -rpcuser=BTC -rpcpassword=BTC123
docker run -d --restart=on-failure:10 --name=btc -p 8333:8333 blocknetdx/btc:v0.22.0 bitcoind -daemon=0 -rpcuser=BTC -rpcpassword=BTC123
docker run -d --restart=unless-stopped --name=btc -p 8333:8333 blocknetdx/btc:v0.22.0 bitcoind -daemon=0 -rpcuser=BTC -rpcpassword=BTC123
docker run -d --restart=always --name=btc -p 8333:8333 blocknetdx/btc:v0.22.0 bitcoind -daemon=0 -rpcuser=BTC -rpcpassword=BTC123
```


Container shell access
======================

To login to the btc container and run RPC commands use the following command:
```
docker exec -it btc /bin/bash
```


Default bitcoin.conf
=====================

The default configuration is below. A custom configuration file can be passed to the btc  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data

dbcache=256
maxmempool=512

port=8333
rpcport=8332

listen=1
txindex=1
server=1
maxconnections=16
logtimestamps=1
logips=1

rpcallowip=127.0.0.1
rpcwaittimeout=30
rpcclienttimeout=30
```


License
=======

This code is licensed under the Apache 2.0 License. Please refer to the [LICENSE](https://github.com/BlocknetDX/dockerimages/blob/master/LICENSE).