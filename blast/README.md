Official Blocknet Bitcoin Images
=================================

These blast docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/blast/

blast
========

These blast images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the blast project (https://github.com/blastdev/blast-core).


Simple
======

Run a simple blast node on port 64640:
```
docker run -d --name=blast -p 64640:64640 blocknetdx/blast:latest
```


Persist blockchain w/ volumes
=============================

Run a blast node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=blast -p 64640:64640 -v=/crypto/blast/config:/opt/blockchain/config -v=/crypto/blast/data:/opt/blockchain/data blocknetdx/blast:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=blast -p 64640:64640 blocknetdx/blast:0.17.0.1 blastd -daemon=0 -rpcuser=blast -rpcpassword=blast123
docker run -d --restart=on-failure:10 --name=blast -p 64640:64640 blocknetdx/blast:0.17.0.1 blastd -daemon=0 -rpcuser=blast -rpcpassword=blast123
docker run -d --restart=unless-stopped --name=bitcoin -p 64640:64640 blocknetdx/blast:0.17.0.1 blastd -daemon=0 -rpcuser=blast -rpcpassword=blast123
docker run -d --restart=always --name=bitcoin -p 64640:64640 blocknetdx/blast:0.17.0.1 blastd -daemon=0 -rpcuser=blast -rpcpassword=blast123
```


Container shell access
======================

To login to the blast container and run RPC commands use the following command:
```
docker exec -it blast /bin/bash
```


Default blast.conf
=====================

The default configuration is below. A custom configuration file can be passed to the blast  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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