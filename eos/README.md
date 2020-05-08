Official Blocknet Docker Images
=================================

These eos docker images can be found on the docker hub: https://hub.docker.com/r/blocknetdx/eos/

eos
========

These eos images are optimized for use with the Blocknet.

**Note**

These images are _not a replacement or endorsement_ of the eos project (https://github.com/EOSIO/eos).


### _**Setup**_


_If you don’t have Docker installed, there are various guides you can follow including this one_ [_here_](https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04)_._

### **Staging**


It is recommended that you leverage the `docker -v` functionality for your EOS container unless you wish to store all blockchain data in the default Docker volume location found at `/var/lib/docker/volumes` on the host machine.  If you don't plan on using `docker -v`, skip to the **Setup** section, **Step 2.a**

**Step 1**

Choose a location you plan on using for your `nodeos` volume. For this example we’ll use `/opt/eos`

**Step 2**

Create the directories needed for your config files and enter said directory:

* `mkdir -p /opt/eos/nodeos/config`
* `cd /opt/eos/nodeos/config`

**Step 3**

Create your `config.ini`, `logging.json` _(`logging.json` is optional)_, and `genesis.json` files and save them in the current `/opt/eos/nodeos/config` directory.

**`config.ini`:**
```
plugin = eosio::net_plugin
plugin = eosio::net_api_plugin
plugin = eosio::chain_plugin
plugin = eosio::chain_api_plugin
plugin = eosio::http_plugin
plugin = eosio::db_size_api_plugin
plugin = eosio::state_history_plugin

chain-state-db-size-mb = 65536
state-history-endpoint = 0.0.0.0:8080
http-server-address = 0.0.0.0:8888
http-validate-host = false
trace-history = true
chain-state-history = true
wasm-runtime = eos-vm-jit
eos-vm-oc-enable = true

p2p-peer-address = peer.main.alohaeos.com:9876
p2p-peer-address = p2p.eossweden.org:9876
p2p-peer-address = seed1.genereos.io:9876
p2p-peer-address = p2p.sheos.org:5556
p2p-peer-address = eos.unlimitedeos.com:15555
p2p-peer-address = eos.okpool.top:9876
p2p-peer-address = peer1.eosphere.io:9876
p2p-peer-address = node1.eosnewyork.io:6987
p2p-peer-address = p2p.validatoreos.xyz:9800
p2p-peer-address = node1.zbeos.com:9876
p2p-peer-address = p2p.eoscafeblock.com:9000
p2p-peer-address = peer.eos-mainnet.eosblocksmith.io:5010
p2p-peer-address = api.eosvenezuela.io:9876
p2p-peer-address = p2p-emlg.eosnairobi.io:9076
p2p-peer-address = bp.eosbeijing.one:8080
p2p-peer-address = api3.tokenika.io:9876
p2p-peer-address = boot.eostitan.com:9876
p2p-peer-address = peer2.eoshuobipool.com:18181
p2p-peer-address = p2p.eosdetroit.io:3018
p2p-peer-address = seed.eoscleaner.com:9876
p2p-peer-address = epeer3.nodeone.io:8980
p2p-peer-address = p2p.stargalaxy.xyz:9876
p2p-peer-address = peering1.mainnet.eosasia.one:80
p2p-peer-address = p2p-eos.whaleex.com:9876
p2p-peer-address = peer1.eoshuobipool.com:18181
p2p-peer-address = bp.cryptolions.io:9876
p2p-peer-address = p2p.eosargentina.io:5222
p2p-peer-address = p2p.eos42.io:9882
p2p-peer-address = peering.mainnet.eoscanada.com:9876
p2p-peer-address = p2p.meet.one:9876
p2p-peer-address = p2p.athenbp.club:9800
p2p-peer-address = br.eosrio.io:9876
p2p-peer-address = eos-mainnet-peer.ecoboost.app:80
p2p-peer-address = p2p.eoseoul.io:9876
p2p-peer-address = p2p.newdex.one:9876
p2p-peer-address = node1.eoscannon.io:59876
p2p-peer-address = eosbp-0.atticlab.net:9876
p2p-peer-address = seed.greymass.com:9876
p2p-peer-address = peer.eosio.sg:80
p2p-peer-address = node2.zbeos.com:9876
p2p-peer-address = publicnode.cypherglass.com:9876
p2p-peer-address = eos-bp.inbex.pro:9876
p2p-peer-address = p2p.eosio.cr:9876
p2p-peer-address = p2p.eosflare.io:9876
p2p-peer-address = epeer1.nodeone.io:8970
p2p-peer-address = pubnode.eosrapid.com:9876
p2p-peer-address = fullnode.eoslaomao.com:443
p2p-peer-address = mainnet.eoslaomao.com:443
p2p-peer-address = mainnet.eosamsterdam.net:9876
p2p-peer-address = peer1.mainnet.helloeos.com.cn:80
p2p-peer-address = node869-mainnet.eosauthority.com:9393
p2p-peer-address = mainnet.get-scatter.com:9876
p2p-peer-address = bp.antpool.com:443
p2p-peer-address = 47.75.70.208:9376
p2p-peer-address = fn001.eossv.org:445
p2p-peer-address = mainnet.eosarabia.net:3571

actor-blacklist=newdexmobapp
actor-blacklist=ftsqfgjoscma
actor-blacklist=hpbcc4k42nxy
actor-blacklist=3qyty1khhkhv
actor-blacklist=xzr2fbvxwtgt
actor-blacklist=myqdqdj4qbge
actor-blacklist=shprzailrazt
actor-blacklist=qkwrmqowelyu
actor-blacklist=lhjuy3gdkpq4
actor-blacklist=lmfsopxpr324
actor-blacklist=lcxunh51a1gt
actor-blacklist=geydddsfkk5e
actor-blacklist=pnsdiia1pcuy
actor-blacklist=kwmvzswquqpb
actor-blacklist=guagddoefdqu
actor-blacklist=gizdkmjvhege
actor-blacklist=refundwallet
actor-blacklist=jhonnywalker
actor-blacklist=alibabaioeos
actor-blacklist=whitegroupes
actor-blacklist=24cryptoshop
actor-blacklist=minedtradeos
actor-blacklist=guzdanrugene
actor-blacklist=earthsop1sys
actor-blacklist=gyzdmmjsgige
actor-blacklist=gizdcnjyg4ge
actor-blacklist=g4ytenbxgqge
actor-blacklist=jinwen121212
actor-blacklist=ha4tomztgage
actor-blacklist=my1steosobag
actor-blacklist=iloveyouplay
actor-blacklist=eoschinaeos2
actor-blacklist=eosholderkev
actor-blacklist=dreams12true
actor-blacklist=imarichman55
actor-blacklist=gm3dcnqgenes
actor-blacklist=gm34qnqrepqt
actor-blacklist=gt3ftnqrrpqp
actor-blacklist=gtwvtqptrpqp
actor-blacklist=gm31qndrspqr
actor-blacklist=lxl2atucpyos
actor-blacklist=huobldeposit
actor-blacklist=guytqmbuhege
actor-blacklist=wangfuhuahua
actor-blacklist=eosfomoplay1
actor-blacklist=craigspys211
actor-blacklist=craigspys211
actor-blacklist=neverlandwal
actor-blacklist=tseol5n52kmo
actor-blacklist=potus1111111
actor-blacklist=gu2teobyg4ge
actor-blacklist=gq4demryhage
actor-blacklist=q4dfv32fxfkx
actor-blacklist=ktl2qk5h4bor
actor-blacklist=haydqnbtgene
actor-blacklist=g44dsojygyge
actor-blacklist=guzdonzugmge
actor-blacklist=ha4doojzgyge
actor-blacklist=gu4damztgyge
actor-blacklist=haytanjtgige
actor-blacklist=exchangegdax
actor-blacklist=cmod44jlp14k
actor-blacklist=2fxfvlvkil4e
actor-blacklist=yxbdknr3hcxt
actor-blacklist=yqjltendhyjp
actor-blacklist=pm241porzybu
actor-blacklist=xkc2gnxfiswe
actor-blacklist=ic433gs42nky
actor-blacklist=fueaji11lhzg
actor-blacklist=w1ewnn4xufob
actor-blacklist=ugunxsrux2a3
actor-blacklist=gz3q24tq3r21
actor-blacklist=u5rlltjtjoeo
actor-blacklist=k5thoceysinj
actor-blacklist=ebhck31fnxbi
actor-blacklist=pvxbvdkces1x
actor-blacklist=oucjrjjvkrom
actor-blacklist=blacklistmee
actor-blacklist=ge2dmmrqgene
actor-blacklist=gu2timbsguge
actor-blacklist=ge4tsmzvgege
actor-blacklist=gezdonzygage
actor-blacklist=ha4tkobrgqge
actor-blacklist=gq4dkmzzhege
```

**`logging.json`:**
```
{
  "includes": [],
  "appenders": [
    {
      "name": "consoleout",
      "type": "console",
      "args": {
        "stream": "std_out",
        "level_colors": [
          {
            "level": "debug",
            "color": "green"
          },
          {
            "level": "warn",
            "color": "brown"
          },
          {
            "level": "error",
            "color": "red"
          }
        ]
      },
      "enabled": true
    },
    {
      "name": "errout",
      "type": "console",
      "args": {
        "stream": "std_error"
      },
      "enabled": true
    }
  ],
  "loggers": [
    {
      "name": "default",
      "level": "info",
      "enabled": true,
      "additivity": false,
      "appenders": [
        "consoleout"
      ]
    },
    {
      "name": "default",
      "level": "debug",
      "enabled": true,
      "additivity": false,
      "appenders": [
        "errout"
      ]
    }
  ]
}
```

**`genesis.json`:**
```
{
  "initial_timestamp": "2018-06-08T08:08:08.888",
  "initial_key": "EOS7EarnUhcyYqmdnPon8rm7mBCTnBoot6o7fE2WzjvEX2TdggbL3",
  "initial_configuration": {
    "max_block_net_usage": 1048576,
    "target_block_net_usage_pct": 1000,
    "max_transaction_net_usage": 524288,
    "base_per_transaction_net_usage": 12,
    "net_usage_leeway": 500,
    "context_free_discount_net_usage_num": 20,
    "context_free_discount_net_usage_den": 100,
    "max_block_cpu_usage": 200000,
    "target_block_cpu_usage_pct": 1000,
    "max_transaction_cpu_usage": 150000,
    "min_transaction_cpu_usage": 100,
    "max_transaction_lifetime": 3600,
    "deferred_trx_expiration_window": 600,
    "max_transaction_delay": 3888000,
    "max_inline_action_size": 4096,
    "max_inline_action_depth": 4,
    "max_authority_depth": 6
  }
}
```
_Done!_

### **Setup**

Now that you’re staged, we’ll run the Docker container.

**Step 1**

Pull the official Blocknet EOS image:

* `docker pull blocknetdx/eos:v2.0.5`

**Step 2**

Run your container:

* `docker run -d -p 9876:9876 -p 8888:8888 -p 8080:8080 -v /opt/eos/:/root/.local/share/eosio/ --name eos blocknetdx/eos:v2.0.5`

_or_

**Step 2.a** *only required for non `docker -v` setups:*

* `docker run -d -p 9876:9876 -p 8888:8888 -p 8080:8080 --name eos blocknetdx/eos:v2.0.5`

*In the above case, data from the container's `/root/.local/share/eosio` directory will persist to the host machine's default `/var/lib/docker/volumes` directory.*

_Done!_

*if you run into permission denied issues related to leveraging `docker -v`, please research `chown` such as `chown -R 1000:1000 /opt/eos`*

### **Controlling Your `nodeos` Container**

The `docker run` command from the **Setup** section is used to first run and start your container.  After this, you'll be leveraging the `docker attach`, `docker stop`, and `docker start` commands.

To **gracefully** shutdown `nodeos` running in your container, follow these steps:

**Step 1**

Enter your container

* `docker attach eos`

**Step 2**

Gracefully shutdown `nodeos`

* `ctrl+c` or
* `pkill --signal SIGINT nodeos`

_Done!_

After `nodeos` shuts down, you should automatically exit the container.  If for some reason you do not, make sure `nodeos` is indeed shutdown by checking `top`.  When you confirm `nodeos` is shut down, you can then proceed to type and enter `exit` to exit the container and subsequently stop it with `docker stop eos`.

_**Warning:** Stopping a container with `nodeos` actively running in it will lead to a corrupted block database requiring a replay!_

**Starting, Entering, and Stopping the Container**


* To start the container: `docker start eos`
* To enter the container: `docker attach eos`
* To exit the container and keep it running: `ctrl+p+q`

---



License
=======

This code is licensed under the Apache 2.0 License. Please refer to the [LICENSE](https://github.com/blocknetdx/dockerimages/blob/master/LICENSE).
