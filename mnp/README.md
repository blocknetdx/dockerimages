Official Blocknet Bitcoin Images
=================================

These mnp docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/mnp/

mnp
========

These mnp images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the mnp project (https://github.com/MasterNodesPro/MNPCoin).


Simple
======

Run a simple mnp node on port 13371:
```
docker run -d --name=mnp -p 13371:13371 blocknetdx/mnp:latest
```


Persist blockchain w/ volumes
=============================

Run a mnp node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=mnp -p 13371:13371 -v=/crypto/mnp/config:/opt/blockchain/config -v=/crypto/mnp/data:/opt/blockchain/data blocknetdx/mnp:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=mnp -p 13371:13371 blocknetdx/mnp:0.17.0.1 mnpcoind -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=on-failure:10 --name=mnp -p 13371:13371 blocknetdx/mnp:0.17.0.1 mnpcoind -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=unless-stopped --name=bitcoin -p 13371:13371 blocknetdx/mnp:0.17.0.1 mnpcoind -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=always --name=bitcoin -p 13371:13371 blocknetdx/mnp:0.17.0.1 mnpcoind -daemon=0 -rpcuser= -rpcpassword=123
```


Container shell access
======================

To login to the mnp container and run RPC commands use the following command:
```
docker exec -it mnp /bin/bash
```


Default mnpcoin.conf
=====================

The default configuration is below. A custom configuration file can be passed to the mnp  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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