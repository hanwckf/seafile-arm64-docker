# See https://hub.docker.com/r/phusion/baseimage/tags/
FROM phusion/baseimage:bionic-1.0.0-arm64

ARG SEAFILE_VERSION
ARG SEAFILE_ARCH
ARG TRAVIS

ENV SEAFILE_SERVER=seafile-server
ENV SEAFILE_VERSION=${SEAFILE_VERSION}
ENV SEAFILE_ARCH=${SEAFILE_ARCH}

ADD seafile-server_${SEAFILE_VERSION}_${SEAFILE_ARCH}.tar.gz /opt/seafile/

COPY scripts_7.1 /scripts
COPY templates /templates
COPY services /services
COPY docker-buildx/init.sh /opt

RUN sh /opt/init.sh

WORKDIR /opt/seafile

EXPOSE 80

CMD ["/sbin/my_init", "--", "/scripts/start.py"]

