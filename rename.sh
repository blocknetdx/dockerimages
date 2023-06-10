#!/bin/bash

function rename() {
    source_image="blocknetdx/$1:$2"
    target_image="blocknetdx/$1:$3"

    docker pull "$source_image"
    docker tag "$source_image" "$target_image"
    docker push "$target_image"
}

imageName=$1
tag=$2
targetTag=$3

# Call the rename function
rename "$imageName" "$tag" "$targetTag"
