#!/bin/sh
# build docker images with docker-buildx

builder_name=aarch64_builder

if [ -z "$seafile_version" ] || [ -z "$seafile_arch" ] || [ -z "$DOCKER_IMAGE_TAG" ]; then
	exit 1
fi

export DOCKER_CLI_EXPERIMENTAL=enabled

docker run --rm --privileged docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad64

if docker buildx inspect $builder_name >/dev/null 2>&1; then
	docker buildx rm $builder_name
fi

if [ -z "$TRAVIS" ]; then
	docker buildx create --name $builder_name --use --config docker-buildx/config.toml
else
	docker buildx create --name $builder_name --use
fi

docker buildx inspect --bootstrap

docker buildx build \
	-f ${DOCKERFILE:-"Dockerfile"} \
	--build-arg TRAVIS="$TRAVIS" \
	--build-arg SEAFILE_VERSION="$seafile_version" \
	--build-arg SEAFILE_ARCH="$seafile_arch" \
	--platform linux/arm64 --load \
	--progress plain \
	-t hanwckf/seafile:${DOCKER_IMAGE_TAG} \
	.

