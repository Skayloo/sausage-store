#! /bin/bash
set -xe
docker login -u ${CI_REGISTRY_USER} -p${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
cd /opt/sausage-store/docker_compose/
if [ "$(docker compose ps -q)" ]; then echo "Docker Compose уже запущен"; else docker compose up -d; fi
docker compose pull backend-report
docker compose up --force-recreate --remove-orphans -d backend-report
docker image prune -f
