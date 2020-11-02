#!/bin/sh

if [ -z "$seafile_version" ] || [ -z "$seafile_arch" ] || [ -z "$DOCKER_IMAGE_TAG" ]; then
	exit 1
fi

docker build \
	-f ${DOCKERFILE:-"Dockerfile"} \
	--build-arg TRAVIS="$TRAVIS" \
	--build-arg SEAFILE_VERSION="$seafile_version" \
	--build-arg SEAFILE_ARCH="$seafile_arch" \
	-t hanwckf/seafile:${DOCKER_IMAGE_TAG} \
	.

