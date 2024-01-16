#! /bin/bash
set -xe
sudo docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
sudo docker network create -d bridge sausage_network || true
sudo docker rm -f sausage-frontend || true
sudo docker run --restart=on-failure:10 -p 8080:80 -v /tmp/${CI_PROJECT_DIR}/frontend/default.conf:/etc/nginx/conf.d/default.conf -d --name sausage-frontend --network=sausage_network "${CI_REGISTRY_IMAGE}"/sausage-frontend:"${VERSION}"