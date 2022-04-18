#!/bin/sh

WORKSPACE=$(pwd)
pwd
ls -lrt

echo "IMG_NAME='Raspbian'" > config
echo "FIRST_USER_PASS='${PLUGIN_FIRST_USER_PASS}'" >> config
echo "ENABLE_SSH='${PLUGIN_ENABLE_SSH}'" >> config

touch /pi-gen/stage3/SKIP /pi-gen/stage4/SKIP /pi-gen/stage5/SKIP
touch /pi-gen/stage4/SKIP_IMAGES /pi-gen/stage5/SKIP_IMAGES
/pi-gen/build.sh
ls -lrt 
