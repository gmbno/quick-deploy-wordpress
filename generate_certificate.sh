LETSENCRYPT_VOLUME_DIR=$(pwd)/letsencrypt
DOMAIN="lucasgambini.dev -d *.lucasgambini.dev"
EMAIL="lucas.gambini.pro@gmail.com"

sudo docker run -it --rm --name certbot -v "$LETSENCRYPT_VOLUME_DIR:/etc/letsencrypt" \
    certbot/certbot certonly --manual -d $DOMAIN --agree-tos --email=$EMAIL --no-eff-email --preferred-challenges dns

sudo chown $USER:$USER --recursive ./letsencrypt