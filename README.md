### Go to `first_run` directory and edit env values. 
`DOMAIN` must contain only one domain or subdomain.\
Exemple: `domain.com` or `sub.domain.com`

### Run `run.sh`
If you need multiples certificates (for subdomains for exemple) go back to the previous step and run the script again with new values.\
At least `domain.com` and `phpmyadmin.domain.com` are needed 

### Verification
Go back to repository root folder and verifiy that `./certs` contains files for your domain

### Edit `mysql.env` file

### Launch services:
`docker-compose up -d && docker ps`\
Make sure containers are up & running

### Go to `https://domain.com`
Wordpress should load broken but usable.\
Configure wordpress using db variables set in `mysql.env`.\
`DB_HOST` is `mysql`

### Edit `wp-config.php` and add the following code:
```php
if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') {
    $_SERVER['HTTPS'] = 'on';
    $_SERVER['SERVER_PORT'] = 443;
}
```
### Setup crontab for certs renewal
`sudo crontab -e`
Add 
```sh
0 1 * * * /path/to/renew.sh
```
Also fix the `ROOT_REPO_PATH` in renew.sh

### Done