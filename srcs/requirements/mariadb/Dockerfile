FROM alpine:3.17


RUN mkdir -p /run/mysqld
RUN mkdir -p /var/lib/mysql
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

COPY ./conf/create_db.sh /tmp/create_db.sh
RUN chown -R mysql:mysql /run/mysqld
RUN chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf;
    # tee 는 표준입력으로 받은 것을 표준 출력과 파일로 보낼 수 있다.
RUN  sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf
RUN mysql_install_db --user=mysql \
								--basedir=/usr \
								--datadir=/var/lib/mysql \
								--skip-test-db
EXPOSE 3306

RUN chmod +x /tmp/create_db.sh

EXPOSE 3306

ENTRYPOINT ["sh", "/tmp/create_db.sh"]
