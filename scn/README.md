Official Blocknet Bitcoin Images
=================================

These secure cloud net docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/secure cloud net/

secure cloud net
========

These secure cloud net images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the secure cloud net project (https://github.com/securecloudnet/SecureCloud).


Simple
======

Run a simple secure cloud net node on port 9190:
```
docker run -d --name=secure cloud net -p 9190:9190 blocknetdx/secure cloud net:latest
```


Persist blockchain w/ volumes
=============================

Run a secure cloud net node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=secure cloud net -p 9190:9190 -v=/crypto/secure cloud net/config:/opt/blockchain/config -v=/crypto/secure cloud net/data:/opt/blockchain/data blocknetdx/secure cloud net:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=secure cloud net -p 9190:9190 blocknetdx/secure cloud net:0.17.0.1 securecloudd -daemon=0 -rpcuser=scn -rpcpassword=scn123
docker run -d --restart=on-failure:10 --name=secure cloud net -p 9190:9190 blocknetdx/secure cloud net:0.17.0.1 securecloudd -daemon=0 -rpcuser=scn -rpcpassword=scn123
docker run -d --restart=unless-stopped --name=bitcoin -p 9190:9190 blocknetdx/secure cloud net:0.17.0.1 securecloudd -daemon=0 -rpcuser=scn -rpcpassword=scn123
docker run -d --restart=always --name=bitcoin -p 9190:9190 blocknetdx/secure cloud net:0.17.0.1 securecloudd -daemon=0 -rpcuser=scn -rpcpassword=scn123
```


Container shell access
======================

To login to the secure cloud net container and run RPC commands use the following command:
```
docker exec -it secure cloud net /bin/bash
```


Default securecloud.conf
=====================

The default configuration is below. A custom configuration file can be passed to the secure cloud net  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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