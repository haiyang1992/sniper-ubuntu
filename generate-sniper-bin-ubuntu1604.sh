#!/bin/bash
SNIPER_VERSION=6.1
DOCKERFILE_NAME=Dockerfile-sniper-${SNIPER_VERSION}
DOCKER_IMAGE_NAME=haiyang:sniper-${SNIPER_VERSION}-build

mkdir -p build/
docker build -f ${DOCKERFILE_NAME} -t ${DOCKER_IMAGE_NAME} .
# we don't need to actually run a container
docker create --name sniper-build-tmp ${DOCKER_IMAGE_NAME}
docker cp sniper-build-tmp:/root/sniper build/sniper-${SNIPER_VERSION}
docker rm sniper-build-tmp
sed -i -e "s/child'/child -ifeellucky'/g" build/sniper-${SNIPER_VERSION}/run-sniper
sed -i -e "s/-enable_vsm 0'/-enable_vsm 0 -ifeellucky'/g" build/sniper-${SNIPER_VERSION}/record-trace

SNIPER_VERSION=7.1
DOCKERFILE_NAME=Dockerfile-sniper-${SNIPER_VERSION}
DOCKER_IMAGE_NAME=haiyang:sniper-${SNIPER_VERSION}-build

docker build -f ${DOCKERFILE_NAME} -t ${DOCKER_IMAGE_NAME} .
# we don't need to actually run a container
docker create --name sniper-build-tmp ${DOCKER_IMAGE_NAME}
docker cp sniper-build-tmp:/root/sniper build/sniper-${SNIPER_VERSION}
docker rm sniper-build-tmp

#chown -R haiyang:haiyang build

echo "Done!"