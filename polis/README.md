Official Blocknet Bitcoin Images
=================================

These polis docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/polis/

polis
========

These polis images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the polis project (https://github.com/polispay/polis).


Simple
======

Run a simple polis node on port 24126:
```
docker run -d --name=polis -p 24126:24126 blocknetdx/polis:latest
```


Persist blockchain w/ volumes
=============================

Run a polis node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=polis -p 24126:24126 -v=/crypto/polis/config:/opt/blockchain/config -v=/crypto/polis/data:/opt/blockchain/data blocknetdx/polis:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=polis -p 24126:24126 blocknetdx/polis:0.17.0.1 polisd -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=on-failure:10 --name=polis -p 24126:24126 blocknetdx/polis:0.17.0.1 polisd -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=unless-stopped --name=bitcoin -p 24126:24126 blocknetdx/polis:0.17.0.1 polisd -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=always --name=bitcoin -p 24126:24126 blocknetdx/polis:0.17.0.1 polisd -daemon=0 -rpcuser= -rpcpassword=123
```


Container shell access
======================

To login to the polis container and run RPC commands use the following command:
```
docker exec -it polis /bin/bash
```


Default polis.conf
=====================

The default configuration is below. A custom configuration file can be passed to the polis  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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