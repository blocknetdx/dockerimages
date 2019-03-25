Official Blocknet Bitcoin Images
=================================

These crowdcoin docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/crowdcoin/

crowdcoin
========

These crowdcoin images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the crowdcoin project (https://github.com/crowdcoinChain/Crowdcoin).


Simple
======

Run a simple crowdcoin node on port 12875:
```
docker run -d --name=crowdcoin -p 12875:12875 blocknetdx/crowdcoin:latest
```


Persist blockchain w/ volumes
=============================

Run a crowdcoin node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=crowdcoin -p 12875:12875 -v=/crypto/crowdcoin/config:/opt/blockchain/config -v=/crypto/crowdcoin/data:/opt/blockchain/data blocknetdx/crowdcoin:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=crowdcoin -p 12875:12875 blocknetdx/crowdcoin:0.17.0.1 crowdcoind -daemon=0 -rpcuser=crc -rpcpassword=crc123
docker run -d --restart=on-failure:10 --name=crowdcoin -p 12875:12875 blocknetdx/crowdcoin:0.17.0.1 crowdcoind -daemon=0 -rpcuser=crc -rpcpassword=crc123
docker run -d --restart=unless-stopped --name=bitcoin -p 12875:12875 blocknetdx/crowdcoin:0.17.0.1 crowdcoind -daemon=0 -rpcuser=crc -rpcpassword=crc123
docker run -d --restart=always --name=bitcoin -p 12875:12875 blocknetdx/crowdcoin:0.17.0.1 crowdcoind -daemon=0 -rpcuser=crc -rpcpassword=crc123
```


Container shell access
======================

To login to the crowdcoin container and run RPC commands use the following command:
```
docker exec -it crowdcoin /bin/bash
```


Default crowdcoin.conf
=====================

The default configuration is below. A custom configuration file can be passed to the crowdcoin  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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