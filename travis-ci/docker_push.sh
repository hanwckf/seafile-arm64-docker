#!/bin/sh

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push hanwckf/seafile:${seafile_version}-${seafile_arch}

