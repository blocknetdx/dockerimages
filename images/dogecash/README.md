Official Blocknet dogec Images
=================================

These dogec docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/dogec/

dogec
========

These dogec images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the dogec project (https://github.com/dogecash/dogecash).


Simple
======

Run a simple dogec node on port 6740:
```
docker run -d --name=dogec -p 6740:6740 blocknetdx/dogec:5.4.4
```


Persist blockchain w/ volumes
=============================

Run a dogec node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=dogec -p 6740:6740 -v=/crypto/dogec/config:/opt/blockchain/config -v=/crypto/dogec/data:/opt/blockchain/data blocknetdx/dogec:5.4.4
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|unless-stopped|always`

```
docker run -d --restart=no --name=dogec -p 6740:6740 blocknetdx/dogec:5.4.4 dogecashd -daemon=0 -rpcuser=DOGEC -rpcpassword=DOGEC123
docker run -d --restart=on-failure:10 --name=dogec -p 6740:6740 blocknetdx/dogec:5.4.4 dogecashd -daemon=0 -rpcuser=DOGEC -rpcpassword=DOGEC123
docker run -d --restart=unless-stopped --name=dogec -p 6740:6740 blocknetdx/dogec:5.4.4 dogecashd -daemon=0 -rpcuser=DOGEC -rpcpassword=DOGEC123
docker run -d --restart=always --name=dogec -p 6740:6740 blocknetdx/dogec:5.4.4 dogecashd -daemon=0 -rpcuser=DOGEC -rpcpassword=DOGEC123
```


Container shell access
======================

To login to the dogec container and run RPC commands use the following command:
```
docker exec -it dogec /bin/bash
```


Default dogecash.conf
=====================

The default configuration is below. A custom configuration file can be passed to the dogec  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data

dbcache=256
maxmempool=512

port=6740
rpcport=6783

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