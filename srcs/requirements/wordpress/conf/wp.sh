
#wordpress cli command for install and config wordpress website
if [ ! -f "/var/www/html/index.php" ]; then
# install wordpress core file
  wp core download
#wp-config.php is wordpress config file
# dbname, username, passwd set and mariadb connection
  wp config create --dbhost=mariadb:3306 --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS}
# wordpress init config for website and root user
  wp core install --url=$WP_URL --title=$WP_TITLE \
                --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASS \
                --admin_email=$WP_ADMIN_MAIL --skip-email
# wordpress
  wp user create $WP_USER_NAME $WP_USER_MAIL --user_pass=$WP_USER_PASS
fi

#forground shell session not deamon
php-fpm81 -F
