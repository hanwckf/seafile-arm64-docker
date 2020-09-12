#!/bin/sh

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push hanwckf/seafile:$DOCKER_IMAGE_TAG

