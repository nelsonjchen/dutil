#!/bin/sh

TAG_NAME=${TAG_NAME:-ghcr.io/nelsonjchen/dutil:latest}

docker build -t ${TAG_NAME} . && docker run --rm -it ${TAG_NAME}