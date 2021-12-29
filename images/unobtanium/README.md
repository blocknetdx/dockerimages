Official Blocknet uno Images
=================================

These uno docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/uno/

uno
========

These uno images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the uno project (https://github.com/unobtanium-official/Unobtanium).


Simple
======

Run a simple uno node on port 65534:
```
docker run -d --name=uno -p 65534:65534 blocknetdx/uno:v0.11.5
```


Persist blockchain w/ volumes
=============================

Run a uno node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=uno -p 65534:65534 -v=/crypto/uno/config:/opt/blockchain/config -v=/crypto/uno/data:/opt/blockchain/data blocknetdx/uno:v0.11.5
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|unless-stopped|always`

```
docker run -d --restart=no --name=uno -p 65534:65534 blocknetdx/uno:v0.11.5 unobtaniumd -daemon=0 -rpcuser=UNO -rpcpassword=UNO123
docker run -d --restart=on-failure:10 --name=uno -p 65534:65534 blocknetdx/uno:v0.11.5 unobtaniumd -daemon=0 -rpcuser=UNO -rpcpassword=UNO123
docker run -d --restart=unless-stopped --name=uno -p 65534:65534 blocknetdx/uno:v0.11.5 unobtaniumd -daemon=0 -rpcuser=UNO -rpcpassword=UNO123
docker run -d --restart=always --name=uno -p 65534:65534 blocknetdx/uno:v0.11.5 unobtaniumd -daemon=0 -rpcuser=UNO -rpcpassword=UNO123
```


Container shell access
======================

To login to the uno container and run RPC commands use the following command:
```
docker exec -it uno /bin/bash
```


Default unobtanium.conf
=====================

The default configuration is below. A custom configuration file can be passed to the uno  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data

dbcache=256
maxmempool=512

port=65534
rpcport=65535

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