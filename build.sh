#!/bin/sh

find . | grep DS_Store | while read x; do rm $x; done

docker build . -t chatwoot-minisite;
#docker build . -f Dockerfile.dev -t chatwoot-minisite-dev;

exit 0;
