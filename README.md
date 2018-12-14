Official Blocknet Docker Images
===============================

The docker images can be found on the docker hub: https://hub.docker.com/u/blocknetdx/

Servicenodes
============

By default the servicenode container runs without rpc capabilities `-server=0`.

### Simple

Run a simple node on port 41412 without any servicenode capabilities.
```
docker run -d --name=snode -p 41412:41412 blocknetdx/servicenode:latest
```

### Persist blockchain w/ volumes

Run a node that persists the blockchain on a host directory. Recommended to avoid time consuming resyncs when updating to later container versions.
```
docker run -d --name=snode -p 41412:41412 -v=/crypto/block/config:/opt/blockchain/config -v=/crypto/block/data:/opt/blockchain/data blocknetdx/servicenode:latest
```

### Enable Servicenode (manually overridding config values)

When manually overridding the blocknetdxd command line arguments you must set `-daemon=0` (blocking), otherwise the container will exit immediately. Using `-daemon=0` will allow OS signals pass directly to blocknetdxd resulting in proper shutdowns (which will prevent corrupting the blockchain).

This command runs the container as a servicenode (do not use these exact values in production):
```
docker run -d --name=snode -p 41412:41412 blocknetdx/servicenode:latest blocknetdxd -daemon=0 -rpcuser=sn1 -rpcpassword=servicenode123 -servicenode=1 -servicenodeaddr=192.168.1.252 -servicenodeprivkey=1AqiKXiSZKf1BFQqqB2Mk3NVz7jFM2Za4r7eNzu3DWActGPeZ2L
```

### Automatically restart the container

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no             --name=snode -p 41412:41412 blocknetdx/servicenode:latest blocknetdxd -daemon=0 -rpcuser=sn1 -rpcpassword=servicenode123
docker run -d --restart=on-failure:10  --name=snode -p 41412:41412 blocknetdx/servicenode:latest blocknetdxd -daemon=0 -rpcuser=sn1 -rpcpassword=servicenode123
docker run -d --restart=unless-stopped --name=snode -p 41412:41412 blocknetdx/servicenode:latest blocknetdxd -daemon=0 -rpcuser=sn1 -rpcpassword=servicenode123
docker run -d --restart=always         --name=snode -p 41412:41412 blocknetdx/servicenode:latest blocknetdxd -daemon=0 -rpcuser=sn1 -rpcpassword=servicenode123
```

### Container shell access

```
docker exec -it snode /bin/bash
```

### Default blocknetdx.conf

The default configuration is below. A custom configuration file can be passed to the servicenode container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data  

dbcache=256                   
maxmempool=512                

port=41412    # testnet: 41474
rpcport=41414 # testnet: 41419

listen=1                      
server=1                      
maxconnections=100            
logtimestamps=1               
logips=1                      

rpcallowip=127.0.0.1          
rpctimeout=15                 
rpcclienttimeout=15           
```

License
=======

This code is licensed under the Apache 2.0 License. Please refer to the [LICENSE](https://github.com/BlocknetDX/dockerimages/blob/master/LICENSE).
