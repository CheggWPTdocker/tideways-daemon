FROM cheggwpt/alpine:edge

ENV tideways_version 1.5.3

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

EXPOSE 8135/udp
EXPOSE 9135

ENTRYPOINT ["/usr/bin/tideways-daemon"]
