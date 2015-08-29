FROM debian:squeeze

RUN apt-get update && apt-get install -y openssh-server wget git python python-pip curl mailtools
RUN mkdir /var/run/sshd
RUN echo 'root:teamcity' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN wget -O - http://nginx.org/keys/nginx_signing.key | apt-key add - && \
echo "deb http://nginx.org/packages/debian/ squeeze nginx" >> /etc/apt/sources.list


# main packages
RUN apt-get update && apt-get install -y apache2 apache2-mpm-itk bind9 nginx php5

RUN mkdir /etc/nginx/sites-available /etc/nginx/sites-enabled && \
echo "Listen 81" > /etc/apache2/ports.conf


# percona
RUN echo percona-server-server-5.5 percona-server-server/root_password password mysql_pass | debconf-set-selections && \
echo percona-server-server-5.5 percona-server-server/root_password_again password mysql_pass | debconf-set-selections && \
wget -O - http://www.percona.com/downloads/RPM-GPG-KEY-percona | apt-key add - && \
echo "deb http://repo.percona.com/apt squeeze main" >> /etc/apt/sources.list

RUN echo "[client]" >> /root/.my.cnf && \
echo "user=root" >> /root/.my.cnf && \
echo "password=mysql_pass" >> /root/.my.cnf
RUN apt-get update && apt-get install -y percona-server-server-5.5 percona-server-client-5.5

# composer
RUN echo "suhosin.executor.include.whitelist = phar" >> /etc/php5/cli/conf.d/suhosin.ini && \
curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer && \
ln -s /usr/local/bin/composer /usr/bin/composer

# drush
RUN git clone https://github.com/drush-ops/drush.git /usr/local/src/drush && \
cd /usr/local/src/drush && \
git checkout 7.x && \
ln -s /usr/local/src/drush/drush /usr/bin/drush && \
composer update && \
composer install

# bats
RUN git clone https://github.com/sstephenson/bats.git /usr/local/src/bats && \
cd /usr/local/src/bats && \
./install.sh /usr/local

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
