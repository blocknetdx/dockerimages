#!/bin/bash

function generate() {

  pip3 install -r autobuild/requirements.txt
  cd autobuild && python3 generate_build_files.py --blockchain=$1 --version=$2 && cd ../

}


function build() {

    if docker build --build-arg WALLET=$1 \
                    --build-arg TAG=$2 \
                    --build-arg BRANCH=$3 \
                    -f ./images/"$1"/Dockerfile -t blocknetdx/"$1":"$2" ./images/"$1"; then
      docker image ls blocknetdx/"$1":"$2"
    else
      echo "Docker build Failed"
      exit 1
    fi
}

function run () {
    docker run -d --name="$1"-"$2" blocknetdx/"$1":"$2"

    echo 'Sleep 5 sec to give a time to up container'
    sleep 5

    container_id=$(docker ps -f status=running -f name="$1"-"$2")

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
    if [[ "$1" = "servicenode" ]] ; then
      info=$(docker exec "$1"-"$2" blocknet-cli getwalletinfo)
    else
      info=$(docker exec "$1"-"$2" "$1"-cli getwalletinfo)
    fi
    if [ "${info}" ]; then
      if [[ `echo "${info}" | grep "walletversion"` ]]; then
        echo "${info}"
      else
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
  docker push blocknetdx/"$1":"$2"
}

function clean() {

    echo 'Stop container'
    docker stop "$1"-"$2"

    echo 'Remove container'
    docker rm "$1"-"$2"

}

function release() {
    docker pull blocknetdx/"$1":"$2"
    docker tag blocknetdx/"$1":"$2" blocknetdx/"$1":"$3"
    docker push blocknetdx/"$1":"$3"
}


wallet=$(echo $2 | sed -e 's/\s\+//g' | tr '[:upper:]' '[:lower:]' )
echo $wallet
version=$3
branch=$4

if [ "$1" == "generate" ]; then
  generate "${wallet}" "${version}"
  exit 0
fi

if [ ! -f images/"${wallet}"/Dockerfile ]; then
  echo "No Dockerfile for ${wallet}"
  exit 1
fi

if [ "${version}" == "latest" ] || [ -z "${version}" ]; then
  version=$(grep "LABEL version" images/"${wallet}"/Dockerfile | cut -d '=' -f 2)
fi

release_tag=$version
staging_tag=$version-staging
case $1 in
  build)
    build "${wallet}" "${staging_tag}" "${branch}"
  ;;
  run)
    run "${wallet}" "${staging_tag}"
  ;;
  test)
    test "${wallet}" "${staging_tag}"
  ;;
  push)
    push "${wallet}" "${staging_tag}"
  ;;
  clean)
    clean "${wallet}" "${staging_tag}"
  ;;
  release)
    release "${wallet}" "${staging_tag}" "${release_tag}"
  ;;
  *)
    echo 'Unknown command'
esac
