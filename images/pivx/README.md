Official Blocknet PIVX Images
=================================

These PIVX docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/PIVX/

PIVX
========

These PIVX images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the PIVX Project (https://github.com/PIVX-project/PIVX).


Simple
======

Run a simple PIVX node on port 51472:
```
docker run -d --name=pivx -p 51472:51472 blocknetdx/pivx:latest
```


Persist blockchain w/ volumes
=============================

Run a PIVX node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=pivx -p 51472:51472 -v=/crypto/pivx/config:/opt/blockchain/config -v=/crypto/pivx/data:/opt/blockchain/data blocknetdx/pivx:v5.3.2.1
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/ 

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=pivx -p 51472:51472 blocknetdx/pivx:0.14.2 pivxd -daemon=0 -rpcuser=pivx -rpcpassword=pivx123
docker run -d --restart=on-failure:10 --name=pivx -p 51472:51472 blocknetdx/pivx:0.14.2 pivxd -daemon=0 -rpcuser=pivx -rpcpassword=pivx123
docker run -d --restart=unless-stopped --name=pivx -p 51472:51472 blocknetdx/pivx:0.14.2 pivxd -daemon=0 -rpcuser=pivx -rpcpassword=pivx123
docker run -d --restart=always --name=pivx -p 51472:51472 blocknetdx/pivx:v5.3.2.1 pivxd -daemon=0 -rpcuser=pivx -rpcpassword=pivx123
```


Container shell access
======================

To login to the PIVX container and run RPC commands use the following command:
```
docker exec -it pivx /bin/bash
```


Default pivx.conf
=====================

The default configuration is below. A custom configuration file can be passed to the PIVX node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data
                             
port=51472    # testnet: 51473
rpcport=51474 # testnet: 51475
                             
listen=1                     
server=1                     
maxconnections=16            
logtimestamps=1              
logips=1                     
                             
rpcallowip=0.0.0.0/0
rpcbind=0.0.0.0     
rpctimeout=30                
rpcclienttimeout=30
```


License
=======

This code is licensed under the Apache 2.0 License. Please refer to the [LICENSE](https://github.com/BlocknetDX/dockerimages/blob/master/LICENSE).