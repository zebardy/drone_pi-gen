#!/bin/sh

WORKSPACE=$(pwd)
PIGEN_DIR="${1:-/pi-gen}"
pwd
ls -lrt

if [ ! -e /var/run/docker.sock ]; then
  nohup /usr/local/bin/dockerd --host=unix:///var/run/docker.sock --data-root /var/lib/docker 2>&1 >/dev/null &
  sleep 15
fi

cd $PIGEN_DIR
echo "IMG_NAME='Raspbian'" > config
echo "FIRST_USER_PASS='${PLUGIN_FIRST_USER_PASS}'" >> config
echo "ENABLE_SSH='${PLUGIN_ENABLE_SSH}'" >> config

touch ./stage3/SKIP ./stage4/SKIP ./stage5/SKIP
touch ./stage4/SKIP_IMAGES ./stage5/SKIP_IMAGES
rm stage4/EXPORT*

./build-docker.sh
#cat ./work/Raspbian/stage0/rootfs/debootstrap/debootstrap.log
echo "Docker build done!!!"

ls -lrt
ls -lrt ./deploy
mkdir $WORKSPACE/deploy
cp -R ./deploy/* $WORKSPACE/deploy

cd $WORKSPACE
pwd
echo "Workspace"
ls -lrt
echo "Deploy"
ls -lrt ./deploy
