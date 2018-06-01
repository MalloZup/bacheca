#! /bin/bash

# docker login before

if [[ -z "$1" ]]; then
    TAG="latest"
else
    TAG="$1"
fi

docker build -t bacheca .
echo "tag image"
echo
docker tag bacheca dmaiocchi/bacheca:$TAG
echo "pushing image"
echo
docker push dmaiocchi/bacheca:$TAG
