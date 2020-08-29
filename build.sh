#!/bin/sh

builder_name=aarch64_builder

if [ -z "$seafile_version" -o -z "$seafile_arch" ]; then
	exit 1
fi

export DOCKER_CLI_EXPERIMENTAL=enabled

if [ ! -f seafile-server_${seafile_version}_${seafile_arch}.tar.gz ]; then
	echo "seafile tarball not found!"
	exit 1
fi

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
	--build-arg TRAVIS="$TRAVIS" \
	--build-arg SEAFILE_VERSION="$seafile_version" \
	--build-arg SEAFILE_ARCH="$seafile_arch" \
	--platform linux/arm64 --load \
	--progress plain \
	-t hanwckf/seafile:${seafile_version}-${seafile_arch} \
	.

