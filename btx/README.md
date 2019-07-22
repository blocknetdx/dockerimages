Official Blocknet Bitcore Images
=================================

These bitcore docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/bitcore/

Bitcore
========

These bitcore images are optimized for use with the Blocknet DX.

**Note**

These images are _not a replacement or endorsement_ of the Bitcore Project (https://github.com/LIMXTEC/BitCore).


Simple
======

Run a simple bitcore node on port 8555:
```
docker run -d --name=bitcore -p 8555:8555 blocknetdx/bitcore:latest
```


Persist blockchain w/ volumes
=============================

Run a bitcore node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=bitcore -p 8555:8555 -v=/crypto/bitcore/config:/opt/blockchain/config -v=/crypto/bitcore/data:/opt/blockchain/data blocknetdx/bitcore:0.15.2.0
```


Automatically restart the container
===================================

See https://docs.docker.com/engine/admin/start-containers-automatically/ 

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no --name=bitcore -p 8555:8555 blocknetdx/bitcore:0.15.2.0 bitcored -daemon=0 -rpcuser=btx -rpcpassword=btx123
docker run -d --restart=on-failure:10 --name=bitcore -p 8555:8555 blocknetdx/bitcore:0.15.2.0 bitcored -daemon=0 -rpcuser=btx -rpcpassword=btx123
docker run -d --restart=unless-stopped --name=bitcore -p 8555:8555 blocknetdx/bitcore:0.15.2.0 bitcored -daemon=0 -rpcuser=btx -rpcpassword=btx123
docker run -d --restart=always --name=bitcore -p 8555:8555 blocknetdx/bitcore:0.15.2.0 bitcored -daemon=0 -rpcuser=btx -rpcpassword=btx123
```


Container shell access
======================

To login to the bitcore container and run RPC commands use the following command:
```
docker exec -it bitcore /bin/bash
```


Default bitcore.conf
=====================

The default configuration is below. A custom configuration file can be passed to the bitcore node container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data
                             
dbcache=256                  
maxmempool=512               
                             
port=8555    # testnet: 8666
rpcport=8556 # testnet: 50332
                             
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
