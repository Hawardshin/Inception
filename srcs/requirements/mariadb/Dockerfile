FROM alpine:3.17

#for mysql socket file
RUN mkdir -p /run/mysqld
RUN mkdir -p /var/lib/mysql
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client
RUN apk add --no-cache tini

COPY ./conf/create_db.sh /tmp/create_db.sh
RUN chown -R mysql:mysql /run/mysqld

RUN chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      #dns reverse lookup -> vaildate ip address off
      echo 'skip-name-resolve'; \
      # all ip connection allow
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf;
#maria db can connect with network
RUN  sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf
#mariadb directory init
# user : mysql , datadir : /var/lib/mysql ,
RUN mysql_install_db --user=mysql \
								--basedir=/usr \
								--datadir=/var/lib/mysql \
								--skip-test-db
EXPOSE 3306

RUN chmod +x /tmp/create_db.sh
ENTRYPOINT ["/sbin/tini", "--"]

CMD ["sh", "/tmp/create_db.sh"]
