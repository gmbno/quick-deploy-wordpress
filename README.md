### Create volumes directories:
`mkdir ./mysql_data && mkdir ./wordpress_data`

### Generate wildcard cert:
Edit domains and email then run `./generate_certificate.sh`\
Follow the step then configure dns provider. Be careful, only set `_acme-challenge` as host (not `_acme-challenge.domain.name`) with 60sec TTL and the value provided by certbot.
Also configure the wildcard A record (A * ip)

### Create the PEM bundle in the ssl directory:
Exemple: `(cat ./letsencrypt/live/domain.name/privkey.pem && cat ./letsencrypt/live/domain.name/fullchain.pem) > ./letsencrypt/live/domain.name/bundle.pem`

### Edit `docker-compose.yml`:
- `MYSQL_ROOT_PASSWORD`
- SSL certificate path for Haproxy. Exemple: `./letsencrypt/live/domain.name/bundle.pem`

### Launch services:
`docker-compose up -d`

### Create wordpress database:
`docker exec -it mysql mysql -u root -p`\
`create database wordpress;`

### Edit `wp-config.php` or follow the installation setup at domain.name:
`docker exec -it wordpress bash`
```php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'root' );
define( 'DB_PASSWORD', 'SQL ROOT PASSWORD' );
define( 'DB_HOST', 'mysql' );

if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') {
   $_SERVER['HTTPS'] = 'on';
   $_SERVER['SERVER_PORT'] = 443;
}

@ini_set( 'upload_max_filesize' , '999M' );
@ini_set( 'post_max_size', '999M');
@ini_set( 'memory_limit', '999M' );
@ini_set( 'max_execution_time', '0' );
@ini_set( 'max_input_time', '0' );
```

### Edit .htaccess, add this at the end of the file

```
php_value upload_max_filesize 999M
php_value post_max_size 999M
php_value memory_limit 999M
php_value max_execution_time 0
php_value max_input_time 0
```

### Go to phpmyadmin `http://phpmyadmin.domain.name:8070`, use `root` user, in wordpress.wp_options edit `site_url` and `home` with the right domain name like `https://domain.name/`

### if needed, go to All in One WP migration extension to restore the backup
