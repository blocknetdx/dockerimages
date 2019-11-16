Official Blocknet Bitcoin Images
=================================

These sub1x docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/sub1x/

sub1x
========

These sub1x images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the sub1x project (https://github.com/SuB1X-Coin/zSub1x).


Simple
======

Run a simple sub1x node on port 5721:
```
docker run -d --name=sub1x -p 5721:5721 blocknetdx/sub1x:latest
```


Persist blockchain w/ volumes
=============================

Run a sub1x node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=sub1x -p 5721:5721 -v=/crypto/sub1x/config:/opt/blockchain/config -v=/crypto/sub1x/data:/opt/blockchain/data blocknetdx/sub1x:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=sub1x -p 5721:5721 blocknetdx/sub1x:0.17.0.1 zsub1xd -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=on-failure:10 --name=sub1x -p 5721:5721 blocknetdx/sub1x:0.17.0.1 zsub1xd -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=unless-stopped --name=bitcoin -p 5721:5721 blocknetdx/sub1x:0.17.0.1 zsub1xd -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=always --name=bitcoin -p 5721:5721 blocknetdx/sub1x:0.17.0.1 zsub1xd -daemon=0 -rpcuser= -rpcpassword=123
```


Container shell access
======================

To login to the sub1x container and run RPC commands use the following command:
```
docker exec -it sub1x /bin/bash
```


Default zsub1x.conf
=====================

The default configuration is below. A custom configuration file can be passed to the sub1x  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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