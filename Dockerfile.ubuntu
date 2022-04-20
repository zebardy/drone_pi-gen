FROM ubuntu:xenial
RUN apt update
RUN apt upgrade -y
RUN apt-get install libarchive13=3.2.1-2~ubuntu16.04.1 -y
RUN apt-get install coreutils quilt parted qemu-user-static debootstrap zerofree zip \
dosfstools libcap2-bin grep rsync xz-utils file git curl bc \
qemu-utils kpartx pigz libarchive-tools kmod vim-common docker.io -y
RUN git clone --depth 1 https://github.com/RPI-Distro/pi-gen.git
RUN pwd
RUN ls -lrt /pi-gen
ADD script.sh /bin/
RUN chmod +x /bin/script.sh
ENTRYPOINT /bin/script.sh
