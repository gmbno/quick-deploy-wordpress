#!/bin/bash

ROOT_REPO_PATH="/home/gmbn/quick-deploy-wordpress"

cd $ROOT_REPO_PATH
docker-compose up --force-recreate certbot
for fulldir in ./letsencrypt/live/*; do
    directory=${fulldir%/}
    folder=$(basename "$directory")
    echo $folder
    if [[ "$folder" != "README" ]]; then
        (sudo cat $directory/privkey.pem && sudo cat $directory/fullchain.pem) > ./certs/$folder.pem
    fi
done
docker-compose up --force-recreate -d haproxy
docker-compose stop certbot