Official Blocknet Bitcoin Images
=================================

These mnx docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/mnx/

mnx
========

These mnx images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the mnx project (https://github.com/minexcoin/minexcoin).


Simple
======

Run a simple mnx node on port 8335:
```
docker run -d --name=mnx -p 8335:8335 blocknetdx/mnx:latest
```


Persist blockchain w/ volumes
=============================

Run a mnx node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=mnx -p 8335:8335 -v=/crypto/mnx/config:/opt/blockchain/config -v=/crypto/mnx/data:/opt/blockchain/data blocknetdx/mnx:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=mnx -p 8335:8335 blocknetdx/mnx:0.17.0.1 minexcoind -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=on-failure:10 --name=mnx -p 8335:8335 blocknetdx/mnx:0.17.0.1 minexcoind -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=unless-stopped --name=bitcoin -p 8335:8335 blocknetdx/mnx:0.17.0.1 minexcoind -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=always --name=bitcoin -p 8335:8335 blocknetdx/mnx:0.17.0.1 minexcoind -daemon=0 -rpcuser= -rpcpassword=123
```


Container shell access
======================

To login to the mnx container and run RPC commands use the following command:
```
docker exec -it mnx /bin/bash
```


Default minexcoin.conf
=====================

The default configuration is below. A custom configuration file can be passed to the mnx  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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