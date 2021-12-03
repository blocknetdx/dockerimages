#!/bin/bash

function release() {
    docker pull blocknetdx/"$1":"$2"
    docker tag blocknetdx/"$1":"$2" blocknetdx/"$1":"$3"
    docker push blocknetdx/"$1":"$3"
}

wallet=$(echo $1 | sed -e 's/\s\+/-/g' | tr '[:upper:]' '[:lower:]' )
version=$2

release_tag=$version
staging_tag=$version-staging

release "${wallet}" "${staging_tag}" "${release_tag}"
