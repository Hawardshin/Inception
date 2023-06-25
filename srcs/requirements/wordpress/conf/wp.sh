
# 워드프레스 CLI 명령어를 사용하여 워드프레스 웹사이트를 설치하고 설정하는 스크립트

if [ ! -f "/var/www/html/index.php" ]; then
# install wordpress core file
  wp core download
 # wp-config.php는 워드프레스 설정 파일.
# 데이터베이스 이름, 사용자 이름, 암호를 설정하고, 마리아디비 연결을 수행
  wp config create --dbhost=mariadb:3306 --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS}
# 워드프레스 초기 설정을 수행. 웹사이트와 루트 사용자에 대한 설정을 지정
  wp core install --url=$WP_URL --title=$WP_TITLE \
                --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASS \
                --admin_email=$WP_ADMIN_MAIL --skip-email
# 워드프레스에 새로운 사용자를 생성
  wp user create $WP_USER_NAME $WP_USER_MAIL --user_pass=$WP_USER_PASS
fi

#forground shell session not deamon
php-fpm81 -F
