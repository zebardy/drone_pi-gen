FROM arm64v8/docker:23.0.1-dind
RUN apk add git bash rsync
ENV DOCKER_HOST=unix:///var/run/docker.sock
RUN git clone --depth 1 https://github.com/zebardy/pi-gen.git
RUN pwd
RUN ls -lrt /pi-gen
ADD script.sh /bin/
RUN chmod +x /bin/script.sh
ENTRYPOINT ["/usr/local/bin/dockerd-entrypoint.sh", "/bin/script.sh"]
