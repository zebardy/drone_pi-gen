#!/bin/sh

WORKSPACE=$(pwd)
pwd
ls -lrt

/usr/local/bin/dockerd --host=unix:///var/run/docker.sock --data-root /var/lib/docker
ls -lrt /var/run
#ls -lrt /proc
#sestatus
#setenforce 0
docker ps

echo "IMG_NAME='Raspbian'" > config
echo "FIRST_USER_PASS='${PLUGIN_FIRST_USER_PASS}'" >> config
echo "ENABLE_SSH='${PLUGIN_ENABLE_SSH}'" >> config

touch /pi-gen/stage3/SKIP /pi-gen/stage4/SKIP /pi-gen/stage5/SKIP
touch /pi-gen/stage4/SKIP_IMAGES /pi-gen/stage5/SKIP_IMAGES
ls -lrt /pi-gen/
exec /pi-gen/build-docker.sh
cat /pi-gen/work/Raspbian/stage0/rootfs/debootstrap/debootstrap.log

ls -lrt 
