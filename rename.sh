#!/bin/bash

function rename() {
    docker pull blocknetdx/"$1"
    docker tag blocknetdx/"$1" blocknetdx/"$2"
    docker push blocknetdx/"$2"
}

imageName=$1
targetName=$2

# Call the rename function
rename "${imageName}" "${targetName}"
