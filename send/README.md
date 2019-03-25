Official Blocknet Bitcoin Images
=================================

These social send docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/social send/

social send
========

These social send images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the social send project (https://github.com/SocialSend/SocialSend).


Simple
======

Run a simple social send node on port 50050:
```
docker run -d --name=social send -p 50050:50050 blocknetdx/social send:latest
```


Persist blockchain w/ volumes
=============================

Run a social send node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=social send -p 50050:50050 -v=/crypto/social send/config:/opt/blockchain/config -v=/crypto/social send/data:/opt/blockchain/data blocknetdx/social send:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=social send -p 50050:50050 blocknetdx/social send:0.17.0.1 sendd -daemon=0 -rpcuser=send -rpcpassword=send123
docker run -d --restart=on-failure:10 --name=social send -p 50050:50050 blocknetdx/social send:0.17.0.1 sendd -daemon=0 -rpcuser=send -rpcpassword=send123
docker run -d --restart=unless-stopped --name=bitcoin -p 50050:50050 blocknetdx/social send:0.17.0.1 sendd -daemon=0 -rpcuser=send -rpcpassword=send123
docker run -d --restart=always --name=bitcoin -p 50050:50050 blocknetdx/social send:0.17.0.1 sendd -daemon=0 -rpcuser=send -rpcpassword=send123
```


Container shell access
======================

To login to the social send container and run RPC commands use the following command:
```
docker exec -it social send /bin/bash
```


Default send.conf
=====================

The default configuration is below. A custom configuration file can be passed to the social send  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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