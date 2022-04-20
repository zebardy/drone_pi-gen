#!/bin/sh

WORKSPACE=$(pwd)
pwd
ls -lrt

nohup /usr/local/bin/dockerd --host=unix:///var/run/docker.sock --data-root /var/lib/docker &
sleep 15
ls -lrt /var/run
#ls -lrt /proc
#sestatus
#setenforce 0
docker ps

cd /pi-gen
echo "IMG_NAME='Raspbian'" > config
echo "FIRST_USER_PASS='${PLUGIN_FIRST_USER_PASS}'" >> config
echo "ENABLE_SSH='${PLUGIN_ENABLE_SSH}'" >> config

touch ./stage3/SKIP ./stage4/SKIP ./stage5/SKIP
touch ./stage4/SKIP_IMAGES ./stage5/SKIP_IMAGES
ls -lrt ./build-docker.sh
echo "This is a test"
cat ./build-docker.sh
exec ./build-docker.sh
cat ./work/Raspbian/stage0/rootfs/debootstrap/debootstrap.log

ls -lrt
ls -lrt ./deploy

cd $WORKSPACE

ls -lrt 
