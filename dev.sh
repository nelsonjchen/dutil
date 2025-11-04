#!/bin/sh

TAG_NAME=${TAG_NAME:-ghcr.io/nelsonjchen/dutil:latest}

# Create placeholder mkcert certificate if it doesn't exist (for local builds)
if [ ! -f mkcert-rootCA.pem ]; then
    touch mkcert-rootCA.pem
fi

docker build -t ${TAG_NAME} . && docker run --rm -it ${TAG_NAME}