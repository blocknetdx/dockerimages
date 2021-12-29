Official Blocknet xvg Images
=================================

These xvg docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/xvg/

xvg
========

These xvg images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the xvg project (https://github.com/vergecurrency/verge).


Simple
======

Run a simple xvg node on port 21102:
```
docker run -d --name=xvg -p 21102:21102 blocknetdx/xvg:v7.0.0
```


Persist blockchain w/ volumes
=============================

Run a xvg node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=xvg -p 21102:21102 -v=/crypto/xvg/config:/opt/blockchain/config -v=/crypto/xvg/data:/opt/blockchain/data blocknetdx/xvg:v7.0.0
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|unless-stopped|always`

```
docker run -d --restart=no --name=xvg -p 21102:21102 blocknetdx/xvg:v7.0.0 verged -daemon=0 -rpcuser=XVG -rpcpassword=XVG123
docker run -d --restart=on-failure:10 --name=xvg -p 21102:21102 blocknetdx/xvg:v7.0.0 verged -daemon=0 -rpcuser=XVG -rpcpassword=XVG123
docker run -d --restart=unless-stopped --name=xvg -p 21102:21102 blocknetdx/xvg:v7.0.0 verged -daemon=0 -rpcuser=XVG -rpcpassword=XVG123
docker run -d --restart=always --name=xvg -p 21102:21102 blocknetdx/xvg:v7.0.0 verged -daemon=0 -rpcuser=XVG -rpcpassword=XVG123
```


Container shell access
======================

To login to the xvg container and run RPC commands use the following command:
```
docker exec -it xvg /bin/bash
```


Default VERGE.conf
=====================

The default configuration is below. A custom configuration file can be passed to the xvg  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data

dbcache=256
maxmempool=512

port=21102
rpcport=20102

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