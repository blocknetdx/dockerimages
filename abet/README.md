Official Blocknet Bitcoin Images
=================================

These abet docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/abet/

abet
========

These abet images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the abet project (https://github.com/altbet/abet).


Simple
======

Run a simple abet node on port 2238:
```
docker run -d --name=abet -p 2238:2238 blocknetdx/abet:latest
```


Persist blockchain w/ volumes
=============================

Run a abet node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=abet -p 2238:2238 -v=/crypto/abet/config:/opt/blockchain/config -v=/crypto/abet/data:/opt/blockchain/data blocknetdx/abet:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=abet -p 2238:2238 blocknetdx/abet:0.17.0.1 abetd -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=on-failure:10 --name=abet -p 2238:2238 blocknetdx/abet:0.17.0.1 abetd -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=unless-stopped --name=bitcoin -p 2238:2238 blocknetdx/abet:0.17.0.1 abetd -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=always --name=bitcoin -p 2238:2238 blocknetdx/abet:0.17.0.1 abetd -daemon=0 -rpcuser= -rpcpassword=123
```


Container shell access
======================

To login to the abet container and run RPC commands use the following command:
```
docker exec -it abet /bin/bash
```


Default abet.conf
=====================

The default configuration is below. A custom configuration file can be passed to the abet  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data

dbcache=256
maxmempool=512

port=8333    # testnet: 18333
rpcport=8332 # testnet: 18332

listen=1
server=1
logtimestamps=1
logips=1

rpcallowip=127.0.0.1
rpctimeout=15
rpcclienttimeout=15
```


License
=======

This code is licensed under the Apache 2.0 License. Please refer to the [LICENSE](https://github.com/BlocknetDX/dockerimages/blob/master/LICENSE).