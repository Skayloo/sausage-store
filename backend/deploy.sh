#! /bin/bash
set -xe
sudo docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
sudo docker network create -d bridge sausage_network || true
sudo docker rm -f sausage-backend || true
sudo docker run --rm -d --name sausage-backend \
     --network=sausage_network \
     "${CI_REGISTRY_IMAGE}"/sausage-backend:"${VERSION}"
