Official Blocknet sys Images
=================================

These sys docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/sys/

sys
========

These sys images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the sys project (https://github.com/syscoin/syscoin).


Simple
======

Run a simple sys node on port 8369:
```
docker run -d --name=sys -p 8369:8369 blocknetdx/sys:v4.3.0
```


Persist blockchain w/ volumes
=============================

Run a sys node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=sys -p 8369:8369 -v=/crypto/sys/config:/opt/blockchain/config -v=/crypto/sys/data:/opt/blockchain/data blocknetdx/sys:v4.3.0
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|unless-stopped|always`

```
docker run -d --restart=no --name=sys -p 8369:8369 blocknetdx/sys:v4.3.0 syscoind -daemon=0 -rpcuser=SYS -rpcpassword=SYS123
docker run -d --restart=on-failure:10 --name=sys -p 8369:8369 blocknetdx/sys:v4.3.0 syscoind -daemon=0 -rpcuser=SYS -rpcpassword=SYS123
docker run -d --restart=unless-stopped --name=sys -p 8369:8369 blocknetdx/sys:v4.3.0 syscoind -daemon=0 -rpcuser=SYS -rpcpassword=SYS123
docker run -d --restart=always --name=sys -p 8369:8369 blocknetdx/sys:v4.3.0 syscoind -daemon=0 -rpcuser=SYS -rpcpassword=SYS123
```


Container shell access
======================

To login to the sys container and run RPC commands use the following command:
```
docker exec -it sys /bin/bash
```


Default syscoin.conf
=====================

The default configuration is below. A custom configuration file can be passed to the sys  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data

dbcache=256
maxmempool=512

port=8369
rpcport=8370

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