Official Blocknet dash Images
=================================

These dash docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/dash/

dash
========

These dash images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the dash project (https://github.com/dashpay/dash).


Simple
======

Run a simple dash node on port 9999:
```
docker run -d --name=dash -p 9999:9999 blocknetdx/dash:v0.18.0.1
```


Persist blockchain w/ volumes
=============================

Run a dash node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=dash -p 9999:9999 -v=/crypto/dash/config:/opt/blockchain/config -v=/crypto/dash/data:/opt/blockchain/data blocknetdx/dash:v0.18.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|unless-stopped|always`

```
docker run -d --restart=no --name=dash -p 9999:9999 blocknetdx/dash:v0.18.0.1 dashd -daemon=0 -rpcuser=DASH -rpcpassword=DASH123
docker run -d --restart=on-failure:10 --name=dash -p 9999:9999 blocknetdx/dash:v0.18.0.1 dashd -daemon=0 -rpcuser=DASH -rpcpassword=DASH123
docker run -d --restart=unless-stopped --name=dash -p 9999:9999 blocknetdx/dash:v0.18.0.1 dashd -daemon=0 -rpcuser=DASH -rpcpassword=DASH123
docker run -d --restart=always --name=dash -p 9999:9999 blocknetdx/dash:v0.18.0.1 dashd -daemon=0 -rpcuser=DASH -rpcpassword=DASH123
```


Container shell access
======================

To login to the dash container and run RPC commands use the following command:
```
docker exec -it dash /bin/bash
```


Default dash.conf
=====================

The default configuration is below. A custom configuration file can be passed to the dash  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data

dbcache=256
maxmempool=512

port=9999
rpcport=9998

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