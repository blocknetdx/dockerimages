#!/bin/bash

function build() {

    docker build -f "$1"/Dockerfile -t blocknetdx/"$1":"$2" ./"$1"
    docker image ls blocknetdx/"$1":"$2"

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
    info=$(docker exec "$1"-"$2" "$1"-cli getwalletinfo)
    if [ "${info}" ]; then
      if [ `echo ${info} | grep "walletversion"` ]; then
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



IFS='-'
read -a strarr <<< $2
wallet=${strarr[0]}
tag=${strarr[1]}

if [ ! -f "${wallet}"/Dockerfile ]; then
  echo "No Dockerfile for ${wallet}"
  exit 1
fi

case $1 in
  build)
    build "${wallet}" "${tag}"
  ;;
  run)
    run "${wallet}" "${tag}"
  ;;
  test)
    test "${wallet}" "${tag}"
  ;;
  push)
    push "${wallet}" "${tag}"
  ;;
  clean)
    clean "${wallet}" "${tag}"
  ;;
  *)
    echo 'Unknown command'
esac



