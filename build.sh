#!/bin/sh

if [[ -z "$CLOJUPYTER_VERSION" ]]; then
  echo 'Specify $CLOJUPYTER_VERSION as environment variable (e.g. "bash> CLOJUPYTER_VERSION=0.2.2 docker build ...")'
  exit 1
fi

docker buildx build --build-arg CLOJUPYTER_VERSION=$CLOJUPYTER_VERSION -t lituzou/clojupyter:$CLOJUPYTER_VERSION .
