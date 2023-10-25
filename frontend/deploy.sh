#! /bin/bash
set -xe
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
sudo rm -r /opt/sausage-store/static/sausage-store/frontend || true
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.tar.gz ${NEXUS_REPO_URL_FRONTEND}sausage-store-Paidyutov-Daniil-frontend/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo tar -zxf sausage-store.tar.gz --directory /opt/sausage-store/static/sausage-store/ || true
#Это я на всякий случай (понятия не имею какие права выдает разархивирование)
sudo chmod 755 /opt/sausage-store/static/sausage-store/frontend || true
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-frontend --now