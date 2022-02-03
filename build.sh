#!/bin/bash
GIT_HASH=`git rev-parse --short HEAD`
DOCKER_IMAGE_REPO=docker.io/ivanmorenoj/nextcloud-client

time docker build \
        --build-arg VCS_REF=$GIT_HASH \
        --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
        -t $DOCKER_IMAGE_REPO:$GIT_HASH . | tee build.log

[ "$1" = "push" ] && docker push $DOCKER_IMAGE_REPO:$GIT_HASH
