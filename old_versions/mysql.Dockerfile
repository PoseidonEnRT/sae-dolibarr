FROM mysql:latest

WORKDIR /app

USER mysql

ENV MYSQL_USER=dolibarr
ENV MYSQL_PASSWORD=test123
ENV MYSQL_DATABASE=dolibarr

RUN touch /var/run/mysqld/mysqld.sock
RUN touch /var/run/mysqld/mysqld.pid
RUN chown -R mysql:mysql /var/run/mysqld/mysqld.sock
RUN chown -R mysql:mysql /var/run/mysqld/mysqld.pid
RUN chmod -R 644 /var/run/mysqld/mysqld.sock
RUN mysql -u root -p -e "CREATE USER '$MYSQL_USER'@'127.0.0.1' IDENTIFIED BY '$MYSQL_PASSWORD';"
RUN mysql -u root -p -e "CREATE DATABASE $MYSQL_DATABASE"
RUN mysql -u root -p -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'127.0.0.1';"
RUN mysql -u root -p -e "FLUSH PRIVILEGES;"

EXPOSE 3306
CMD ["mysqld"]