#!/bin/bash

if [[ ! -d node_modules ]]; then
  yes no | npm i
fi

npm run parcel

export DOCKER_BUILDKIT=1 
export DOCKER_CLI_EXPERIMENTAL=enabled
docker buildx create --use
docker buildx build --load -t ghcr.io/browserbox/browserbox:v5 . > artefacts/build.log 2>&1 &
tail -f artefacts/build.log
