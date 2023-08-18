FROM wordpress:latest
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN sed -i -e "s/post_max_size \= 8M/post_max_size \= 30M/g" "$PHP_INI_DIR/php.ini"
RUN sed -i -e "s/upload_max_filesize \= 2M/upload_max_filesize \= 20M/g" "$PHP_INI_DIR/php.ini"
RUN sed -i -e "s/session.gc_maxlifetime \= 1440/session.gc_maxlifetime \= 86400/g" "$PHP_INI_DIR/php.ini"
#change uid and gid of apache to docker user uid/gid
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data
ADD apache_conf/000-default.conf /etc/apache2/sites-available/000-default.conf
# enable apache module rewrite
RUN a2enmod proxy_http && a2enmod rewrite && a2enmod headers && a2enmod expires
RUN a2ensite 000-default.conf
