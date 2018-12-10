Official Blocknet Monacoin Images
=================================

These monacoin docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/monacoin/

Monacoin
========

These monacoin images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the Monacoin project (https://github.com/monacoinproject/monacoin).


Simple
======

Run a simple monacoin node on port 9401:
```
docker run -d --name=monacoin -p 9401:9401 blocknetdx/monacoin:latest
```


Persist blockchain w/ volumes
=============================

Run a monacoin node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=monacoin -p 9401:9401 -v=/crypto/monacoin/config:/opt/blockchain/config -v=/crypto/monacoin/data:/opt/blockchain/data blocknetdx/monacoin:0.14.2
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/ 

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=monacoin -p 9401:9401 blocknetdx/monacoin:0.14.2 monacoind -daemon=0 -rpcuser=mona -rpcpassword=mona123
docker run -d --restart=on-failure:10 --name=monacoin -p 9401:9401 blocknetdx/monacoin:0.14.2 monacoind -daemon=0 -rpcuser=mona -rpcpassword=mona123
docker run -d --restart=unless-stopped --name=monacoin -p 9401:9401 blocknetdx/monacoin:0.14.2 monacoind -daemon=0 -rpcuser=mona -rpcpassword=mona123
docker run -d --restart=always --name=monacoin -p 9401:9401 blocknetdx/monacoin:0.14.2 monacoind -daemon=0 -rpcuser=mona -rpcpassword=mona123
```


Container shell access
======================

To login to the monacoin container and run RPC commands use the following command:
```
docker exec -it monacoin /bin/bash
```


Default monacoin.conf
=====================

The default configuration is below. A custom configuration file can be passed to the monacoin node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data
                             
dbcache=256                  
maxmempool=512               
                             
port=9401    # testnet: 19403
rpcport=9402 # testnet: 19402
                             
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

