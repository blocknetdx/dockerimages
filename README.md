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

When manually overridding the blocknetd command line arguments you must set `-daemon=0` (blocking), otherwise the container will exit immediately. Using `-daemon=0` will allow OS signals pass directly to blocknetd resulting in proper shutdowns (which will prevent corrupting the blockchain).

This command runs the container as a servicenode (do not use these exact values in production):
```
docker run -d --name=snode -p 41412:41412 blocknetdx/servicenode:latest blocknetd -daemon=0 -rpcuser=sn1 -rpcpassword=servicenode123 -servicenode=1
```

### Automatically restart the container

See https://docs.docker.com/engine/admin/start-containers-automatically/

`--restart=no|on-failure:retrycount|always|unless-stopped`

```
docker run -d --restart=no             --name=snode -p 41412:41412 blocknetdx/servicenode:latest blocknetd -daemon=0 -rpcuser=sn1 -rpcpassword=servicenode123
docker run -d --restart=on-failure:10  --name=snode -p 41412:41412 blocknetdx/servicenode:latest blocknetd -daemon=0 -rpcuser=sn1 -rpcpassword=servicenode123
docker run -d --restart=unless-stopped --name=snode -p 41412:41412 blocknetdx/servicenode:latest blocknetd -daemon=0 -rpcuser=sn1 -rpcpassword=servicenode123
docker run -d --restart=always         --name=snode -p 41412:41412 blocknetdx/servicenode:latest blocknetd -daemon=0 -rpcuser=sn1 -rpcpassword=servicenode123
```

### Container shell access

```
docker exec -it snode /bin/bash
```

### Default blocknet.conf

The default configuration is below. A custom configuration file can be passed to the servicenode container through the `/opt/blockchain/config` volume. Some of these parameters can also be adjusted on the command line.
```
datadir=/opt/blockchain/data  

maxmempoolxbridge=128

port=41412    # testnet: 41474
rpcport=41414 # testnet: 41419

listen=1                      
server=1                      
logtimestamps=1               
logips=1                      

rpcallowip=127.0.0.1          
rpcbind=0.0.0.0
rpctimeout=30                 
rpcclienttimeout=30           
```
### Autobuild docker images 

Autobuild pipeline is based on github actions. There are several key components in the stack:

- github repository
- k8s cluster
- self-hosted github runners
- actions runner controller
- blocknetdximg dockerhub account
- blocknetbot github admin account

The pipelines are triggered by workflow yaml files in _.github/workflows/some_pipeline.yaml_

It starts build process on self-hosted runner in k8s cluster. If build process is successful, the image is pushed to
dockerhub repository blocknetdx/\<wallet>:\<tag>

How to deploy the stack?

1) Create k8s cluster
2) Create two accounts: dockerhub registry account, github account. (Or use existing)
3) Install actions runner controller on k8s to manage self-hosted runners (Here is the link https://github.com/actions-runner-controller/actions-runner-controller)
    - Install the custom resource definitions and actions-runner-controller with kubectl or helm. This will create actions-runner-system namespace in your Kubernetes and deploy the required resources.
   Helm deployment:
    ```bash
    helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller
    helm upgrade --install --namespace actions-runner-system --create-namespace \ 
          --wait actions-runner-controller actions-runner-controller/actions-runner-controller 
   ```
    - Select "Deploying Using PAT Authentication" method. Personal Access Tokens can be used to register a self-hosted runner by actions-runner-controller.
    - Log-in to a GitHub account that has admin privileges for the repository, and create a personal access token
    - Once you have created the appropriate token, deploy it as a secret to your Kubernetes cluster.
      ```bash
      kubectl create secret generic controller-manager \
        -n actions-runner-system \
        --from-literal=github_token=${GITHUB_TOKEN}
      ```
    - Lunch self-hosted runners on Repository runner level by creating RunnerDeployment
    ```yaml
    # runnerdeployment.yaml
    apiVersion: actions.summerwind.dev/v1alpha1
    kind: RunnerDeployment
    metadata:
      name: example-runnerdeploy
    spec:
      replicas: 2
      template:
        spec:
          repository: mumoshu/actions-runner-controller-ci
          env: []

    ```
    ```bash 
    kubectl apply -f runnerdeployment.yaml
    runnerdeployment.actions.summerwind.dev/example-runnerdeploy created 
   ```
   - Create github secrets for DockerHub registry credentials (Blocknetdximg login/password)
    
    
**BUILD IMAGE FROM TEMPLATE**  - this workflow is used to create an image based on Dockerfile template. It checks manifest-latest.json, generates Dockerfile, build and push an image.  It takes three inputs (arguments):  The path of the branch where the manifest and config files are to be found (defaults to master); the name of a wallet; the version of wallet (defaults to latest) which is used as a tag for image.

Scenario:
1) Add info to manifest-latest.json if does not exist.
2) Run a workflow by filling inputs. Put a wallet name and a version (if necessary) in a web form. 
3) The image will be uploaded to DockerHub blocknetdx/\<wallet>:\<tag>-staging

**BUILD SERVICENODE** - this workflow is used to create a servicenode image. (The previous workflow also can be used to create servicenode images. But it creates only those images which are presented in manifest-latest.json.)  This workflow creates an image with any version of branch. It takes three inputs (arguments): The name of wallet, by default it is "servicenode"; The version (it is used as a tag for image). The branch, name of branch. 

Scenario:
1) If a branch in blocknet repository is ready for building and testing, run a workflow by filling inputs. 
2) The image will be uploaded to DockerHub blocknetdx/\<wallet>:\<tag>-staging


**BUILD CUSTOM IMAGE** - It is used if we need to create a custom dockerimage which is not presented in manifest-latest.json, but requires testing. 

Scenario:
1) Create a branch from master
2) Create a Dockerfile and necessary files in directory images/\<wallet>/
3) Run a workflow by filling inputs and chose the branch which you had created! Put a wallet name and a version in a web form. 
4) The image will be uploaded to DockerHub blocknetdx/\<wallet>:\<tag>-staging


**BUILD IMAGE FROM CONFIG** - build an image for a new coin which is not presented in manifest.json 

The workflow takes 4 arguments

- Image (Name of coin, chain. Ex: dash, btc, etc)
- Version (Version or tag)
- Manifest (coin data in json format. Ex: autbouild/manifest_config)
- wallet config (wallet config for coin/chain)

Scenario:
1) prepare manifest config and wallet config for workflow
2) Run a workflow by filling inputs. Put a wallet name and, version in a web form. Copy content of manifest config, wallet config and insert it  in a web form.   
3) The image will be uploaded to DockerHub blocknetdx/\<wallet>:\<tag>-staging

**RELEASE IMAGE** - when the image is tested and has no any issues it can be released by workflow. It changes a tag of an image from blocknetdx/<wallet>:<tag>-staging to blocknetdx/<wallet>:<tag>

Scenario:
1) Run a workflow by filling inputs. Put a wallet name and a version in a web form. 
2) The image will be re-uploaded to DockerHub blocknetdx/\<wallet>:\<tag>


It does not need to create a separate branch to run workflow "BUILD IMAGE FROM TEMPLATE" and "BUILD SERVICENODE". Workflows are run from master branch. But if you want to change something in Dockerfiles or scripts, you can create new branch and run workflow for your branch.


Once an image is built and it needs to test it.  To run container in Exproxy-env autobuild stack it needs to reproduce the following steps in blockchain-configuration-files repo:

   - Add info to manifest.json and manifest-latest.json
   - create wallet-confs and xbridge confs files
   - create \<coin>.base.j2 template in autobuild/configs/ directory. It can be done manually or by python script 
   ```bash
   python3 autobuild/create-j2-confs.py
   ```

The app.py uses manifest-latest.json and base.j2 templates

In the case a coin is not ready to be added to manifest-latest.json. The exrproxy-env can run an image if to define manifest
and base.j2 template in custom.yaml file 

License
=======

This code is licensed under the Apache 2.0 License. Please refer to the [LICENSE](https://github.com/BlocknetDX/dockerimages/blob/master/LICENSE).
