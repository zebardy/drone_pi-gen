FROM arm32v7/docker:19.03.8-dind
RUN apk add git bash
ENV DOCKER_HOST=unix:///var/run/docker.sock
RUN git clone --depth 1 https://github.com/RPI-Distro/pi-gen.git
RUN pwd
RUN ls -lrt /pi-gen
ADD script.sh /bin/
RUN chmod +x /bin/script.sh
ENTRYPOINT ["/usr/local/bin/dockerd-entrypoint.sh", "/bin/script.sh"]
