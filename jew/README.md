Official Blocknet Bitcoin Images
=================================

These jew docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/jew/

jew
========

These jew images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the jew project (https://github.com/shekeltechnologies/JewNew).


Simple
======

Run a simple jew node on port 5500:
```
docker run -d --name=jew -p 5500:5500 blocknetdx/jew:latest
```


Persist blockchain w/ volumes
=============================

Run a jew node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=jew -p 5500:5500 -v=/crypto/jew/config:/opt/blockchain/config -v=/crypto/jew/data:/opt/blockchain/data blocknetdx/jew:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=jew -p 5500:5500 blocknetdx/jew:0.17.0.1 shekeld -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=on-failure:10 --name=jew -p 5500:5500 blocknetdx/jew:0.17.0.1 shekeld -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=unless-stopped --name=bitcoin -p 5500:5500 blocknetdx/jew:0.17.0.1 shekeld -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=always --name=bitcoin -p 5500:5500 blocknetdx/jew:0.17.0.1 shekeld -daemon=0 -rpcuser= -rpcpassword=123
```


Container shell access
======================

To login to the jew container and run RPC commands use the following command:
```
docker exec -it jew /bin/bash
```


Default shekel.conf
=====================

The default configuration is below. A custom configuration file can be passed to the jew  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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