#!/bin/sh

WORKSPACE=$(pwd)
PIGEN_DIR="${1:-/pi-gen}"
SOURCE_DIR="$WORKSPACE/${PLUGIN_PI_GEN_DIR}/"

if [ ! -e /var/run/docker.sock ]; then
  nohup /usr/local/bin/dockerd --host=unix:///var/run/docker.sock --data-root /var/lib/docker 2>&1 >/dev/null &
  sleep 15
fi

rsync -a "$SOURCE_DIR/" "$PIGEN_DIR"

cd $PIGEN_DIR
echo "IMG_NAME='Raspbian'" >> config
if [ -n "$PLUGIN_FIRST_USER_PASS" ]; then echo "FIRST_USER_PASS='${PLUGIN_FIRST_USER_PASS}'" >> config; fi
if [ -n "$PLUGIN_DISABLE_FIRST_BOOT_USER_RENAME" ]; then echo "DISABLE_FIRST_BOOT_USER_RENAME='${PLUGIN_DISABLE_FIRST_BOOT_USER_RENAME}'" >> config; fi
if [ -n "$PLUGIN_FIRST_USER_NAME" ]; then echo "FIRST_USER_NAME='${PLUGIN_FIRST_USER_NAME}'" >> config; fi
if [ -n "$PLUGIN_PUBKEY_SSH_FIRST_USER" ]; then echo "PUBKEY_SSH_FIRST_USER='${PLUGIN_PUBKEY_SSH_FIRST_USER}'" >> config; fi
if [ -n "$PLUGIN_PUBKEY_ONLY_SSH" ]; then echo "PUBKEY_ONLY_SSH='${PLUGIN_PUBKEY_ONLY_SSH}'" >> config; fi
if [ -n "$PLUGIN_ENABLE_SSH" ]; then echo "ENABLE_SSH='${PLUGIN_ENABLE_SSH}'" >> config; fi
if [ -n "$PLUGIN_TARGET_HOSTNAME" ]; then echo "TARGET_HOSTNAME='${PLUGIN_TARGET_HOSTNAME}'" >> config; fi

echo "PLUGIN_DEBUG = $PLUGIN_DEBUG"
if [ -n "$PLUGIN_DEBUG" ]; then
  echo "===CONFIG==="
  cat config
  echo "===CONFIG END==="
fi

#touch ./stage3/SKIP ./stage4/SKIP ./stage5/SKIP
#touch ./stage4/SKIP_IMAGES ./stage5/SKIP_IMAGES

if [ -f "./stage4/SKIP_IMAGES" ]; then
  echo "WARNING: stage 4 SKIP_IMAGES set so skipping stage 4 EXPORT"
  rm stage4/EXPORT*
fi

echo "Docker based build start!!!"
./build-docker.sh
#cat ./work/Raspbian/stage0/rootfs/debootstrap/debootstrap.log
echo "Docker build done!!!"

mkdir $WORKSPACE/deploy
cp -R ./deploy/* $WORKSPACE/deploy

cd $WORKSPACE
