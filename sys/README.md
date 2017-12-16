Official Blocknet Syscoin2 Images
=================================

These syscoin2 docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/syscoin2/

Syscoin2
========

These syscoin2 images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the Syscoin2 project (https://github.com/syscoin/syscoin2).


Simple
======

Run a simple syscoin2 node on port 8369:
```
docker run -d --name=syscoin2 -p 8369:8369 blocknetdx/syscoin2:2.1.5
```


Persist blockchain w/ volumes
=============================

Run a syscoin2 node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=syscoin2 -p 8369:8369 -v=/crypto/syscoin2/config:/opt/blockchain/config -v=/crypto/syscoin2/data:/opt/blockchain/data blocknetdx/syscoin2:2.1.5
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/ 

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=syscoin2 -p 8369:8369 blocknetdx/syscoin2:2.1.5 syscoind -daemon=0 -rpcuser=sys -rpcpassword=sys123
docker run -d --restart=on-failure:10 --name=syscoin2 -p 8369:8369 blocknetdx/syscoin2:2.1.5 syscoind -daemon=0 -rpcuser=sys -rpcpassword=sys123
docker run -d --restart=unless-stopped --name=syscoin2 -p 8369:8369 blocknetdx/syscoin2:2.1.5 syscoind -daemon=0 -rpcuser=sys -rpcpassword=sys123
docker run -d --restart=always --name=syscoin2 -p 8369:8369 blocknetdx/syscoin2:2.1.5 syscoind -daemon=0 -rpcuser=sys -rpcpassword=sys123
```


Container shell access
======================

To login to the syscoin2 container and run RPC commands use the following command:
```
docker exec -it syscoin2 /bin/bash
```


Default syscoin2.conf
=====================

The default configuration is below. A custom configuration file can be passed to the syscoin2 node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
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

