FROM cheggwpt/alpine:edge

ENV TIDEWAYS_PORT_UDP 8135
ENV TIDEWAYS_PORT_TCP 9135
ENV TIDEWAYS_ENV "development"
ENV tideways_version 1.5.3
ENV TIDEWAYS_DAEMON_EXTRA "--env=${TIDEWAYS_ENV} --address=0.0.0.0:${TIDEWAYS_PORT_TCP} --udp=0.0.0.0:${TIDEWAYS_PORT_UDP}"

RUN apk add --no-cache --update wget && \
  	cd /tmp && \
    wget https://s3-eu-west-1.amazonaws.com/tideways/daemon/${tideways_version}/tideways-daemon-v${tideways_version}-alpine.tar.gz && \
	tar -zxf tideways-daemon-v${tideways_version}-alpine.tar.gz && \
	mv build/dist/tideways-daemon /usr/bin && \
	ls -l /usr/bin/tideways-daemon && \
	mkdir -p /var/run/tideways && \
    rm -rf build/ tideways-daemon-v${tideways_version}-alpine.tar.gz && \
	apk del wget && \
	rm -rf /var/cache/apk/*

COPY entrypoint.sh /

EXPOSE $TIDEWAYS_PORT_UDP/udp
EXPOSE $TIDEWAYS_PORT_TCP

ENTRYPOINT ["/entrypoint.sh", "tideways-daemon"]
