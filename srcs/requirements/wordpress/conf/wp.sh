if [ ! -f "/var/www/html/index.php" ]; then
  wp core download

	wp config create --dbhost=mariadb:3306 --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS}
  wp core install --url=$WP_URL --title=$WP_TITLE \
                --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASS \
                --admin_email=$WP_ADMIN_MAIL --skip-email
  wp user create $WP_USER_NAME $WP_USER_MAIL --user_pass=$WP_USER_PASS
fi

php-fpm81 --nodaemonize
