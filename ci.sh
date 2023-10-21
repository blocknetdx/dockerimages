#!/bin/bash

function generate() {

  pip3 install -r autobuild/requirements.txt
  cd autobuild && python3 generate_build_files.py --blockchain=$1 --version=$2 --path=$3 && cd ../

}

function build() {

    if docker build --build-arg WALLET=$1 \
                    --build-arg TAG=$2 \
                    --build-arg BRANCH=$3 \
                    -f ./images/"$1"/Dockerfile -t "$repo"/"$1":"$2" ./images/"$1"; then
      docker image ls "$repo"/"$1":"$2"
    else
      echo "Docker build Failed"
      exit 1
    fi
}

function run () {
    docker run -d --name="$1"-"$2" "$repo"/"$1":"$2"

    echo 'Sleep 5 sec to allow the container to start'
    sleep 5
    docker ps -a
    docker logs $(docker ps -q -l)

    container_id=$(docker ps -q -f status=running -f name="$1"-"$2")

    if [ "${container_id}" ]; then
      echo "${container_id}"
    else
      echo 'No running container' "$1"-"$2"
      docker stop "$1"-"$2"
      docker rm "$1"-"$2"
      exit 1
    fi
}

function test() {
    # dont use getwalletinfo for the test; newer bitcoin and alts don't automatically
    # create a wallet on first startup and getwalletinfo will fail with eg:
    # error code: -18
    # error message:
    # No wallet is loaded. Load a wallet using loadwallet or create a new one with createwallet. (Note: A default wallet is no longer automatically created)

    if [[ "$1" = "servicenode" ]] ; then
      info=$(docker exec "$1"-"$2" blocknet-cli getblockchaininfo)
    else
      # Need to get the executable stem from manifest because it might not be the same as the chain name 
      cd autobuild && stem=$(python3 generate_build_files.py --blockchain=$1 --version=$2 --path=$3 --stem_only=true) && cd ../
      info=$(docker exec "$1"-"$2" "$stem"-cli getblockchaininfo)
    fi
    if [ "${info}" ]; then
      if [[ `echo "${info}" | grep "chain"` ]]; then
        echo "Good result."
        echo "${info}"
      else
        echo "Bad result."
        echo "${info}"
        docker stop "$1"-"$2"
        docker rm "$1"-"$2"
        exit 1
      fi
    else
      echo 'Daemon or container is broken'
      docker stop "$1"-"$2"
      docker rm "$1"-"$2"
      exit 1
    fi
}

function push() {
  docker push "$repo"/"$1":"$2"
}

function clean() {

    echo 'Stop container'
    docker stop "$1"-"$2"

    echo 'Remove container'
    docker rm "$1"-"$2"

}

function release() {
    docker pull "$repo"/"$1":"$2"
    docker tag "$repo"/"$1":"$2" "$repo"/"$1":"$3"
    docker push "$repo"/"$1":"$3"
}

wallet=$(echo $2 | sed -e 's/\s\+/-/g' | tr '[:upper:]' '[:lower:]' )
version=$3
branch_or_path=$4
repo=$5

if [[ -z "$5" ]]; then
   repo="blocknetdx"
fi

if [ "$1" == "generate" ]; then
  generate "${wallet}" "${version}" "${branch_or_path}"
  exit 0
fi

#if [ ! -f images/"${wallet}"/Dockerfile ]; then
#  echo "No Dockerfile for ${wallet}"
#  exit 1
#fi

#if [ "${version}" == "latest" ] || [ -z "${version}" ]; then
#  version=$(grep "LABEL version" images/"${wallet}"/Dockerfile | cut -d '=' -f 2)
#fi

staging_tag=$version"-staging"

case $1 in
  build)
    build "${wallet}" "${staging_tag}" "${branch_or_path}"
  ;;
  run)
    run "${wallet}" "${staging_tag}"
  ;;
  test)
    test "${wallet}" "${staging_tag}" "${branch_or_path}"
  ;;
  push)
    push "${wallet}" "${staging_tag}"
  ;;
  clean)
    clean "${wallet}" "${staging_tag}"
  ;;
  release)
    release "${wallet}" "${staging_tag}" "${version}"
  ;;
  release-as-latest)
    release "${wallet}" "${staging_tag}" "latest"
  ;;
  *)
    echo 'Unknown command'
esac
