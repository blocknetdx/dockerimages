Official Blocknet Litecoin Images
=================================

These litecoin docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/litecoin/

Litecoin
========

These litecoin images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the Litecoin Project (https://github.com/litecoin-project/litecoin).


Simple
======

Run a simple litecoin node on port 9333:
```
docker run -d --name=litecoin -p 9333:9333 blocknetdx/litecoin:0.14.2
```


Persist blockchain w/ volumes
=============================

Run a litecoin node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=litecoin -p 9333:9333 -v=/crypto/litecoin/config:/opt/blockchain/config -v=/crypto/litecoin/data:/opt/blockchain/data blocknetdx/litecoin:0.14.2
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/ 

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=litecoin -p 9333:9333 blocknetdx/litecoin:0.14.2 litecoind -daemon=0 -rpcuser=ltc -rpcpassword=ltc123
docker run -d --restart=on-failure:10 --name=litecoin -p 9333:9333 blocknetdx/litecoin:0.14.2 litecoind -daemon=0 -rpcuser=ltc -rpcpassword=ltc123
docker run -d --restart=unless-stopped --name=litecoin -p 9333:9333 blocknetdx/litecoin:0.14.2 litecoind -daemon=0 -rpcuser=ltc -rpcpassword=ltc123
docker run -d --restart=always --name=litecoin -p 9333:9333 blocknetdx/litecoin:0.14.2 litecoind -daemon=0 -rpcuser=ltc -rpcpassword=ltc123
```


Container shell access
======================

To login to the litecoin container and run RPC commands use the following command:
```
docker exec -it litecoin /bin/bash
```


Default litecoin.conf
=====================

The default configuration is below. A custom configuration file can be passed to the litecoin node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data
                             
dbcache=256                  
maxmempool=512               
                             
port=9333    # testnet: 19333
rpcport=9332 # testnet: 19332
                             
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