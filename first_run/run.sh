#!/bin/bash

echo -e "-------------------------------\nHIT CTRL+C WHEN CERTBOT STOPPED\n-------------------------------"
source sourceme.env
docker-compose up
docker-compose down
sudo chown -R $USER:$USER ../letsencrypt/
for fulldir in ../letsencrypt/live/*; do
    directory=${fulldir%/}
    folder=$(basename "$directory")
    if [[ "$folder" != "README" ]]; then
        (sudo cat $directory/privkey.pem && sudo cat $directory/fullchain.pem) > ../certs/$folder.pem
    fi
done