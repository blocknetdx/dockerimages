Official Blocknet Bitcoin Images
=================================

These agm docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/agm/

agm
========

These agm images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the agm project (https://github.com/Argoneum/argoneum).


Simple
======

Run a simple agm node on port 9898:
```
docker run -d --name=agm -p 9898:9898 blocknetdx/agm:latest
```


Persist blockchain w/ volumes
=============================

Run a agm node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=agm -p 9898:9898 -v=/crypto/agm/config:/opt/blockchain/config -v=/crypto/agm/data:/opt/blockchain/data blocknetdx/agm:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=agm -p 9898:9898 blocknetdx/agm:0.17.0.1 argoneumd -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=on-failure:10 --name=agm -p 9898:9898 blocknetdx/agm:0.17.0.1 argoneumd -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=unless-stopped --name=bitcoin -p 9898:9898 blocknetdx/agm:0.17.0.1 argoneumd -daemon=0 -rpcuser= -rpcpassword=123
docker run -d --restart=always --name=bitcoin -p 9898:9898 blocknetdx/agm:0.17.0.1 argoneumd -daemon=0 -rpcuser= -rpcpassword=123
```


Container shell access
======================

To login to the agm container and run RPC commands use the following command:
```
docker exec -it agm /bin/bash
```


Default argoneum.conf
=====================

The default configuration is below. A custom configuration file can be passed to the agm  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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