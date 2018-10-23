Official Blocknet Syscoin3 Images
=================================

These Syscoin docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/syscoin3/

Syscoin
========

These Syscoin images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the Syscoin project (https://github.com/syscoin/syscoin).


Simple
======

Run a simple Syscoin node on port 8369:
```
docker run -d --name=syscoin -p 8369:8369 blocknetdx/syscoin3:3.0.4
```


Persist blockchain w/ volumes
=============================

Run a syscoin node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=syscoin -p 8369:8369 -v=/crypto/syscoin/config:/opt/blockchain/config -v=/crypto/syscoin/data:/opt/blockchain/data blocknetdx/syscoin3:3.0.4
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=syscoin -p 8369:8369 blocknetdx/syscoin:3.0.4 syscoind -daemon=0 -rpcuser=sys -rpcpassword=sys123
docker run -d --restart=on-failure:10 --name=syscoin -p 8369:8369 blocknetdx/syscoin:3.0.4 syscoind -daemon=0 -rpcuser=sys -rpcpassword=sys123
docker run -d --restart=unless-stopped --name=syscoin -p 8369:8369 blocknetdx/syscoin:3.0.4 syscoind -daemon=0 -rpcuser=sys -rpcpassword=sys123
docker run -d --restart=always --name=syscoin -p 8369:8369 blocknetdx/syscoin:3.0.4 syscoind -daemon=0 -rpcuser=sys -rpcpassword=sys123
```


Container shell access
======================

To login to the syscoin container and run RPC commands use the following command:
```
docker exec -it syscoin /bin/bash
```


Default syscoin.conf
=====================

The default configuration is below. A custom configuration file can be passed to the syscoin node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data

dbcache=256                  
maxmempool=512               

port=8369    # testnet: 18369
rpcport=8370 # testnet: 18370

listen=1                     
server=1                     
maxconnections=16            
logtimestamps=1              
logips=1                     

rpcallowip=127.0.0.1         
rpctimeout=15                
rpcclienttimeout=15
```


License
=======

This code is licensed under the Apache 2.0 License. Please refer to the [LICENSE](https://github.com/BlocknetDX/dockerimages/blob/master/LICENSE).
