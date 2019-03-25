Official Blocknet Bitcoin Images
=================================

These light pay coin docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/light pay coin/

light pay coin
========

These light pay coin images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the light pay coin project (https://github.com/lpcproject/LightPayCoin).


Simple
======

Run a simple light pay coin node on port 39797:
```
docker run -d --name=light pay coin -p 39797:39797 blocknetdx/light pay coin:latest
```


Persist blockchain w/ volumes
=============================

Run a light pay coin node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=light pay coin -p 39797:39797 -v=/crypto/light pay coin/config:/opt/blockchain/config -v=/crypto/light pay coin/data:/opt/blockchain/data blocknetdx/light pay coin:0.17.0.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=light pay coin -p 39797:39797 blocknetdx/light pay coin:0.17.0.1 lightpaycoind -daemon=0 -rpcuser=lpc -rpcpassword=lpc123
docker run -d --restart=on-failure:10 --name=light pay coin -p 39797:39797 blocknetdx/light pay coin:0.17.0.1 lightpaycoind -daemon=0 -rpcuser=lpc -rpcpassword=lpc123
docker run -d --restart=unless-stopped --name=bitcoin -p 39797:39797 blocknetdx/light pay coin:0.17.0.1 lightpaycoind -daemon=0 -rpcuser=lpc -rpcpassword=lpc123
docker run -d --restart=always --name=bitcoin -p 39797:39797 blocknetdx/light pay coin:0.17.0.1 lightpaycoind -daemon=0 -rpcuser=lpc -rpcpassword=lpc123
```


Container shell access
======================

To login to the light pay coin container and run RPC commands use the following command:
```
docker exec -it light pay coin /bin/bash
```


Default lightpaycoin.conf
=====================

The default configuration is below. A custom configuration file can be passed to the light pay coin  node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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