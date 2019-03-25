Official Blocknet Bitcoin Images
=================================

These cryptocashback docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/cryptocashback/

cryptocashback
========

These cryptocashback images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the cryptocashback project (https://github.com/CryptoCashBack-Hub/CCBC).


Simple
======

Run a simple cryptocashback node on port 5520:
```
docker run -d --name=cryptocashback -p 5520:5520 blocknetdx/cryptocashback:latest
```


Persist blockchain w/ volumes
=============================

Run a cryptocashback node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=cryptocashback -p 5520:5520 -v=/crypto/cryptocashback/config:/opt/blockchain/config -v=/crypto/cryptocashback/data:/opt/blockchain/data blocknetdx/cryptocashback:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=cryptocashback -p 5520:5520 blocknetdx/cryptocashback:0.17.0.1 ccbcd -daemon=0 -rpcuser=ccbc -rpcpassword=ccbc123
docker run -d --restart=on-failure:10 --name=cryptocashback -p 5520:5520 blocknetdx/cryptocashback:0.17.0.1 ccbcd -daemon=0 -rpcuser=ccbc -rpcpassword=ccbc123
docker run -d --restart=unless-stopped --name=bitcoin -p 5520:5520 blocknetdx/cryptocashback:0.17.0.1 ccbcd -daemon=0 -rpcuser=ccbc -rpcpassword=ccbc123
docker run -d --restart=always --name=bitcoin -p 5520:5520 blocknetdx/cryptocashback:0.17.0.1 ccbcd -daemon=0 -rpcuser=ccbc -rpcpassword=ccbc123
```


Container shell access
======================

To login to the cryptocashback container and run RPC commands use the following command:
```
docker exec -it cryptocashback /bin/bash
```


Default ccbc.conf
=====================

The default configuration is below. A custom configuration file can be passed to the cryptocashback  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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