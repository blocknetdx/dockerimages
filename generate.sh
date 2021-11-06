#!/bin/bash

function generate() {

  pip3 install -r autobuild/requirements.txt
  cd autobuild && python3 generate_build_files.py --blockchain=$1 --version=$2 --manifest="$3" --wallet_conf="$4" && cd ../

}

wallet=$(echo $1 | sed -e 's/\s\+/-/g' | tr '[:upper:]' '[:lower:]' )
version=$2
manifest=$3
wallet_config=$4

generate "${wallet}" "${version}" "${manifest}" "${wallet_config}"
