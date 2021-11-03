import json
import os
import time
import sys
import re
import subprocess
import argparse
import urllib.request
from jinja2 import Environment
from jinja2 import FileSystemLoader
from icecream import ic

j2_env = Environment(loader=FileSystemLoader(''),
                     trim_blocks=True)

template = j2_env.get_template('Dockerfile.j2')
readmetemplate = j2_env.get_template('README.md.j2')

walletDict = {}

buildOS = 'bionic'


def load_template(template_url):
    """
    load_template - downloads from url provided and returns the data
    """
    while True:
        response = urllib.request.urlopen(template_url)
        if response.getcode() == 200:
            data = response.read()
            result = data.decode('utf-8')
            return result
        time.sleep(10)


branch = subprocess.getoutput("git rev-parse --abbrev-ref HEAD")

parser = argparse.ArgumentParser()
parser.add_argument('--blockchain', help='blockchain name', default=branch)
parser.add_argument('--path', help='branch path', default='https://raw.githubusercontent.com/blocknetdx/blockchain-configuration-files/master')
parser.add_argument('--version', help='version of wallet', default="latest")
args = parser.parse_args()
blockchain_name = args.blockchain
wallet_version = args.version
config_path = args.path
MANIFEST_URL = config_path+'/manifest-latest.json'
WALLET_CONF_URL = config_path+'/wallet-confs/'
ic(MANIFEST_URL)
ic(WALLET_CONF_URL)
manifest_config = json.loads(load_template(MANIFEST_URL))
ic(manifest_config)


for blockchain in manifest_config:
    if re.sub('\s+', '-', blockchain['blockchain'].lower()) == blockchain_name.lower():
        walletConf = blockchain['wallet_conf']
        walletDaemon = blockchain['conf_name'].split('.conf')
        walletbuildname = walletDaemon[0]
        walletDaemon = walletDaemon[0] + 'd'
        walletName = re.sub('\s+', '-', blockchain['blockchain'].lower())
        walletNameVerId = blockchain['ver_id']
        walletGitTag = blockchain['ver_id'].split('--')
        walletGitURL = blockchain['repo_url']
        walletConfName = blockchain['conf_name']
        walletLinuxDir = blockchain['conf_name'].split('.conf')
        walletLinuxDir = walletLinuxDir[0]
        walletTicker = blockchain['ticker']
        walletVerList = blockchain['versions']
        testnetPort = '18332'
        testnetRPC = '19332'
        if wallet_version == "latest" or wallet_version == "":
            walletVersion = walletVerList[-1]
        else:
            if wallet_version in walletVerList:
                walletVersion = wallet_version
            else:
                sys.exit(f'Wallet version not found {wallet_version}')
        walletGitTag = walletVersion
        walletNameVerId = walletVersion



# open up wallet_conf and get the rpc & port
try:
    walletData = load_template(WALLET_CONF_URL + walletConf).split('\n')
except Exception as e:
    print(e)
    sys.exit(f'Wallet not found {blockchain_name}')

for z in walletData:
    if 'rpcport' in z:
        values = (z.split('='))
        walletRPCPort = values[1].strip('\n')
    elif 'port' in z:
        values = (z.split('='))
        walletPort = values[1].strip('\n')

rendered_file = template.render(walletName=walletName, walletDaemon=walletDaemon, walletGitTag=walletGitTag,
                                walletGitURL=walletGitURL, walletPort=walletPort, walletRPCPort=walletRPCPort,
                                testnetPort=testnetPort, testnetRPC=testnetRPC, walletConfName=walletConfName,
                                walletLinuxDir=walletLinuxDir, walletNameVerId=walletNameVerId, buildOS=buildOS,
                                walletDockerName=walletTicker.lower())


readme_rendered_file = readmetemplate.render(walletName=walletName, walletDaemon=walletDaemon,
                                             walletGitTag=walletGitTag,
                                             walletGitURL=walletGitURL, walletPort=walletPort,
                                             walletRPCPort=walletRPCPort,
                                             testnetPort=testnetPort, testnetRPC=testnetRPC,
                                             walletConfName=walletConfName,
                                             walletLinuxDir=walletLinuxDir, walletNameVerId=walletNameVerId,
                                             buildOS=buildOS, walletDockerName=walletTicker.lower())

dockerpath = walletName
filename = '../images/' + dockerpath + '/Dockerfile'
print(filename)
os.makedirs(os.path.dirname(filename), exist_ok=True)
with open(filename, "w") as f:
    f.write(rendered_file)
    ic(rendered_file)

readmefilename = '../images/' + dockerpath + '/README.md'
print(readmefilename)
os.makedirs(os.path.dirname(filename), exist_ok=True)
with open(readmefilename, "w") as f:
    f.write(readme_rendered_file)

